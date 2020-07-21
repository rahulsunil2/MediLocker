from rest_framework.views import APIView
from .serializers import UserSerializer
from rest_framework.authtoken.models import Token

from rest_framework.response import Response
from rest_framework import status
from django.contrib.auth.models import User
from .models import UserProfile, MedicalImageFile, UserMedicalData
from django.views.decorators.csrf import csrf_exempt
from django.http import HttpResponse, JsonResponse, FileResponse
from .detect import OCRextract

# Create your views here.


class UserCreate(APIView):
    def post(self, request, format='json'):
        serializer = UserSerializer(data=request.data)
        if serializer.is_valid():
            user = serializer.save()
            if user:
                token = Token.objects.create(user=user)
                json = serializer.data
                json['token'] = token.key
                return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@csrf_exempt
def UserProfileCreate(request):
    if request.method == 'POST':
        user = User.objects.get(username=request.POST['user'])
        user.first_name = request.POST['firstName']
        user.last_name = request.POST['lastName']
        user.save()
        userProfiles = UserProfile.objects.filter(user=user)
        if len(userProfiles) == 0:
            userProfile = UserProfile(
                user=user,
                phone=request.POST['phone'],
                dob=request.POST['dob'],
                address=request.POST['address'],
                allergy=request.POST['allergy'],
                gender=request.POST['gender'],
                blood_grp=request.POST['blood_grp'],
                height=request.POST['height'],
                weight=request.POST['weight']
            )
            userProfile.save()
        else:
            userProfiles.update(
                phone=request.POST['phone'],
                dob=request.POST['dob'],
                address=request.POST['address'],
                allergy=request.POST['allergy'],
                gender=request.POST['gender'],
                blood_grp=request.POST['blood_grp'],
                height=request.POST['height'],
                weight=request.POST['weight']
            )

        return HttpResponse('<h1>Accepted</h1>')


@csrf_exempt
def MyFileView(request):
    if request.method == "POST":
        user = User.objects.get(username=request.POST['user'])
        med = MedicalImageFile(
            file=request.FILES['file'],
            description=request.POST['description'],
            user=user,
            extraction_status="NotDone",
            type=request.POST['type'],
            category=request.POST['category'],
            record_date=request.POST['date']
        )
        med.save()
        data = OCRextract(str(med.file))
        userData = UserMedicalData(
            user=user,
            original_file=med,
            extracted_data=data
        )
        med.extraction_status = "Done"
        med.save()
        userData.save()

        return HttpResponse('<h1>Accepted</h1>')


@csrf_exempt
def UserProfileView(request):
    if request.method == 'POST':
        users = User.objects.filter(username=request.POST['username'])
        if len(users) == 1:
            userProfiles = UserProfile.objects.filter(user=users[0])
            if len(userProfiles) == 0:
                context = {
                    'data': 'Not Available'
                }
            else:
                userProfile = userProfiles[0]
                context = {
                    'data': 'Available',
                    'phone': str(userProfile.phone),
                    'dob': userProfile.dob.strftime("%d %b, %Y"),
                    'address': userProfile.address,
                    'allergy': userProfile.allergy,
                    'gender': userProfile.gender,
                    'blood_grp': userProfile.blood_grp,
                    'height': str(userProfile.height),
                    'weight': str(userProfile.weight)
                }
        else:
            context = {
                'data': 'Not Available'
            }

        return JsonResponse(context)


@csrf_exempt
def getMedicalRecord(request):
    if request.method == 'POST':
        user = User.objects.get(username=request.POST['user'])
        recordType = request.POST['type']
        category = request.POST['category']
        medicalRecords = MedicalImageFile.objects.filter(user=user, type=recordType, category=category)
        records = []
        for record in medicalRecords:
            extracted_data = UserMedicalData.objects.get(original_file=record).extracted_data
            tempJson = {
                'file': str(record.file),
                'description': record.description,
                'record_date': record.record_date,
                'extracted_data': extracted_data
            }
            records.append(tempJson)

        return JsonResponse({'data': records})


@csrf_exempt
def getMedicalImage(request):
    if request.method == 'POST':
        fileName = 'media/' + request.POST['filename']
        img = open(fileName, 'rb')
        return FileResponse(img)
