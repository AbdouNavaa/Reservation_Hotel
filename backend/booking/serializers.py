from rest_framework import serializers
from .models import Book, Booking

class BookSerializer(serializers.ModelSerializer):
    class Meta:
        model=Book
        fields='__all__'
class BookingSerializer(serializers.ModelSerializer):
    bookedBy=serializers.StringRelatedField()
    book=serializers.StringRelatedField()
    class Meta:
        model=Booking
        fields=('id','bookedBy','book')