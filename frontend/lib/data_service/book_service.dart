import 'dart:convert';
// import 'package:frontend/auth_service/auth_service.dart';
import 'package:http/http.dart' as http;

class BookService {
  Future<ListOfBook> getBook() async {
    var response =
        await http.get(Uri.parse("http://127.0.0.1:8000/booking/bookList/"));

    return ListOfBook.fromList(
        jsonDecode(Utf8Decoder().convert(response.bodyBytes)));
  }
}

class ListOfBook {
  List<Book>? books;
  ListOfBook({required this.books});
  factory ListOfBook.fromList(List list) {
    List<Book> _books = [];
    for (var ele in list) {
      _books.add(Book.fromJson(ele));
    }
    return ListOfBook(books: _books);
  }
}

class Book {
  int id;
  String type;
  String descriptionn;
  String image;

  Book({
    required this.id,
    required this.type,
    required this.descriptionn,
    required this.image,
  });

  factory Book.fromJson(map) {
    return Book(
      id: map['id'],
      type: map['type'],
      descriptionn: map['descriptionn'],
      image: map['image'],
    );
  }
}
