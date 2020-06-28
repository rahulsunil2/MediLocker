from django.contrib import admin
from django.conf.urls import include
from django.urls import path
from rest_framework.authtoken import views as rest_views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('users/', include('MediCareApp.urls')),
    path('api-token-auth/', rest_views.obtain_auth_token, name='api-token-auth')
]
