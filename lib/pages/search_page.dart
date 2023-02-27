import 'package:flutter/material.dart';

import '../util/get_book_data.dart';
import '../widgets/book_item.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController controller = TextEditingController();

  String searchTerm = '';

  void handleSearch(String term) {
    setState(() {
      searchTerm = term;
    });
  }

  @override
  Widget build(BuildContext context) {
    controller.text = searchTerm;
    double height = MediaQuery.of(context).size.height;
    Future<List<Book>> books = Book.generateBooks(searchTerm);
    controller = TextEditingController();
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: height * .06, left: 25, right: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * .7,
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(label: Text('Search')),
                  style: const TextStyle(
                      fontSize: 36, fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                  onPressed: () => handleSearch(controller.value.text),
                  icon: const Icon(
                    Icons.search,
                    size: 38,
                  )),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .75,
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder<List<Book>>(
              future: books,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return ListView();
                }
                return GridView.builder(
                    padding: const EdgeInsets.only(top: 18),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: (1 / 1.4),
                      crossAxisCount: 2,
                      crossAxisSpacing: 4.0,
                    ),
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return BookItem(snapshot.data![index]);
                    });
              }),
        )
      ],
    );
  }
}
