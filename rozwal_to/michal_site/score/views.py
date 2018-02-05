from django.shortcuts import render
from .models import User

# Create your views here.
def score_list(request):
    users = User.objects.all().order_by('score')
    return render(request, 'score/main_view.xml', {'users': users})