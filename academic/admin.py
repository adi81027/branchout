from django.contrib import admin
from academic.models import Institute
from academic.models import InstituteClass, InstituteCourse,InstituteSubjectMaster,InstituteSubjects, InstituteTeacher,TeacherSubjectClass
from academic.forms import InstituteAdminForm, InstituteClassAdminForm, InstituteClassSiteAdminForm 
from academic.forms import InstituteCourseAdminForm,InstituteCourseSiteAdminForm
from academic.forms import InstituteSubjectMasterAdminForm,InstituteSubjectMasterSiteAdminForm,InstituteTeacherAdminForm,InstituteTeacherAdminEditForm
from academic.forms import InstituteTeacherSiteAdminForm
from academic.models import *
from academic.models import AssignAssignment

class InstituteClassInline(admin.TabularInline):
    model = InstituteClass
    form = InstituteClassAdminForm
    extra = 0

class InstituteCourseInline(admin.TabularInline):
    model = InstituteCourse
    fieldsets = ((None,{
               'fields':('name','duration')}),
        )
    
    extra =0
    
class InstituteInline(admin.StackedInline):
    model = Institute
    form = InstituteAdminForm
    extra = 0
    max_num = 1
    fieldsets = ((None,{
               'fields':('name','emblem')}),
        ('Additional Details',{
                               'classes': ('collapse',),
                               'fields':('address','descp')
                               }
         ),
        )
    

class InstituteSubjectsInline(admin.TabularInline):
    model = InstituteSubjects
    extra =0
    fieldsets = ((None,{
                   'fields':('name','syllabus','subject_name','description')}), )    
    
    

class TeacherSubjectClassInline(admin.TabularInline):
    model = TeacherSubjectClass
    extra = 1
    
class InstituteAdmin(admin.ModelAdmin):
    form = InstituteAdminForm
    inlines = [ InstituteCourseInline,]
    fieldsets = ((None,{
                   'fields':('name','emblem')}),
            ('Additional Details',{
                                   'classes': ('collapse',),
                                   'fields':('address','descp')
                                   }
             ),
            )
    
    def save_model(self, request, obj, form, change):
        import datetime
        user = request.user.username
        instance = form.save(commit=False)
        if not change:
            instance.createdby = request.user.username
            instance.created_dt = datetime.date.today()
        else:
            instance.modifiedby = request.user.username
        
        instance.save()
        form.save_m2m()
        return instance
    
    def save_formset(self, request, form, formset, change):
        
        instances = formset.save(commit=False)
        import datetime
        user = request.user.username
        
        for instance in instances:
            if instance.pk == None: # to check if the instance is a new instance or a modified instance 
                instance.createdby = request.user.username
                instance.created_dt = datetime.date.today()
            else:
                instance.modifiedby = request.user.username
            instance.save()
                
        formset.save_m2m()
            
class InstituteCourseAdmin(admin.ModelAdmin):

    inlines = [ InstituteSubjectsInline,]
    list_display = ('name','duration','institute')
    
    
    def get_form(self, request, obj=None, **kwargs):
        self.form = InstituteCourseAdminForm
        return super(InstituteCourseAdmin,self).get_form(request, obj=None, **kwargs)

    def save_model(self, request, obj, form, change):
        import datetime
        user = request.user.username
        instance = form.save(commit=False)
        if not change:
            instance.createdby = request.user.username
            instance.created_dt = datetime.date.today()
        else:
            instance.modifiedby = request.user.username
        
        instance.save()
        return instance    
    
    def queryset(self, request):
        qs = super(InstituteCourseAdmin, self).queryset(request)
        if request.user.is_superuser:
            return qs
        else:
            return qs # This has been removed for branchout 
        
    def save_formset(self, request, form, formset, change):
        
        instances = formset.save(commit=False)
        import datetime
        user = request.user.username
        
        for instance in instances:
            if instance.pk == None: # to check if the instance is a new instance or a modified instance 
                instance.createdby = request.user.username
                instance.created_dt = datetime.date.today()
            else:
                instance.modifiedby = request.user.username
            instance.save()
                
        formset.save_m2m()
        
class InstituteStaffAdmin(admin.ModelAdmin):
    pass

class InstituteClassAdmin(admin.ModelAdmin):
    
    list_display = ('name','section','icourse','class_teacher')
    list_filter = ('name',)

    def get_form(self, request, obj=None, **kwargs):
        self.form = InstituteClassAdminForm
        
        # Few Lines have been removed for Branchout
            
        return super(InstituteClassAdmin,self).get_form(request, obj=None, **kwargs)

    def save_model(self, request, obj, form, change):
        import datetime
        user = request.user.username
        instance = form.save(commit=False)
        if not change:
            instance.createdby = request.user.username
            instance.created_dt = datetime.date.today()
        else:
            instance.modifiedby = request.user.username
        
        instance.save()
        return instance  
    
    def queryset(self, request):
        qs = super(InstituteClassAdmin, self).queryset(request)
        return qs
        
class InstituteSubjectMasterAdmin(admin.ModelAdmin):

    list_display = ('name',)
    list_filter = ('institute',)
    
    def get_form(self, request, obj=None, **kwargs):
        self.form = InstituteSubjectMasterAdminForm
        return super(InstituteSubjectMasterAdmin,self).get_form(request, obj=None, **kwargs)
        
    def save_model(self, request, obj, form, change):
        import datetime
        user = request.user.username
        
        instance = form.save(commit=False)

        if not change:
            instance.createdby = request.user.username
            instance.created_dt = datetime.date.today()
        else:
            instance.modifiedby = request.user.username
        
        instance.save()
        return instance
    
    def queryset(self, request):
        qs = super(InstituteSubjectMasterAdmin, self).queryset(request)
        return qs
        
class InstituteSubjectsAdmin(admin.ModelAdmin):
    fieldsets = ((None,{
               'fields':('name','syllabus','description','institute_course','subject_name')}),
        )
    list_display = ('name','institute_course','subject_name')
    list_filter = ('institute_course','subject_name')
    def queryset(self, request):
        qs = super(InstituteSubjectsAdmin, self).queryset(request)
        return qs
    
    def save_model(self, request, obj, form, change):
        import datetime
        user = request.user.username
        instance = form.save(commit=False)
        if not change:
            instance.createdby = request.user.username
            instance.created_dt = datetime.date.today()
        
        instance.save()
        return instance   

class InstituteTeacherAdmin(admin.ModelAdmin):
    
    inlines = [ TeacherSubjectClassInline,]
    
class EnrollmentAdmin(admin.ModelAdmin):
    pass


class AssignmentAdmin(admin.ModelAdmin):
    pass

class AssignmentUserAdmin(admin.ModelAdmin):
    pass
class SubmissionAdmin(admin.ModelAdmin):
    pass
class ResourcesAdmin(admin.ModelAdmin):
    pass
class BatchAdmin(admin.ModelAdmin):
    pass
class AssignAssignmentAdmin(admin.ModelAdmin):
    pass
    def save_model(self, request, obj, form, change):
    #       # import pdb;pdb.set_trace()
#        con2=request.user.email.__str__()
#        con =obj.user.email.__str__()
#        #        #    a =Template(content)
#        #         #    b = Context(locals())
#        #        #    d = a.render(beer)
#        msg = EmailMessage("aditya","questionnaire is assigned",con2,to=[con])
#        msg.content_subtype="html"
#        msg.send()
        obj.save()

class AssignAssignmentInstituteAdmin(admin.ModelAdmin):
    pass
def save_model(self, request, obj, form, change):
#       # import pdb;pdb.set_trace()
#        con2=request.user.email.__str__()
#        con =obj.user.email.__str__()
#        #        #    a =Template(content)
#        #         #    b = Context(locals())
#        #        #    d = a.render(beer)
#        msg = EmailMessage("aditya","questionnaire is assigned",con2,to=[con])
#        msg.content_subtype="html"
#        msg.send()
    obj.save()

class AssignAssignmentCourseAdmin(admin.ModelAdmin):
    pass
def save_model(self, request, obj, form, change):
#       # import pdb;pdb.set_trace()
#        con2=request.user.email.__str__()
#        con =obj.user.email.__str__()
#        #        #    a =Template(content)
#        #         #    b = Context(locals())
#        #        #    d = a.render(beer)
#        msg = EmailMessage("aditya","questionnaire is assigned",con2,to=[con])
#        msg.content_subtype="html"
#        msg.send()
    obj.save()

admin.site.register(Institute, InstituteAdmin)
admin.site.register(InstituteClass, InstituteClassAdmin)
admin.site.register(InstituteCourse, InstituteCourseAdmin)
admin.site.register(InstituteSubjectMaster,InstituteSubjectMasterAdmin)
admin.site.register(InstituteSubjects,InstituteSubjectsAdmin)
admin.site.register(InstituteTeacher,InstituteTeacherAdmin)
admin.site.register(Enrollment,EnrollmentAdmin)
admin.site.register(Assignment,AssignmentAdmin)
admin.site.register(Submission,SubmissionAdmin)
admin.site.register(Resources,ResourcesAdmin)
admin.site.register(Batch,BatchAdmin)
admin.site.register(AssignAssignment,AssignAssignmentAdmin)
admin.site.register(AssignAssignmentInstitute,AssignAssignmentInstituteAdmin)
admin.site.register(AssignAssignmentCourse,AssignAssignmentCourseAdmin)
