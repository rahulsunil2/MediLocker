from rest_framework import serializers
from rest_framework.validators import UniqueValidator
from django.contrib.auth.models import User
from .models import MedicalImageFile, UserProfile


class UserSerializer(serializers.ModelSerializer):
    email = serializers.EmailField(
        required=True,
        validators=[UniqueValidator(queryset=User.objects.all())]
    )
    username = serializers.CharField(
        max_length=25,
        validators=[UniqueValidator(queryset=User.objects.all())]
    )
    password = serializers.CharField(min_length=8, write_only=True)
    first_name = serializers.CharField(max_length=25)
    last_name = serializers.CharField(max_length=25)

    def create(self, validated_data):
        user = User.objects.create_user(
            validated_data['username'],
            validated_data['email'],
            validated_data['password']
        )
        print(validated_data)
        user.last_name = validated_data['last_name']
        user.first_name = validated_data['first_name']
        return user

    class Meta:
        model = User
        fields = ('id', 'username', 'email', 'password', 'first_name', 'last_name')


class UserGetSerializer(serializers.ModelSerializer):
    class Meta:
        model = User


class UserProfileSerializer(serializers.ModelSerializer):
    # user = UserGetSerializer(read_only=True)
    phone = serializers.IntegerField()
    dob = serializers.DateField()
    address = serializers.CharField()
    allergy = serializers.CharField()
    gender = serializers.CharField(max_length=6)
    blood_grp = serializers.CharField(max_length=3)
    height = serializers.IntegerField()
    weight = serializers.IntegerField()

    user = serializers.RelatedField(
        queryset=User.objects.all(), write_only=True)

    def to_internal_value(self, data):
        self.fields['user'] = serializers.PrimaryKeyRelatedField(
            queryset=User.objects.all())
        return super(UserProfileSerializer, self).to_internal_value(data)

    def create(self, validated_data):
        return UserProfile.objects.create(**validated_data)

    class Meta:
        model = UserProfile
        fields = '__all__'


class MedicalImageSerializer(serializers.ModelSerializer):

    class Meta:
        model = MedicalImageFile
        fields = ('file', 'description', 'uploaded_at', 'user')
