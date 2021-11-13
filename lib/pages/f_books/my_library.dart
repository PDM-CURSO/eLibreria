import 'package:flutter/material.dart';

class MyLibrary extends StatefulWidget {
  MyLibrary({Key? key}) : super(key: key);

  @override
  _MyLibraryState createState() => _MyLibraryState();
}

class _MyLibraryState extends State<MyLibrary> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Libros de firebase"),
    );
  }
}
