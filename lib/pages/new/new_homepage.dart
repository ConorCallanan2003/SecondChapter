import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:replay_books/pages/item_details_page.dart';
import 'package:replay_books/pages/new/sell_page.dart';
import 'package:replay_books/util/router.dart';
import 'package:replay_books/widgets/animated_search_bar.dart';

import '../../util/get_book_data.dart';
import '../../widgets/book_item.dart';

class NewHomePage extends StatefulWidget {
  const NewHomePage({super.key});

  @override
  State<NewHomePage> createState() => NewHomePageState();
}

class NewHomePageState extends State<NewHomePage> {
  Future<List<Book>> books = Book.generateBooks('');

  ValueNotifier<String> barcode = ValueNotifier('');

  void handleScan() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        'blue', 'Cancel', false, ScanMode.BARCODE);
    barcode.value = barcodeScanRes;

    Book book = await Book.retrieveBookByNum(barcodeScanRes);

    Navigator.of(context).push(MyRouter.createRoute(ItemDetails(book)));
  }

  TextEditingController textController = TextEditingController();

  String searchTerm = '';

  void handleSearch(String term) {
    setState(() {
      searchTerm = term;
    });
  }

  ValueNotifier<bool> completed = ValueNotifier(false);

  void toggleCompleted() {
    completed.value = !completed.value;
  }

  @override
  Widget build(BuildContext context) {
    textController.text = searchTerm;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Future<List<Book>> books = Book.generateBooks(searchTerm);
    textController = TextEditingController();

    return ValueListenableBuilder(
      valueListenable: completed,
      builder: (context, value, child) {
        return Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false,
            body: Stack(children: [
              !value
                  ? const SizedBox(
                      height: 0,
                      width: 0,
                    )
                  : FutureBuilder<List<Book>>(
                      future: books,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return ListView();
                        }
                        return GridView.builder(
                            padding: EdgeInsets.only(top: height * 0.18),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: (1 / 1.25),
                              crossAxisCount: 2,
                              crossAxisSpacing: 0,
                            ),
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              return BookItem(snapshot.data![index]);
                            });
                      }),
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                // Container(
                //   height: 350,
                //   width: 450,
                //   decoration: const BoxDecoration(
                //       image: DecorationImage(
                //           scale: .25,
                //           image: AssetImage('assets/images/logo.png'))),
                // ),
                SizedBox(height: 80, width: width),
                AnimatedSearchBar(handleSearch, toggleCompleted),
                !completed.value
                    ? Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextButton(
                            onPressed: () => handleScan(),
                            child: Container(
                              height: 60,
                              width: width * .5,
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black26, blurRadius: 8)
                                  ],
                                  color: Colors.blue,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(35)),
                                  border: Border.all(
                                      color: Colors.black, width: .1)),
                              child: const Center(
                                child: Text(
                                  'Sell',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 32),
                                ),
                              ),
                            )),
                      )
                    : const SizedBox(
                        height: 0,
                        width: 0,
                      ),
                SizedBox(
                  height: completed.value ? 0 : 100,
                  width: width,
                )
              ])
            ]));
      },
    );
  }
}
