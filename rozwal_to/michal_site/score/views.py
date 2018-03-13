from django.shortcuts import render
from .models import User

def score_list(request):
    users = User.objects.all().order_by('score')
    return render(request, 'score/main_view.html', {'users': users})