from django.db import models
from django.contrib.auth.models import User

# Create your models here.


class MedicalImageFile(models.Model):
    id = models.BigAutoField(primary_key=True)
    file = models.FileField(blank=False, null=False)
    description = models.CharField(max_length=255)
    user = models.CharField(max_length=25)
    uploaded_at = models.DateTimeField(auto_now_add=True)


class UserProfile(models.Model):
    user = models.CharField(max_length=25)
    phone = models.IntegerField(blank=True)
    dob = models.DateField(blank=True)
    address = models.TextField(blank=True)
    allergy = models.TextField(blank=True)
    gender = models.CharField(max_length=6, blank=True)
    blood_grp = models.CharField(max_length=3, blank=True)
    height = models.IntegerField(blank=True)
    weight = models.IntegerField(blank=True)

    def __str__(self):
        return self.user + "'s Profile"
