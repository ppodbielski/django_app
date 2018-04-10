import requests
from michal_site.celery import app
from .models import User

PATTERN = 'pkt'
URL = 'https://rozwal.to/profile/{}'


@app.task()
def get_page_score():
    for user in User.objects.all():
        response = requests.get(URL.format(user.name))
        line = [l for l in response.text.split('\n') if PATTERN in l]
        number = [int(l) for l in str(line).split() if l.isdigit()]
        user.score = number[0] if number else 0
        user.save()
