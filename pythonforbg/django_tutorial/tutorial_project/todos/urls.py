from django.urls import path

from . import views

app_name = 'todos'

urlpatterns = [
    path('', views.index, name='index'),
    path('home/', views.home_view, name='home'),
    path('hello-world/', views.hello_world_view, name='hello_world'),
    path('greet/<str:name>/', views.greet_usrs, name='greet_usrs'),
    path('find-task/', views.find_task, name='find_task'),
    path('post-task/', views.post_task, name='post_task'),
    path('add-task', views.add_task, name='add_task'),
]
