from django.urls import path
from .views import UserRecordView, userDetails

app_name = 'MediLockerApp'
urlpatterns = [
    path('user/', UserRecordView.as_view(), name='users'),
    path('personal', userDetails, name='personal'),
    path('api-create', views.UserCreateAPIView.as_view())
]