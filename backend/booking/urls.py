from django.urls import path, include
from .views import BookListView,BookingListView
urlpatterns = [
path('bookList/', BookListView.as_view()),
path('bookingList/', BookingListView.as_view()),
]