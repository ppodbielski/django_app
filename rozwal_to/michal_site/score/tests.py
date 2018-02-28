from django.test import TestCase
from .models import User

class UserTestCase(TestCase):

    def setUp(self):
        User.objects.create(name="Michal", score="1234")

    def test_name(self):
        michal = User.objects.get(id=1)
        self.assertEquals(michal.name, 'Michal')

    def test_score(self):
        michal = User.objects.get(id=1)
        self.assertEquals(michal.score, 1234)