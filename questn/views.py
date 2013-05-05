from django.http import HttpResponse,Http404,HttpResponseRedirect
from django.core.urlresolvers import reverse
from django.shortcuts import *
from django.template.context import RequestContext
from forms import QuestionnaireForm
from questn.models import AssignQuestionnair
from django.contrib.auth.models import User
from questionnaire.models import Questionnaire

def questionnaire(request):

    l_form = QuestionnaireForm(request.POST)
    if request.user.id==4:

        return render_to_response('myaccount.html',context_instance = RequestContext(request))
    else:

        return render_to_response('myaccountstudent.html', context_instance = RequestContext(request))


def assignquestionnaire(request):


     if  request.user.id==4:
        import pdb;pdb.set_trace()

        if request.method == 'POST':
            l_form = QuestionnaireForm(request.POST)

            if l_form.is_valid():
               # import pdb;pdb.set_trace()

        # Create a new Signature object.

                l_form.save()


                return render_to_response('thanx.html',
                                             context_instance=RequestContext(request))



        else:

             l_form = QuestionnaireForm()
             return render_to_response('assign_questionnair.html',
                {'l_form' : l_form }, context_instance = RequestContext(request))
     else:
            # import pdb;pdb.set_trace()
        return HttpResponseRedirect('details/')
        # attempt=request.user.assignquestionnair_set.values()[0]
       #         return render_to_response('attempt_questionnaire.html',{'attempt':attempt},
       #                                    context_instance=RequestContext(request))
def attemptquestionnaire(request):


    l_form = QuestionnaireForm(request.POST)

   # import pdb;pdb.set_trace()
    try:
            attempt=request.user.assignquestionnair_set.values('selectquestionnaire__name','date')
    except :
        return render_to_response('attempt_questionnaire.html',{'attempt':('There are no Questionnaire')},
            context_instance=RequestContext(request))


    return render_to_response('attempt_questionnaire.html',{'attempt':attempt},
        context_instance=RequestContext(request))

def createquestionnaire(request):

#import pdb;pdb.set_trace()
# l_form = QuestionnaireForm(request.POST)
    l_form1 = Questionnaire.objects.all()
    return  render_to_response('create_questionnaire.html',{'l_form1':l_form1},
        context_instance=RequestContext(request))


def viewquestionnaire(request):

    l_form2 = Questionnaire.objects.all()
    return  render_to_response('view_questionnaire.html',{'l_form2':l_form2},
        context_instance=RequestContext(request))

   # return render_to_response('view_questionnaire.html')
def completequestionnaire(request):


    return render_to_response('complete_questionnaire.html',context_instance=RequestContext(request))