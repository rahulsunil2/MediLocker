from django.urls import path, include
from . import views


urlpatterns = [
    path('create_user', views.UserCreate.as_view(), name='account-create'),
    path('medicalrecord/', views.MyFileView, name='medical-record'),
    path('api_userprofile', views.UserProfileCreate, name='userprofile-create'),
    path('userprofile_get', views.UserProfileView, name='get-userprofile'),
    path('medicaldata_get', views.getMedicalRecord, name='get_medicaldata'),
    path('medicalimage_get', views.getMedicalImage, name='get_medicalimage'),
    path('',views.name,name="name"),
    path('otp/',views.otp,name="otp"),
    path('dashboard/',views.dashboard,name="dashboard"),
]
