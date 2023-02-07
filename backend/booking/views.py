from django.shortcuts import render
from rest_framework import generics,viewsets
from .models import Room,Booking,Hotel
from .serializer import RoomSerializer,BookingSerializer,HotelSerializer


# Reservation
class ReservationViewSet(viewsets.ModelViewSet):
    queryset = Booking.objects.all()
    serializer_class = BookingSerializer


# Create your views here.
class HotelListView(generics.ListAPIView):
    queryset=Hotel.objects.all()
    serializer_class=HotelSerializer
    
class RoomViewSet(viewsets.ModelViewSet):
    queryset = Room.objects.all()
    serializer_class = RoomSerializer

    def get_queryset(self):
        hotel_id = self.kwargs['hotel_id']
        return Room.objects.filter(hotel_id=hotel_id)    
    
class RoomReservationView(generics.RetrieveUpdateAPIView):
    queryset = Room.objects.all()
    serializer_class = RoomSerializer

    def perform_update(self, serializer):
        room = self.get_object()
        room.available = False
        room.save()
    
class RoomListView(generics.ListAPIView):
    queryset=Room.objects.all()
    serializer_class=RoomSerializer
    
class BookingListView(generics.ListAPIView):
    queryset=Booking.objects.all()
    serializer_class=BookingSerializer
    
    
# Search Hotel
class HotelSearchView(generics.ListAPIView):
    serializer_class = HotelSerializer

    def get_queryset(self):
        place = self.kwargs.get('place', None)
        if place is not None:
            return Hotel.objects.filter(place__iexact=place)
        return Hotel.objects.none()