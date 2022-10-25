import 'book.dart';

class BookResponse {
  int? totalItems;
  List<Book>? items;

  BookResponse({this.items, this.totalItems});

  factory BookResponse.fromJson(Map<String, dynamic> jsonData) {
    var bookResponse = BookResponse();
    bookResponse.totalItems = jsonData['totalItems'];
    bookResponse.items = [];
    for (var bookJson in (jsonData['items'] as List<dynamic>)) {
      var bookMap = bookJson as Map<String, dynamic>;
      bookResponse.items?.add(Book.fromJson(bookMap));
    }
    return bookResponse;
  }
}
