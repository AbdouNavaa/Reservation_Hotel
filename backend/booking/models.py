from django.db import models
from hotel.models import User

# Create your models here.

class Book(models.Model):
    type=models.CharField(max_length=255)
    descriptionn= models.CharField( max_length=255)
    image = models.ImageField(null=True)
    
    def __str__(self):
        return self.type
class Booking(models.Model):
    bookedBy = models.ForeignKey(User, on_delete=models.CASCADE)
    book = models.ForeignKey(Book, on_delete=models.CASCADE)
    days = models.IntegerField()
    amount = models.FloatField()
    food = models.BooleanField(default=False)
    spa = models.BooleanField(default=False)
    gym = models.BooleanField(default=False)
    club = models.BooleanField(default=False)
    swimming = models.BooleanField(default=False)
    games = models.BooleanField(default=False)
   
    def __str__(self):
        return "Booking ID: "+str(self.id)