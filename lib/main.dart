import 'dart:convert';

import 'package:complex_api_parsing/book_detail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Modals/book_response.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BookResponse? response;
  bool isLoading = false;
  TextEditingController textEditingController = TextEditingController();
  String get searchKey => textEditingController.text;

  _getBooks() async {
    setState(() {
      isLoading = true;
    });
    try {
      var url =
          Uri.parse("https://www.googleapis.com/books/v1/volumes?q=$searchKey");
      var response = await http.get(url);
      var responseSTR = response.body;
      var decodedJson = jsonDecode(responseSTR) as Map<String, dynamic>;
      setState(() {
        this.response = BookResponse.fromJson(decodedJson);
      });
    } catch (e) {
      print(e);
      setState(() {
        this.response = null;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void onSearchButton() => _getBooks();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Complex Rest Api Parsing',
          ),
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: textEditingController,
                ),
              ),
              ElevatedButton(
                onPressed: onSearchButton,
                child: const Text('Search'),
              ),
            ],
          ),
          if (!isLoading)
            Expanded(
              child: ListView.builder(
                itemCount: response?.items?.length ?? 0,
                itemBuilder: (_, index) => ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BookDetail(
                            bookFromList: (response?.items![index])!),
                      ),
                    );
                  },
                  title: Text(response?.items![index].volumeInfo?.title ?? ''),
                  subtitle: Text(
                      response?.items![index].volumeInfo?.author?.first ?? ''),
                  leading: Image.network(response
                          ?.items![index].volumeInfo?.imageLinks?.thumbnail ??
                      ''),
                ),
              ),
            ),
          if (!isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
