# counter/views.py
from django.shortcuts import render
from django.http import HttpResponse
from .models import Hit


def index(request):
    # Record a new hit every time the view is accessed
    Hit.objects.create()
    # Count all hits
    count = Hit.objects.count()
    return HttpResponse(
        f"<h1>Hello Docker Learners!</h1><p>This page has been visited {count} times.</p>"
    )
