import 'package:flutter/material.dart';
import 'package:libreria/models/item.dart';

class ItemBook extends StatelessWidget {
  final Item book;
  ItemBook({
    Key? key,
    required this.book,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var image = book.volumeInfo?.imageLinks?.thumbnail;
    return Column(
      children: [
        Card(
          child: ListTile(
            leading: image != null
                ? Image.network(book.volumeInfo!.imageLinks!.thumbnail!)
                : CircleAvatar(),
            title: Text(
              "${book.volumeInfo!.title ?? "No title available"}",
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              "${book.volumeInfo!.description ?? "No description available"}",
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Icon(Icons.arrow_forward),
          ),
        ),
      ],
    );
  }
}
