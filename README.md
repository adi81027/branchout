 Questionnaire and Assignment
=====================

Introduction
------------
 Questionnaire and Assignment are django  apps which can easily customised
and includes advanced dependency support using boolean expressions.

It allows an administrator to create and edit questionnaires and assignments in the django
admin interface.

It was originally created to support an annually recurring questionnnaire and Assignment for a different college studies and 
survey.

-------

The questionnaire app was originally developed by [rmt](https://github.com/rmt) for Seantis. We picked up the project again in 2011 for yet another medical study. At this point we decided to introduce features and changes that break backwards compatibility with existing questionnaires that use this app.
And assignment app is intially commited by me.

The old versions are tagged as follows:

 * tag 1.0 - state of last commit by the original developer (rmt)
 * tag 1.1 - contains merged changes by other forks improving the orignal

The new version is the current trunk and is dubbed v2.0.

It is still possible to use a questionnaire defined for 1.0 and use it in 2.0 and we cover that topic later in this manual. However, if you used 1.0 and integrated it into your own page you are on your own. We only cover data-migration from an existing questionnaire 1.0 instance to a new questionnaire 2.0 instance.

A lot of template code has changed from 1.0 to 2.0 because we switched from the blueprint CSS framework to the Twitter bootstrap CSS framework. There is also some cleanup around the urls and static files. That's why moving to 2.0 might be a somewhat hairy task to accomplish.

About this Manual
-----------------
 
What it does cover is the following:

 * **Integration** talks lays out the steps needed to create a new Django page together with the questionnaire. The same steps can be used to integrate the questionnaire into an existing site (though you would be entering unpaved ways).
 * **Conecpts** talks about the data model and the design of the application.
 * **Migration** explains how a questionnaire defined with 1.0 can be used in 2.0.
 * **2.0 Postmortem** talks about some experiences made during the development of 2.0.

Integration
-----------

This part of the docs will take you through the steps needed to create a questionnaire app from scratch. It should also be quite handy for the task of integrating the questionnaire into an existing site.

First, create a folder for your new site:

    mkdir site
    cd site

Create a virtual environment so your python packages don't influence your system
    
    virtualenv --no-site-packages -p python2.7 .

Activate your virtual environment

    source bin/activate

Install Django

    pip install django

Create your Django site

    django-admin.py startproject mysite

Create a place for the questionnare and Assignment

    cd mysite
    mkdir apps


You should now have a questionnaire and acadmic folder with assignment in your apps folder



The next step is to install the questionnaire.

    python setup.py install

If you are working with seantis-questionnaire from your own fork you may want to use `python setup.py develop` instead, which will save you from running `python setup.py install` every time the questionnaire changes

Next up we'll have a look at configuring your basic questionnaire.



At the top of settings.py you should at this point add

    import os.path

We will use that below for the setup of the folders

In the same file add the questionnaire static directory to your STATICFILES_DIRS

    os.path.abspath('./Branchout/questionnaire/static/')

Also add the locale and request cache middleware to MIDDLEWARE_CLASSES

    'django.middleware.locale.LocaleMiddleware',
    'questionnaire.request_cache.RequestCacheMiddleware',

Add the questionnaire template dir as well as your own to TEMPLATE_DIRS

    os.path.abspath('./Branchout/questionnaire/templates'),
    os.path.abspath('./templates'),

And finally, add transmeta, questionnaire and django.contrib.markup to your INSTALLED_APPS

    'transmeta',
    'questionnaire',
    'questionnaire.page',
    'django.contrib.markup',

Next up we want to edit the urls.py of your project to hookup the questionnaire views with your site's url configuration.

For an empty site with enabled admin interface you should end up with something like this:

    from django.conf.urls.defaults import patterns, include, url

    from django.contrib import admin
    admin.autodiscover()

    urlpatterns = patterns('',
        url(r'^admin/', include(admin.site.urls)),
        
        # questionnaire urls
        url(r'q/', include('questionnaire.urls')),
        
        url(r'^take/(?P<questionnaire_id>[0-9]+)/$', 'questionnaire.views.generate_run'),
        url(r'^$', 'questionnaire.page.views.page', {'page' : 'index'}),
        url(r'^(?P<page>.*)\.html$', 'questionnaire.page.views.page'),
        url(r'^(?P<lang>..)/(?P<page>.*)\.html$', 'questionnaire.page.views.langpage'),
        url(r'^setlang/$', 'questionnaire.views.set_language'),
    )

For the questionnaire itself it is only necessary to have the urls below `# questionnaire urls

Having done that we can initialize our database. For this to work you must have setup your DATABASES in settings.py

    python manage.py syncdb

The questionnaire expectes a base.html template to be there, with certain stylesheets and blocks inside. Have a look at `./apps/seantis-questionnaire/example/templates/base.html`

For now you might want to just copy the base.html to your own template folder.

    mkdir templates
    cd templates
    cp ../Branchout/templates/base.html .

Congratulations, you have setup the basics of the questionnaire! At this point this site doesn't really do anything, as there are no questionnaires defined.


You may then start your development server

    python manage.py runserver

And navigate your browser to `localhost:8000`

Concepts
--------

For Questionnaire
==================

The  Questionnaire sports the following tables, described in detail below.

 * Subject
 * RunInfo
 * RunInfoHistory
 * Question
 * Choice
 * QuestionSet
 * Questionnaire
 * Answer

### Subject

A subject is someone filling out a questionnaire. 

Subjects are primarily useful in a study where the participants answer a questionnaire repeatedly. In this case a subject may be entered. Whoever is conducting the study (i.e. the person running the questionnaire app), may then periodically send emails inviting the subjects to fill out the questionnaire.

Sending Emails is covered in detail later.

Of course, not every questionnaire is part of a study. Sometimes you just want to find out what people regard as more awesome: pirates or ninjas*? 

*(it's pirates!)

Though a poll would be a better choice for this example, one can find the answer to that question with Seantis Questionnaire by using an anonymous subject. The next chapter *Questionnaire* will talk about that in more detail.

### RunInfo

A runinfo refers to the currently active run of a subject.

A subject who is presently taking a questionnaire is considered to be on a run. The runinfo refers to that run and carries information about it.

The most important information associated with a runinfo is the subject, a random value that is used to generate the unique url to the questionnaire, the result of already answered questions and the progress.

Once a run is over it is deleted with some information being carried over to the RunInfoHistory.

Runs can be tagged by any number of comma separated tags. If tags are used, questions can be made to only show up if the given tag is part of the RunInfo.

### RunInfoHistory

The runinfo history is used to refer to a set of answers.

### Question

A question is anything you want to ask a subject. Since this is usually not limited to yes or no type questions there are a number of different types you can use:

 * **choice-yesno** - Yes or No
 * **choice-yesnocomment** - Yes or No with a chance to comment on the answer
 * **choice-yesnodontknow** - Yes or No or Whaaa?
 * **open** - A simple one line input box
 * **open-textfield** - A box for lengthy answers
 * **choice** - A list of choices to choose from
 * **choice-freeform** - A list of choices with a chance to enter something else
 * **choice-multiple** - A list of choices with multiple answers
 * **choice-multiple-freeform** - Multiple Answers with multiple user defined answers
 * **range** - A range of number from which one number can be chosen
 * **timeperiod** - A timeperiod
 * **custom** - custom question using a custom template
 * **comment** - Not a question, but only a comment displayed to the user

*Some of these types, depend on checks or choices. The range question for instance can be controlled by setting the checks to something like "range=1-100 step=1 unit=%". Other questions like the choice-multiple-freeform need a "extracount=10" if ten extra options should be given to the user.

I would love to go into all the details here but time I have not so I my only choice is to kindly refer you to the qprocessor submodule which handles all the question types.*

Next up is the question number. The question number defines the order of questions alphanumerically as long as a number of questions are shown on the same page. The number is also used to refer to the question.

The text of the question is what the user will be asked. There can be one text for each language defined in the settings.py file.

The extra is an additional piece of information shown to the user. As of yet not all questions support this, but most do.

An important aspect of questions (and their parents, QuestionSets) is the checks field. The checks field does a lot of things (possibly too many), the most important of which is to define if a certain question or questionset should be shown to the current subject.

The most important checks on the question are the following:

 * **required** A required question must be answered by the user
 * **requiredif="number,answer"**  Means that the question is required if the question with *number* is equal to *answer*.
 * **shownif** Same as requiredif, but defining if the question is shown at all.
 * **maleonly** Only shown to male subjects
 * **femaleonly** Only shown to female subjects
 * **iftag="tag"** Question is only shown if the given tag is in the RunInfo

Checks allow for simple boolean expressions like this:
`iftag="foo or bar"` or `requiredif="1,yes and 2,no"`

### Choice

A choice is a possible value for a multiple choice question.

### QuestionSet

A bunch of questions together form a questionset. A questionset is ultimately single page of questions. Questions in the same questionset are shown on the same page.

QuestionSets also have checks, with the same options as Questions. There's only one difference, **required** and **requiredif** don't do anything.

A questionset which contains no visible questions (as defined by **shownif**) is skipped.

### Answer

Contains the answer to a question. The value of the answer is stored as JSON.

### Questionnaire 

A questionnaire is a bunch of questionsets together.

For Assignment
===============
an assignment could be a collection of questionnaire or could be a file in different formats


### The Admin Interface is not Good Enough

Django admin is a nice feature to have, but we either don't leverage it well enough, or it is not the right tool for the questionnaire. In any case, if you are expecting your customer to work with the questionnaire's structure you might have to write your own admin interface. The current one is not good enough.

