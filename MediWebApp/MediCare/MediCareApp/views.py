from rest_framework.views import APIView
from .serializers import UserSerializer, UserProfileSerializer
from rest_framework.authtoken.models import Token

from rest_framework.parsers import MultiPartParser, FormParser
from rest_framework.response import Response
from rest_framework import status
from .serializers import MedicalImageSerializer
from django.contrib.auth.models import User
from .models import UserProfile, MedicalImageFile
from django.views.decorators.csrf import csrf_exempt
from django.http import HttpResponse


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


# class UserProfileCreate(APIView):
#     def post(self, request, format='json'):
#         serializer = UserProfileSerializer(data=request.data)
#         if serializer.is_valid():
#             serializer.save()
#             return Response(serializer.data, status=status.HTTP_201_CREATED)
#         return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@csrf_exempt
def UserProfileCreate(request):
    if request.method == 'POST':
        user = UserProfile(
            user=User.objects.get(username=request.POST['user']),
            phone=request.POST['phone'],
            dob=request.POST['dob'],
            address=request.POST['address'],
            allergy=request.POST['allergy'],
            gender=request.POST['gender'],
            blood_grp=request.POST['blood_grp'],
            height=request.POST['height'],
            weight=request.POST['weight']
        )
        user.save()
        return HttpResponse('<h1>Accepted</h1>')


@csrf_exempt
def MyFileView(request):
    if request.method == "POST":
        med = MedicalImageFile(
            file=request.FILES['file'],
            description=request.POST['description'],
            user=User.objects.get(username=request.POST['user'])
        )
        med.save()
        return HttpResponse('<h1>Accepted</h1>')

# class MyFileView(APIView):
#     parser_classes = (MultiPartParser, FormParser)
#
#     def post(self, request, *args, **kwargs):
#         print(request.data)
#         file_serializer = MedicalImageSerializer(data=request.data)
#         if file_serializer.is_valid():
#             file_serializer.save()
#             return Response(file_serializer.data, status=status.HTTP_201_CREATED)
#         else:
#             return Response(file_serializer.errors, status=status.HTTP_400_BAD_REQUEST)
