# Generated by Django 4.0.6 on 2023-01-28 09:09

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('booking', '0007_hotel'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='hotel',
            name='rooms',
        ),
    ]
