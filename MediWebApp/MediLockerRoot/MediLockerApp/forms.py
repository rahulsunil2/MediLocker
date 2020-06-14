from allauth.account.forms import SignupForm
from django import forms

# class CustomSignupForm(SignupForm):

#     sex_choices = [
#         ('M', 'Male'),
#         ('F', 'Female'),
#         ('O', 'Others')
#     ]

#     first_name       = forms.CharField(max_length=30, label='First Name')
#     last_name        = forms.CharField(max_length=30, label='Last Name')
#     sex              = forms.ChoiceField(choices=sex_choices, label='Sex')
#     phone            = forms.CharField(max_length=10, label='Phone No')
#     relative_name    = forms.CharField(max_length=25, label="Relative's Name")
#     relative_phone   = forms.CharField(max_length=10, label="Relative's Phone")
#     dob              = forms.DateField(label='Date of Birth')

#     def signup(self, request, user):
#         user.first_name        = self.cleaned_data['first_name']
#         user.last_name         = self.cleaned_data['last_name']
#         user.sex               = self.cleaned_data['sex']
#         user.phone             = self.cleaned_data['phone']
#         user.relative_name     = self.cleaned_data['relative_name']
#         user.relative_phone    = self.cleaned_data['relative_phone']
#         user.save()
#         return user
