import 'package:flutter/material.dart';
import 'package:replay_books/widgets/book_item.dart';
import 'package:replay_books/widgets/bottom_nav_bar.dart';

import '../util/get_book_data.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<List<Book>> books = Book.generateBooks('');

    return Scaffold(
        // appBar: AppBar(
        //   title: const Text(
        //     'ReplayBooks',
        //     style: TextStyle(
        //         fontSize: 36, color: Colors.black, fontWeight: FontWeight.w700),
        //   ),
        //   backgroundColor: Colors.transparent,
        //   shadowColor: Colors.transparent,
        //   centerTitle: false,
        //   actions: const [
        //     Padding(
        //       padding: EdgeInsets.only(right: 15.0),
        //       child: IconButton(
        //           onPressed: null,
        //           icon: Icon(
        //             Icons.shopping_cart_rounded,
        //             size: 40,
        //             color: Colors.black,
        //           )),
        //     )
        //   ],
        // ),
        backgroundColor: Colors.white,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerboxIsScrollable) {
            return <Widget>[
              const SliverAppBar(
                pinned: false,
                floating: true,
                title: Text(
                  'ReplayBooks',
                  style: TextStyle(
                      fontSize: 36,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                centerTitle: false,
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.shopping_cart_rounded,
                          size: 40,
                          color: Colors.black,
                        )),
                  )
                ],
              )
            ];
          },
          body: FutureBuilder<List<Book>>(
              future: books,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return ListView();
                }
                return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: (1 / 1.4),
                      crossAxisCount: 2,
                    ),
                    padding: EdgeInsets.zero,
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return BookItem(snapshot.data![index]);
                    });
              }),
        ));
  }
}
