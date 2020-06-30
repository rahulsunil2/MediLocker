# Generated by Django 3.0.7 on 2020-06-30 22:59

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('MediCareApp', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='MedicalImageFile',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('file', models.FileField(upload_to='')),
                ('description', models.CharField(max_length=255)),
                ('uploaded_at', models.DateTimeField(auto_now_add=True)),
            ],
        ),
    ]
