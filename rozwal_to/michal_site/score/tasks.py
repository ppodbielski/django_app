import requests
from michal_site.celery import app
from .models import User

pattern = 'pkt'

@app.task()
def get_page_score():
    for u in User.objects.all():
        url = 'https://rozwal.to/profile/' + u.name
        response = requests.get(url)

        line = [l for l in response.text.split('\n') if pattern in l]
        number = [int(l) for l in str(line).split() if l.isdigit()]
        u.score = number[0] if number else 0
        u.save()
