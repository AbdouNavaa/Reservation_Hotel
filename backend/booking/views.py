from django.shortcuts import render,get_object_or_404
from rest_framework import generics,viewsets
from .models import Room,Booking,Hotel
from hotel.models import User
from .serializer import RoomSerializer,BookingSerializer,HotelSerializer
from django.http import JsonResponse

def make_reservation(request):
    if request.method == 'POST':
        username = request.POST.get('username')
        room_id = request.POST.get('room_id')
        date = request.POST.get('date')
        try:
            room = Room.objects.get(id=room_id)
            user = User.objects.get(username=username)
            reservation = Booking.objects.create(
                room=room,
                user=user,
                date=date
            )
            return JsonResponse({'status': 'success'})
        except Room.DoesNotExist:
            return JsonResponse({'status': 'error', 'message': 'Room does not exist'})
        except User.DoesNotExist:
            return JsonResponse({'status': 'error', 'message': 'User does not exist'})
    return JsonResponse({'status': 'error', 'message': 'Invalid request method'})


def reservation_view(request, username, room_id, date):
    user = get_object_or_404(User, username=username)
    room = get_object_or_404(Room, pk=room_id)
    reservation = get_object_or_404(Booking, room=room, user=user, date=date)
    return render(request, 'reservation.html', {'reservation': reservation})

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