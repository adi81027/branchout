from django.db import models
from django.contrib.auth.models import User
from questionnaire.models import Questionnaire
import datetime
class AssignQuestionnair(models.Model):
    selectquestionnaire = models.ForeignKey(Questionnaire)
    user = models.ForeignKey(User)
    date =  models.DateTimeField(auto_now_add=True)
    def __unicode__(self):
        return self.selectquestionnaire.name
    #    def __unicode__(self):
    #         return self.date.__str__()

    class Meta:
     verbose_name='Questionnaire'



