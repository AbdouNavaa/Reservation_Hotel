from django.shortcuts import render
from rest_framework import generics
from .models import Book,Booking
from .serializers import BookSerializer,BookingSerializer

# Create your views here.
class BookListView(generics.ListAPIView):
    queryset=Book.objects.all()
    serializer_class=BookSerializer
    
class BookingListView(generics.ListAPIView):
    queryset=Booking.objects.all()
    serializer_class=BookingSerializer
    