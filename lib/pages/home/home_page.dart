import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libreria/pages/about/about_app.dart';
import 'package:libreria/pages/f_books/bloc/my_library_bloc.dart';
import 'package:libreria/pages/f_books/my_library.dart';
import 'package:libreria/pages/g_books/free_books.dart';
import 'package:libreria/pages/qr_serach/qr_search.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPageIndex = 0;
  final _pageNameList = [
    "Google books",
    "My library",
    // "Search by QR",
    "About",
  ];

  final _pageList = [
    FreeBooks(),
    MyLibrary(),
    // QRSearch(),
    AboutApp(),
  ];

  var _pageActions = [
    <Widget>[],
    <Widget>[],
    //<Widget>[],
    <Widget>[],
  ];

  @override
  void initState() {
    // my library page actions
    _pageActions[1].add(
      IconButton(
        onPressed: _openQrScannerPage,
        icon: Icon(Icons.qr_code_scanner),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${_pageNameList[_currentPageIndex]}"),
        actions: _pageActions[_currentPageIndex],
      ),
      body: IndexedStack(
        index: _currentPageIndex,
        children: _pageList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        currentIndex: _currentPageIndex,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.view_carousel),
            label: "${_pageNameList[0]}",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: "${_pageNameList[1]}",
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.qr_code_scanner),
          //   label: "${_pageNameList[2]}",
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: "${_pageNameList[2]}",
          ),
        ],
      ),
    );
  }

  // Abrir patalla de scanner y al leer QR
  // buscar libro en pantalla de my library┐
  void _openQrScannerPage() {
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (context) => QRSearch(),
      ),
    )
        .then(
      (qrValue) {
        // TODO: probar esto ya que tenga QR validos
        BlocProvider.of<MyLibraryBloc>(context).add(
          MyLibraryRequestAllEvent(bookName: qrValue.toString()),
        );
      },
    );
  }
}
