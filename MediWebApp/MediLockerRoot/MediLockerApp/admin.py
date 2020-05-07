from django.contrib import admin
from .models import PersonalRecord, MedicalRecord

# Register your models here.
admin.site.register(PersonalRecord)
admin.site.register(MedicalRecord)
