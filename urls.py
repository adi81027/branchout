from django.conf.urls.defaults import patterns, include, url
from django.contrib import admin
from django.views.generic.simple import direct_to_template
from django.views.generic import ListView
from django.conf import settings
from django.views.generic import TemplateView

from questionnaire.models import Question
from django.contrib.auth.models import User


admin.autodiscover()

# Uncomment the next two lines to enable the admin:
# from django.contrib import admin
# admin.autodiscover()

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'branchout.views.home', name='home'),
    # url(r'^branchout/', include('branchout.foo.urls')),

    # Uncomment the admin/doc line below to enable admin documentation:
    # url(r'^admin/doc/', include('django.contrib.admindocs.urls')),

    # Uncomment the next line to enable the admin:
    # url(r'^admin/', include(admin.site.urls)),
)


#admin url patterns
urlpatterns += patterns('',
                       # url(r'^admin/Assignment/$',include(admin.site.urls)),
                       url(r'^admin/prefrences/', TemplateView.as_view(template_name="admin/prefrences/prefrences.html")),
                       url(r'^admin/', include(admin.site.urls)),


#                        url(r'^admin/', include('django.contrib.admin.urls')),

)

#media url patterns. 
urlpatterns += patterns('',
                        
                        url( r'^media/(?P<path>.*)$', 'django.views.static.serve', {'document_root': settings.MEDIA_ROOT } ),
                        
                        )

urlpatterns += patterns('',
    url(r'^academic/',include('academic.urls')),
    url(r'^completeassignment/$','academic.views.complete',name='completeassignment'),
    url(r'^attemptassignment/', 'academic.views.complete',name='completeassignment'),
#
    (r'^accounts/', include('registration.backends.default.urls')),
    (r'^$', direct_to_template,
         { 'template': 'index.html' }, 'index'),
)


urlpatterns += patterns('',
    url(r'^myaccount/$', 'questn.views.questionnaire', name='myaccount'),

#    url(r'^myaccountstudent/$', direct_to_template,
#        { 'template': 'myaccountstudent.html' }, 'myaccountstudent')
     )

#
#urlpatterns += patterns('',
#
#    (r'^q/',include('questionnaire.urls')),
#    #(r'^$', direct_to_template,{'template':'index.html'}, 'index'),
#    (r'^user/$', ListView.as_view(
#        model=User,
#        template_name = 'userdetails.html',
#    )),
#    url(r'^h/$', direct_to_template,{'template':'home.html'},name='home'),
#    url(r'^assign/$','questn.views.Questionnaire',name='view_Questionnair'),
#    url(r'^pro/$', direct_to_template,{'template':'profile.html'},name='profile'),
#   # url(r'^user/$', direct_to_template,{'template':'userdetails.html'},name='userdetails'),
#    # questionnaire urls
#   # url(r'^q/', include('questionnaire.urls')),
#
#    url(r'^take/(?P<questionnaire_id>[0-9]+)/$', 'questionnaire.views.generate_run'),
#    url(r'^qi/$', 'questionnaire.page.views.page', {'page' : 'index'}),
#    url(r'^(?P<page>.*)\.html$', 'questionnaire.page.views.page'),
#    url(r'^(?P<lang>..)/(?P<page>.*)\.html$', 'questionnaire.page.views.langpage'),
#    url(r'^setlang/$', 'questionnaire.views.set_language'),
 #    (r'^accounts/', include('registration.backends.default.urls')),
#
#)




urlpatterns += patterns('',
#    # Examples:
#    # url(r'^$', 'quesnproject.views.home', name='home'),
#    # url(r'^quesnproject/', include('quesnproject.foo.urls')),
#
#    # Uncomment the admin/doc line below to enable admin documentation:
#
#
#    # Uncomment the next line to enable the admin:
     url(r'^admin/', include(admin.site.urls)),
    (r'^$', direct_to_template,{'template':'index.html'}, 'index'),
     url(r'^h/$', direct_to_template,{'template':'home.html'},name='home'),
     #admin urls
     url(r'^assign/$','questn.views.assignquestionnaire',name='view_assignuestionnaire'),

     url(r'^handle/$', 'questn.views.questionnaire',name='questionnaire'),
     url(r'^create/$','questn.views.createquestionnaire',name='view_createquestionnaire'),
     url(r'^view/$','questn.views.viewquestionnaire',name='view_viewquestionnaire'),
     #user urls
     url(r'^handle2/$','questn.views.questionnaire',name='view_handlequestionnaire'),
     url(r'^attempt/$','questn.views.attemptquestionnaire',name='view_attemptquestionnaire'),
     url(r'^complete/$','questn.views.completequestionnaire',name='view_createquestionnaire'),


     url(r'^/$','questn.views.assignquestionnaire',name='view_assignquestionnaire'),
     url(r'^assign/details/$', direct_to_template,{'template':'details.html'},name='details'),

     url(r'^pro/$', direct_to_template,{'template':'profile.html'},name='profile'),
     url(r'^thanx/$', direct_to_template,{'template':'thanx.html'},name='thanx'),
     # url(r'^user/$', direct_to_template,{'template':'userdetails.html'},name='userdetails'),
    url(r'^completeq/$', direct_to_template,{'template':'complete.html'},name='complete'),
     # questionnaire urls
     url(r'q/', include('questionnaire.urls')),



     url(r'^take/(?P<questionnaire_id>[0-9]+)/$', 'questionnaire.views.generate_run'),
     url(r'^qi/$', 'questionnaire.page.views.page', {'page' : 'index'}),
     url(r'^(?P<page>.*)\.html$', 'questionnaire.page.views.page'),
     url(r'^(?P<lang>..)/(?P<page>.*)\.html$', 'questionnaire.page.views.langpage'),
     url(r'^setlang/$', 'questionnaire.views.set_language'),
        (r'^accounts/', include('registration.backends.default.urls')),
)