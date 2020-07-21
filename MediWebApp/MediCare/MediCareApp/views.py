from rest_framework.views import APIView
from .serializers import UserSerializer, UserProfileSerializer
from rest_framework.authtoken.models import Token

from rest_framework.parsers import MultiPartParser, FormParser
from rest_framework.response import Response
from rest_framework import status
from .serializers import MedicalImageSerializer
from django.contrib.auth.models import User
from .models import UserProfile, MedicalImageFile, UserMedicalData
from django.views.decorators.csrf import csrf_exempt
from django.http import HttpResponse
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
        users = User.objects.filter(username=request.POST['user'])
        if len(users) == 0:
            userProfile = UserProfile(
                user=users[0],
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
            users.update(
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
