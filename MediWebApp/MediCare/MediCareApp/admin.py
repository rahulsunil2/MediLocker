from django.contrib import admin
from .models import MedicalImageFile, UserProfile

# Register your models here.

admin.site.register(MedicalImageFile)
admin.site.register(UserProfile)