import 'package:flutter/material.dart';

class AboutApp extends StatefulWidget {
  AboutApp({Key? key}) : super(key: key);

  @override
  _AboutAppState createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Acerca de.."),
    );
  }
}
