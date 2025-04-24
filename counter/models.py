# counter/models.py
from django.db import models


class Hit(models.Model):
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Hit on {self.created_at.strftime('%Y-%m-%d %H:%M:%S')}"
