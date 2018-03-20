from django.db import models
from django.contrib import admin


class User(models.Model):
    name = models.CharField(max_length=34)
    score = models.PositiveIntegerField(editable=False, default=0)

    def __str__(self):
        return "{}, {}".format(self.name, self.score)
