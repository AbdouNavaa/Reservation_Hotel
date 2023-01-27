import 'dart:convert';
// import 'package:frontend/auth_service/auth_service.dart';
import 'package:http/http.dart' as http;

class BookService {
  var client = http.Client();

  Future<List> getBook() async {
try {
  var response =
  await http.get(Uri.parse("http://10.0.2.2:8000/booking/bookList/"));
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
    print('4e sla7 --------------------------------------------');
  } else {
    return Future.error('Server Error');
    print('4e 5asser sa77bi mad5al======================================');
  }
}catch(e){
  return Future.error(e);
}
  }
  Future<List<Book>> fetchData() async {
    List<Book> mytodos = [];
    try{
      http.Response response = await http.get(Uri.parse("http://127.0.0.1:8000/booking/bookList/"));
      var data =  json.decode(response.body);
      data.forEach((book) {
        Book t = Book(id: book['id'],
            type: book['type'],
            descriptionn: book['description'],
            image: book['image'],
        );

            mytodos.add(t);
      });
      print(mytodos.length);

    }catch(e){ print('error is $e');}
    return mytodos;
  }

}

class ListOfBook {
  List<Book> books;
  ListOfBook({required this.books});
  factory ListOfBook.fromList(List list) {
    List<Book> mybooks = [];
    for (var ele in list) {
      mybooks.add(Book.fromJson(ele));
    }
    return ListOfBook(books: mybooks);
  }
}

class Book {


  Book({
    required this.id,
    required this.type,
    required this.descriptionn,
    required this.image,
  });

  late final int id;
  late final String type;
  late final String descriptionn;
  late final String image;

  factory Book.fromJson(map) {
    return Book(
      id: map['id'],
      type: map['type'],
      descriptionn: map['descriptionn'],
      image: map['image'],
    );
  }
}
