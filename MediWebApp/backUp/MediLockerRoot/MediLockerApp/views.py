from .serializers import UserSerializer
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from rest_framework.permissions import IsAdminUser
from django.contrib.auth.models import User
import google.cloud
import firebase_admin
from firebase_admin import credentials, firestore, initialize_app
from django.shortcuts import render
from django.contrib.auth.models import User

class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer

class UserCreateAPIView(generics.CreateAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    permission_classes = (AllowAny,)

class UserRecordView(APIView):
    """
    API View to create or get a list of all the registered
    users. GET request returns the registered users whereas
    a POST request allows to create a new user.
    """
    permission_classes = [IsAdminUser]

    def get(self, format=None):
        users = User.objects.all()
        serializer = UserSerializer(users, many=True)
        return Response(serializer.data)

    def post(self, request):
        serializer = UserSerializer(data=request.data)
        if serializer.is_valid(raise_exception=ValueError):
            serializer.create(validated_data=request.data)
            return Response(
                serializer.data,
                status=status.HTTP_201_CREATED
            )
        return Response(
            {
                "error": True,
                "error_msg": serializer.error_messages,
            },
            status=status.HTTP_400_BAD_REQUEST
        )

def userDetails(request):
    if not firebase_admin._apps:
        cred = credentials.Certificate("MediLockerApp/credentials/medilocker-thingqbator-firebase-adminsdk-pw7jt-6dd0f5bb45.json")
        app = initialize_app(cred)
    store = firestore.client()
    username = request.user.get_username()
    details = store.collection(u'usersDetails').document(username)
    doc = details.get()
    if doc.exists:
        user_details = doc.to_dict()
    else:
        user_details = {
            'username'       : username, 
            'phone'          : 'Not Defined', 
            'sex'            : 'Not defined', 
            'relative_name'  : 'Not defined',
            'relative_phone' : 'Not defined',
            'dob'            : 'Not defined',
            'blood_grp'      : 'Not defined',
            'height'         : 'Not defined',
            'weight'         : 'Not defined',
            'bpi'            : 'Not defined',
            'cholestrol'     : 'Not defined',
            'blood_sugar'    : 'Not defined',
            'blood_count'    : 'Not defined',
            }

    print(user_details)

    return render(request, 'MediLockerApp/personal.html', user_details)
