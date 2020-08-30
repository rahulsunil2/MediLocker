from django import forms
# from hall.middleware import get_current_session

class searchbar(forms.Form):
    searchbar = forms.CharField(label='Search', max_length=100)
class otp_f(forms.Form):
    otp_f = forms.IntegerField(label='')