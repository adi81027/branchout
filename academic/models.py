from django.db import models
from django.contrib.auth.models import User
from django.contrib.sites.models import Site
from academic.managers import InstituteManager , InstituteClassManager
#from easy_thumbnails.fields import ThumbnailerImageField
from thumbs import ImageWithThumbsField
from questionnaire.models import Questionnaire

from django.db.models.signals import post_delete

# Master Tables would be entered First .



class BaseTableCore(models.Model):
    created_dt = models.DateTimeField()
    created_by = models.CharField(max_length = 30)
    
    class Meta:
        abstract = True
    
    
    
# Create your models here.


class Institute(BaseTableCore):
    '''
    Model to Store the Institute Detail 
    '''
    name = models.CharField(max_length = 100, ) # name of the institute / school / college
    #contact_person = models.CharField(max_length = 30)  # contact name in the school
    #contact_email = models.EmailField() # email of the institute where the emails can be recieved if the student requests for 
                                # information
    inst_user = models.ForeignKey(User,blank=True, null=True, on_delete=models.SET_NULL) # User whose type should be institute
    address = models.CharField(max_length = 50) # Address of the Institute 
    descp = models.TextField(max_length =100)
    modifiedon = models.DateTimeField(auto_now_add = True)
    modifiedby = models.CharField(max_length = 30)
    emblem = ImageWithThumbsField(upload_to='uploads',  sizes=((50,50),(100,100)),blank=True)
    
    objects = models.Manager()
    inst_mgr = InstituteManager()

    def __unicode__(self):
        return self.name


class InstituteCourse(BaseTableCore):
    
    name = models.CharField(max_length = 50,)
    description = models.TextField(max_length =100) # Syllabus for a Course or Detailed Description of Any thing about the course can be written here
    duration = models.IntegerField(choices=[(i,i) for i in range(1,49)])
    institute = models.ForeignKey(Institute)
    
    def __unicode__(self):
        return self.name

class InstituteSubjectMaster(BaseTableCore):
    name = models.CharField(max_length=20)
    institute = models.ForeignKey(Institute)
    
    def __unicode__(self):
        return self.name

class InstituteSubjects(BaseTableCore):
    
    name = models.CharField(max_length = 50,)
    description = models.TextField(help_text="Put Syllabus and additional content here")
    syllabus = models.TextField()
    institute_course = models.ForeignKey(InstituteCourse)
    subject_name = models.ForeignKey(InstituteSubjectMaster)
    
    def __unicode__(self):
        return self.name

class InstituteTeacher(BaseTableCore):
    user = models.ForeignKey(User,related_name='InstituteTeacher',blank=True,null=True)
    name = models.CharField(max_length=20)
    description = models.TextField()
    subjects = models.ManyToManyField(InstituteSubjects,through='TeacherSubjectClass')
    
    objects = models.Manager()
    
    
    def __unicode__(self):
        return self.user.username
    
            
class InstituteClass(BaseTableCore):
    '''
    Model to store the class room information against each institute that is registered.
    '''
    name = models.CharField(max_length = 100)
    icourse = models.ForeignKey(InstituteCourse)
    section = models.CharField(max_length = 2)
    details = models.TextField()
    class_teacher =models.ForeignKey(InstituteTeacher,blank=True, null=True, on_delete=models.SET_NULL)
    modified_dt = models.DateTimeField(auto_now_add = True)
    modified_by = models.CharField(max_length = 30)
    
    objects = models.Manager()
    iclass_mgr = InstituteClassManager()
    
    class Meta:
        ordering = ['name','section']
    
    def __unicode__(self):
        return self.name+'-'+self.section
    


class TeacherSubjectClass(models.Model):
    iteacher = models.ForeignKey(InstituteTeacher)
    isubject = models.ForeignKey(InstituteSubjects)
    iclass = models.ForeignKey(InstituteClass)
    
    def __unicode__(self):
        return str(self.iclass)+ '-' + str(self.isubject) + '-' + str(self.iteacher)
    
class Resources(BaseTableCore):
    title = models.CharField(max_length=50)
    url = models.URLField(blank=True,null=True)
    descp = models.TextField()
    
    def __unicode__(self):
        return self.title

class Batch(BaseTableCore):
    title = models.CharField(max_length=20)
    start_dt = models.DateField()
    end_dt = models.DateField()
    status = models.BooleanField() # If 1 Then Batch Active if 0 then Batch Inactive
    
    def __unicode__(self):
        self.title
        
ENROLLMENT_ACCESS = (
    (1, 'Normal'),
    (2, 'Active'),
    (3, 'Disabled'),
)

class Enrollment(BaseTableCore):
    user = models.ForeignKey(User,related_name='Enrollment',blank=True,null=True,on_delete=models.SET_NULL)
    iclass = models.ForeignKey(InstituteClass,blank=True,null=True,on_delete=models.SET_NULL )
    access_mode = models.IntegerField('Access Mode', max_length=15, choices=ENROLLMENT_ACCESS, default='Normal',
    help_text="Normal: User granted access at start_date for course.length or length_override if specified." +
    "<br />Active: User granted access indefinitely, or until this flag is changed." +
    "<br />Disabled: User denied access indefinitely, or until this flag is changed.")
    batch = models.ForeignKey(Batch,blank=True,null=True,on_delete=models.SET_NULL)
    
    def __unicode__(self):
        return str(self.user)+ '-' + str(self.batch)
def filepath(instance,file):
#    import pdb;pdb.set_trace()
    return 'uploads/assignmentfiles/%s'%(file)

#class Questionnairegroup(BaseTableCore):
#
#    iqustionnaire=models.ForeignKey(Questionnaire)
#    iassignment=models.ForeignKey(Assignment)
#
#    def __unicode__(self):
#        return str(self.iassignment)+ '-' + str(self.iqustionnaire)


class Assignment(BaseTableCore):
    title = models.CharField(max_length=50)
    descp = models.TextField()
    points = models.IntegerField()
    apply_due_date = models.DateField()
    allow_late = models.BooleanField()  # If 1 Then Allowed late Submission , if 0 then late submission is not allowed.
    disable_submission = models.BooleanField() # If 1 then Submission is disabled , if 0 submission is enabled. 
    subject = models.ForeignKey(InstituteSubjects,blank=True,null=True) # Assignment can be without a subject also. hence kept null true , blank true
    assignmentfile=models.FileField(upload_to=filepath,blank=True)
    questionnaire=models.ManyToManyField(Questionnaire,blank=True,null=True)

#    object=models.Manager

    def __unicode__(self):
        return self.title



class AssignmentUser(models.Model):
    assignment = models.ForeignKey(Assignment)
    enrollment = models.ForeignKey(Enrollment)
    user = models.ForeignKey(User,related_name='AssignmentUser',blank=True, null=True,on_delete=models.SET_NULL)
    
    def __unicode__(self):
        self.assignment

class AssignAssignment(models.Model):
    selectassignment=models.ForeignKey(Assignment)
    user=models.ForeignKey(AssignmentUser)
    date=models.DateTimeField(auto_now_add=True)
    def __unicode__(self):
        self.selectassignment.name
    class Meta:
        verbose_name='Assign Assignment'

class AssignAssignmentInstitute(models.Model):
    selectassignment=models.ForeignKey(Assignment)
    Institute=models.ForeignKey(Institute)
    date=models.DateTimeField(auto_now_add=True)
    def __unicode__(self):
        self.selectassignment.name
    class Meta:
        verbose_name='Assignment Institute Wise'

class AssignAssignmentCourse(models.Model):
    selectassignment=models.ForeignKey(Assignment)
    Institute=models.ForeignKey(Institute)
    InstituteCourse=models.ForeignKey(InstituteCourse)
    date=models.DateTimeField(auto_now_add=True)
    def __unicode__(self):
        self.selectassignment.name
    class Meta:
        verbose_name='Assignment Course Wise'

class Submission(BaseTableCore):
    user = models.ForeignKey(User,related_name='Submission',blank=True,null=True,on_delete=models.SET_NULL)
    assignmentuser = models.ForeignKey(AssignmentUser)
    submit_dt = models.DateField()
    on_time = models.BooleanField() # if 1 it means the submission was on time , 0 submission was delayed 
    points_earned = models.IntegerField()
    descp = models.TextField()
    
    def __unicode__(self):
        self.user



def del_regprofileobj(sender,**kwargs):
    obj = kwargs['instance']
    regprofileobj = obj.user
    regprofileobj.delete()

post_delete.connect(del_regprofileobj,sender=InstituteTeacher)
