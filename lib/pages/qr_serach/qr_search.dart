import 'package:flutter/material.dart';

class QRSearch extends StatefulWidget {
  QRSearch({Key? key}) : super(key: key);

  @override
  _QRSearchState createState() => _QRSearchState();
}

class _QRSearchState extends State<QRSearch> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Busqueda de libros con QR"),
    );
  }
}
