from django import forms

class TodoForm(forms.Form):
    task_summery = forms.CharField(max_length=50, required=True)
    task_description = forms.CharField(max_length=200, required=False)
