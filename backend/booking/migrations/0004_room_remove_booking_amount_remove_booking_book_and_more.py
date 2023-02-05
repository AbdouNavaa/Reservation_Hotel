# Generated by Django 4.0.6 on 2023-01-28 07:58

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('hotel', '0002_hotel'),
        ('booking', '0003_booking_book'),
    ]

    operations = [
        migrations.CreateModel(
            name='Room',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('type', models.CharField(max_length=255)),
                ('amount', models.FloatField()),
                ('image', models.ImageField(null=True, upload_to='')),
                ('hotel', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='hotel.hotel')),
            ],
        ),
        migrations.RemoveField(
            model_name='booking',
            name='amount',
        ),
        migrations.RemoveField(
            model_name='booking',
            name='book',
        ),
        migrations.RemoveField(
            model_name='booking',
            name='club',
        ),
        migrations.RemoveField(
            model_name='booking',
            name='food',
        ),
        migrations.RemoveField(
            model_name='booking',
            name='games',
        ),
        migrations.RemoveField(
            model_name='booking',
            name='gym',
        ),
        migrations.RemoveField(
            model_name='booking',
            name='spa',
        ),
        migrations.RemoveField(
            model_name='booking',
            name='swimming',
        ),
        migrations.DeleteModel(
            name='Book',
        ),
    ]