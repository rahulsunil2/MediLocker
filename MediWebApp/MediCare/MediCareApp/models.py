from django.db import models
from django.contrib.auth.models import User

# Create your models here.


class MedicalImageFile(models.Model):
    file = models.FileField(blank=False, null=False)
    description = models.CharField(max_length=255)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    uploaded_at = models.DateTimeField(auto_now_add=True)
