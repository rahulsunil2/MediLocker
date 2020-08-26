from rest_framework.views import APIView
from .serializers import UserSerializer
from rest_framework.authtoken.models import Token
from django.shortcuts import render,redirect
from django.http import HttpResponse,HttpResponseRedirect
from rest_framework.response import Response
from rest_framework import status
from django.contrib.auth.models import User
from .models import UserProfile, MedicalImageFile, UserMedicalData
from django.views.decorators.csrf import csrf_exempt
from django.http import HttpResponse, JsonResponse, FileResponse
from .detect import OCRextract
import json
from .forms import *
from random import randint

from django.contrib.sites.models import Site
from django.utils.http import urlsafe_base64_encode, urlsafe_base64_decode
from django.template.loader import render_to_string
from django.utils.encoding import force_bytes, force_text
from django.core.mail import EmailMessage
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
        print(request.POST)
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
                'extracted_data': json.dumps(extracted_data)
            }
            records.append(tempJson)

        print(records)
        return JsonResponse({'data': records})


@csrf_exempt
def getMedicalImage(request):
    if request.method == 'POST':
        fileName = 'media/' + request.POST['filename']
        img = open(fileName, 'rb')
        return FileResponse(img)

def name(request):
    if 'name' in request.POST: #get time and redirect to next page
        oid = searchbar(request.POST)
        if oid.is_valid():
            request.session['u_id'] = User.objects.get(username=oid.cleaned_data['searchbar']).id
            # for sending mail
            otp=randint(100000, 999999)
            request.session['otp']=otp
            body = render_to_string('ver_email.html', {
            'otp':otp
            })
            print(body) 
            subject = "Verify Hall booking"
            to_mail = User.objects.get(username=oid.cleaned_data['searchbar']).email
            mail = EmailMessage(subject,body,to=[to_mail])
            mail.send()
            return HttpResponseRedirect('/otp')
    return render(request,'name.html',{'form':searchbar()})

def otp(request):
    if 'otp' in request.POST: #get time and redirect to next page
        oid = otp_f(request.POST)
        # print(int(oid.cleaned_data.get("otp_f") ))
        if oid.is_valid() and int(oid.cleaned_data['otp_f'])==request.session['otp'] :
            request.session['otp_i'] = int(oid.cleaned_data['otp_f'])
            return HttpResponseRedirect('/dashboard')
        elif oid.cleaned_data['otp_f']!=request.session['otp']:
            return render(request,'otp.html',{'form':otp_f(),'message':True})
    return render(request,'otp.html',{'form':otp_f(),'message':False})

def dashboard(request):
    if(request.session['otp_i']==request.session['otp']):
        userr=User.objects.get(pk=int(request.session['u_id']))
        user_profile=UserProfile.objects.get(user=userr)
        med_rec=UserMedicalData.objects.filter(user=userr)
        request.session['otp_i']=0
        request.session['otp']=randint(100000, 999999)
        return render(request,'dashboard.html',{'user':userr,'user_profile':user_profile,'med_rec':med_rec})
    else:
        return HttpResponseRedirect('/name')


