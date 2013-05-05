from django.db import models

class InstituteManager( models.Manager):
    
    def get_institute_byid(self,id):
        try:
            #inst_obj = super(InstituteManager, self).get_query_set().filter(id=id)
            inst_obj = self.get(id=id)
            return inst_obj
        except:
            return None 
    
        
class InstituteClassManager(models.Manager):
    
    
    def get_institute_classes_byinst(self,inst_obj):
        pass
    
    def get_institute_classes_byinst_as_list(self,inst_obj):
        pass