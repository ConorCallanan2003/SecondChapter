import "dart:io";

import 'package:csv/csv.dart';
import 'package:flutter/services.dart';

class Book {
  Book(this.isbn, this.author, this.year, this.title, this.rating, this.image);

  String isbn;
  String title;
  String author;
  String year;
  String rating;
  String image;

  static Future<List<Book>> generateBooks(String filterTerm) async {
    File file = File('assets/books__.csv');

    final data = await rootBundle.loadString("assets/books__.csv");

    List<Book> books = [];

    List<String> stringBooks = data.split("\n");

    if (filterTerm == '') {
      for (int i = 1; i < stringBooks.length; i++) {
        List<String> book = stringBooks[i].split("{");

        // print(stringBooks[1]);
        if (book.length == 6) {
          Book newBook = Book(book[0].trim(), book[1].trim(), book[2].trim(),
              book[3].trim(), book[4].trim(), book[5].trim());

          books.add(newBook);
        }
      }
      return books;
    } else {
      for (int i = 1; i < stringBooks.length; i++) {
        List<String> book = stringBooks[i].split("{");

        // print(stringBooks[1]);
        if (book.length == 6) {
          Book newBook = Book(book[0].trim(), book[1].trim(), book[2].trim(),
              book[3].trim(), book[4].trim(), book[5].trim());

          if (newBook.title.toLowerCase().contains(filterTerm.toLowerCase())) {
            books.add(newBook);
          }
        }
      }
      return books;
    }
  }
}
