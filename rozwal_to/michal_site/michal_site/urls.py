from django.contrib import admin
from django.conf.urls import include, url
#from django.contrib.staticfiles.urls import staticfiles_urlpatterns
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    url(r'^admin/', admin.site.urls),
    url(r'', include('score.urls')),
]

#urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
#urlpatterns += staticfiles_urlpatterns()
#if settings.DEBUG:
#    urlpatterns += static('',
#        url(r'^static/(?P<path>.*)$', 'django.views.static.serve', {
#            'document_root': settings.STATIC_ROOT,
#        }),
#)
