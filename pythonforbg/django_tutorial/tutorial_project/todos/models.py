from django.db import models

class PriorityChoices(models.IntegerChoices):
    LOW = 0, "Low"
    MEDIUM = 1, "Medium"
    HIGH = 2, "High"

# Create your models here.
class Task(models.Model):
    task_summery = models.CharField(max_length=50)
    task_description = models.TextField(max_length=200)
    task_id = models.IntegerField(null=True, blank=True)
    task_done = models.BooleanField(default=False)
    task_deadline = models.DateField(null=True, blank=True)
    task_priorty = models.IntegerField(choices=PriorityChoices.choices, null=True, blank=True)

    def __str__(self):
        return self.task_summery
