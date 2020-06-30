from django.urls import path, include
from . import views


urlpatterns = [
    path('create_user', views.UserCreate.as_view(), name='account-create'),
    path('medicalrecord/', views.MyFileView.as_view(), name='medical-record'),
]
