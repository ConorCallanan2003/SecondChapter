import 'package:flutter/material.dart';
import 'package:replay_books/widgets/small/add_to_cart_alert.dart';
import 'package:replay_books/widgets/small/condition_buttons.dart';

import '../util/get_book_data.dart';

class ItemDetails extends StatelessWidget {
  const ItemDetails(this.book, {super.key});

  final Book book;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          book.title,
          style: const TextStyle(
              fontSize: 23,
              overflow: TextOverflow.ellipsis,
              color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white, size: 24),
      ),
      body: Column(
        children: [
          Container(
            height: height * .3,
            width: width,
            decoration: const BoxDecoration(color: Colors.white),
            child: SizedBox(
              height: height * .3,
              child: Image.network(
                book.image,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                right: 25.0, left: 25.0, top: 16, bottom: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    book.title,
                    // overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                ),
                const Text(
                  '€15',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Divider(
              height: 20,
              thickness: 3,
              endIndent: 0,
              color: Colors.black54,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 18, left: 18),
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla laoreet sodales nunc in tempor. ',
              style: TextStyle(color: Colors.black, fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          ConditionButtons(AddToCartDialog(context).createDialog)
        ],
      ),
    );
  }
}
