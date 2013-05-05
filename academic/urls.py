from django.conf.urls.defaults import patterns, include, url

# Uncomment the next two lines to enable the admin:
from django.contrib import admin
from django.views.generic.simple import direct_to_template
import academic
admin.autodiscover()

urlpatterns = patterns('academic.views',
    url(r'uh/$',direct_to_template,{'template': 'academic/userhome.html'},
        name='userhome'),
    #url(r'uf/$','userform'),
#    url(r'ut/$','usertype'),
#    url(r'profile/$','userform',
#            name='profile'),
#    url(r'assign/$','assignment',
#        name='view_assignment'),
#    url(r'^assigndet/$','assigndetails',
#        name='assigndetails'),
)

#urlpatterns += patterns('',
#    url(r'^admin/', include(admin.site.urls)),
#)
