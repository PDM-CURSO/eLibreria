import 'package:flutter/material.dart';

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
            trailing: Icon(Icons.read_more),
          ),
        ),
      ],
    );
  }
}
