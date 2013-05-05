from questn.models import AssignQuestionnair
from django import forms
from questionnaire.models import Questionnaire

from django.contrib.auth.models import User

class QuestionnaireForm(forms.ModelForm):
    # users = forms.IntegerField(widget=forms.TextInput(attrs={'readonly':'readonly'}))
    class Meta:
        model =AssignQuestionnair