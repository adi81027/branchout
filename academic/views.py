# Create your views here.
from django.http import HttpResponse,Http404,HttpResponseRedirect
from django.core.urlresolvers import reverse
from django.shortcuts import *
from django.template.context import RequestContext
#from forms import UserForm,User_type_Form
#from academic.models import AssignToStudent
from django.views.generic.simple import direct_to_template
#from academic.models import AssignToStudent,Assignment

#def usertype(request):
#
#    if request.method=='POST':
#        l_form=User_type_Form(request.POST)
#        if request.POST.get('usertype','')=='1':
#            stu_form  = UserForm()
#            return HttpResponseRedirect('/academic/profile')
#        elif request.POST.get('usertype','')==2:
#            return render_to_response('academic/teacher_profile.html/',{'l_form':l_form},
#                context_instance = RequestContext(request) )
#    else:
#        l_form= User_type_Form()
#    return render_to_response('academic/user_type.html/',{'l_form':l_form},
#        context_instance = RequestContext(request) )
#
#def userform(request):
#    try:
#        data =  request.user.students_set.values('student_id','first_name','mid_name','last_name','email','dob',
#            'age','gender','institute','courses','classes')[0]
#    except :
#        data = {}
#    if request.method=='POST':
#        stu_form=UserForm(request.POST)
#        if stu_form.is_valid():
#            stu_form.save()
#            return render_to_response('academic/thankyou.html/',{'stu_form':stu_form},
#                context_instance = RequestContext(request) )
#        else:
#            errors=stu_form.errors
#            errmsg=""
#            for key,values in errors.items():
#                errmsg=errmsg+key+','
#            errmsg=errmsg+values[0]
#            return render_to_response('academic/student_profile.html/',locals(),
#                context_instance = RequestContext(request) )
#    else:
#        data['users']=request.user.id
#        stu_form= UserForm(data)
#    import pdb;pdb.set_trace()
#    return render_to_response('academic/student_profile.html/',{'stu_form':stu_form},
#        context_instance = RequestContext(request) )
#
#def assignment(request):
#     try:
#         enrol_status = request.user.students_set.values('is_enrolled')[0]
#         if(enrol_status.values()[0] == True):
#             assignments = Assignment.objects.filter\
#                        (assigntostudent__student=request.user.students_set.values('id')[0].values()[0])
#             passvalue = assignments.values('name','description','content','slug')
#             for each in passvalue:
#                 if each['content'] != '':
#                    each['content']=each['content'].split('/')[-1]
#
#             return render_to_response('academic/assignment.html',{'passvalue' : passvalue},
#                    context_instance = RequestContext(request))
#         else:
#             errmsg = "User enrollment not approved by admin"
#             #import pdb;pdb.set_trace()
#             return render_to_response('academic/userhome.html',{'errmsg':errmsg},
#                context_instance = RequestContext(request))
#     except Exception as e:
#         errmsg = "User profile not registered" + str(e)
#         return render_to_response('academic/userhome.html',{'errmsg':errmsg},
#                context_instance = RequestContext(request))
def  complete(request):
     return render_to_response('academic/complete.html',context_instance= RequestContext(request))

def  attempt(request):
    return render_to_response('academic/attempt.html',context_instance= RequestContext(request))



def assigndetails(request):
    if request.method == 'GET':
        pass
    return render_to_response('academic/assigndetails.html',
        context_instance = RequestContext(request))


def userprofile(request):
    return direct_to_template(request,'academic/userprofile.html')
