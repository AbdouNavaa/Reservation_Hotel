from django.urls import path, include
from .views import RoomListView,BookingListView,HotelListView,RoomViewSet,RoomReservationView,ReservationViewSet
from rest_framework import routers

router = routers.DefaultRouter()
router.register(r'rooms', RoomViewSet)
router.register(r'reservations', ReservationViewSet)
urlpatterns = [
path('roomList/', RoomListView.as_view()),
path('bookingList/', BookingListView.as_view()),
path('HotelListView/', HotelListView.as_view()),
path('api/hotels/<int:hotel_id>/rooms/', include(router.urls)),
path('api/', include(router.urls)),
# path('rooms/<int:pk>/reserve/', RoomReservationView.as_view(), name='room_reserve'),
]