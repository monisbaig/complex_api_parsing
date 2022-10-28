import 'dart:convert';

import 'package:complex_api_parsing/Modals/book.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BookDetail extends StatefulWidget {
  final Book bookFromList;

  BookDetail({super.key, required this.bookFromList});

  @override
  State<BookDetail> createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  late Book book;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    book = widget.bookFromList;
    _getBookDetail();
  }

  _getBookDetail() async {
    setState(() {
      isLoading = true;
    });

    try {
      var url =
          Uri.parse('https://www.googleapis.com/books/v1/volumes/${book.id}');
      var response = await http.get(url);
      var jsonDecoded = jsonDecode(response.body);
      setState(() {
        book = Book.fromJson(jsonDecoded);
      });
    } catch (e) {
      setState(() {
        book = widget.bookFromList;
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.volumeInfo?.title ?? ''),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Book Title'),
            Image.network(book.volumeInfo?.imageLinks?.thumbnail ?? ''),
            if (isLoading) CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
