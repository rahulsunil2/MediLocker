from django.contrib import admin
from django.contrib.admin.decorators import register
from .models import MedicalImageFile, UserProfile, UserMedicalData

# Register your models here.


@register(MedicalImageFile)
class MedicalImageAdmin(admin.ModelAdmin):
    list_display =['file', 'description', 'user', 'extraction_status', 'type', 'category', 'record_date', 'uploaded_at']


@register(UserProfile)
class UserProfileAdmin(admin.ModelAdmin):
    list_display = ['user', 'phone', 'dob', 'address', 'allergy', 'gender', 'blood_grp', 'height', 'weight']


@register(UserMedicalData)
class MedicalDataAdmin(admin.ModelAdmin):
    list_display = ['user', 'original_file', 'extracted_data', 'uploaded_time']