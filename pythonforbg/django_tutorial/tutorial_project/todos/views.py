from django.shortcuts import render, redirect
from django.http import HttpResponse, HttpResponseNotAllowed

from .forms import TodoForm

import random

# Create your views here.
def index(request):
    return render(request, "todos/index.html")

def home_view(request):
    return redirect("todos:index")

def hello_world_view(request):
    return HttpResponse("Hello World".encode('utf-8'))

def greet_usrs(request, name):
    return HttpResponse(f"Hello {name}".encode('utf-8'))

def find_task(request):
    return HttpResponse(f"Looking for the task with ID {request.GET.get('id')}".encode('utf-8'))

def post_task(request):
    if request.method == "POST":
        # task_summery: str = request.POST.get("task_summery")
        # task_description: str = request.POST.get("task_description")
        form = TodoForm(request.POST)

        if form.is_valid():
            task_summery = form.cleaned_data["task_summery"]
            task_description = form.cleaned_data["task_description"]

        random.seed(task_summery.encode('utf-8'))
        task_id = random.randint(1, 1000)
        msg = f"Task Summery: {task_summery}\r\nTask Description: {task_description}\r\nTask ID: {task_id}\r\n"

        return HttpResponse(msg.encode('utf-8'))
    else:
        return HttpResponseNotAllowed(["POST"])

def add_task(request):
    return render(request, "todos/add_task.html")