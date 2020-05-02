from django.db import models
from django.contrib.auth.models import User

class PersonalRecord(models.Model):
    sex_choices = [
        ('M', 'Male'),
        ('F', 'Female'),
        ('O', 'Others')
    ]
    username = models.ForeignKey(User, models.CASCADE)
    sex = models.CharField(max_length=5, choices=sex_choices)
    phone = models.CharField(max_length=10)
    relative_name = models.CharField(max_length=25)
    relative_phone = models.CharField(max_length=10)

class MedicalRecord(models.Model):

    blood_grp_choices = [
        ('A+', 'A+ve'),
        ('A-', 'A-ve'),
        ('B+', 'B+ve'),
        ('B-', 'B-ve'),
        ('O+', 'O+ve'),
        ('O-', 'O-ve'),
        ('AB+', 'AB+ve'),
        ('AB-', 'AB-ve'),
    ]
    username = models.ForeignKey(User, models.CASCADE)
    blood_grp = models.CharField(max_length=3, choices=blood_grp_choices)
    height = models.PositiveIntegerField()
    weight = models.PositiveIntegerField()
    bmi = models.DecimalField(max_digits=5, decimal_places=2)
    bpi = models.CharField(max_length=7)
    cholestrol = models.CharField(max_length=3)