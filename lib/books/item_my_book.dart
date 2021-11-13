import 'package:flutter/material.dart';
import 'package:libreria/pages/f_books/details_book.dart';

class ItemMyBook extends StatelessWidget {
  final Map<String, dynamic> book;
  ItemMyBook({
    Key? key,
    required this.book,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var image = book["img"];
    return Column(
      children: [
        Card(
          child: ListTile(
            leading: image != null
                ? Image.network(image)
                : CircleAvatar(backgroundColor: Colors.grey),
            title: Text(
              "${book["title"] ?? "No title available"}",
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              "${book["description"] ?? "No description available"}",
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
              icon: Icon(Icons.read_more),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DetailsBook(
                      bookDetails: book["details"],
                      title: book["title"],
                      img: book["img"],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
