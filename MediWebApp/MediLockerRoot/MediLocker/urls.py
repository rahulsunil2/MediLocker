from django.contrib import admin
from django.urls import path, include # <--
from django.views.generic import TemplateView # <--
from rest_framework.authtoken import views as rest_views

urlpatterns = [
    path('', TemplateView.as_view(template_name="MediLockerApp/index.html")), # <--
    path('', include('MediLockerApp.urls')),
    path('admin/', admin.site.urls),
    path('accounts/', include('allauth.urls')), # <--
    path('api/', include('MediLockerApp.urls', namespace='MediLockerApp')),
    path('api-token-auth/', rest_views.obtain_auth_token, name='api-token-auth'),
]
