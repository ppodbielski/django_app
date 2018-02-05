import requests
from michal_site.celery import app
from .models import User

pattern = 'pkt'

@app.task()
def get_page_score():
    for u in User.objects.all():
        print("dziala")
        url = 'https://rozwal.to/profile/' + u.name
        response = requests.get(url)

        line = [l for l in response.text.split('\n') if pattern in l]
        number = [int(l) for l in str(line).split() if l.isdigit()]
        u.score = number[0] if number else 0
        u.save()



#@app.on_after_configure.connect
#def setup_periodic_tasks(sender):
#    # Calls test('hello') every 10 seconds.
#    sender.add_periodic_task(10.0, get_page_score.s(), name='add every 10')

# celery -A michal_site.celery beat -S django -l debug
# celery worker -A michal_site.celery