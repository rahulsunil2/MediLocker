from django.db import models
from django.contrib.auth.models import User

# Create your models here.


class MedicalImageFile(models.Model):
    id = models.BigAutoField(primary_key=True)
    file = models.FileField(blank=False, null=False)
    description = models.CharField(max_length=255)
    user = models.CharField(max_length=25)
    uploaded_at = models.DateTimeField(auto_now_add=True)
