# Generated by Django 3.0.7 on 2020-07-09 17:36

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('MediCareApp', '0006_auto_20200707_2146'),
    ]

    operations = [
        migrations.CreateModel(
            name='UserMedicalData',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('extracted_data', models.TextField()),
                ('uploaded_time', models.DateTimeField(auto_now_add=True)),
                ('original_file', models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, to='MediCareApp.MedicalImageFile')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]
