import unittest
from .models import User
from django.test import Client


class UserTestCase(unittest.TestCase):

    def setUp(self):
        self.user_ = User.objects.create(name="Michal", score="1234")

    def tearDown(self):
        del self.user_

    def test_name(self):
        self.user_ = User.objects.get(id=1)
        self.assertEquals(self.user_.name, 'Michal')

    def test_score(self):
        self.user_ = User.objects.get(id=1)
        self.assertEquals(self.user_.score, 1234)

    def test_user_view(self):
        client = Client()
        response = client.get('/')
        self.assertEqual(response.status_code, 200)
