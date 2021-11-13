import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libreria/pages/f_books/bloc/my_library_bloc.dart';
import 'pages/g_books/bloc/free_books_bloc.dart';
import 'pages/home/home_page.dart';

void main() async {
  // inicializar firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FreeBooksBloc(),
        ),
        BlocProvider(
          create: (context) => MyLibraryBloc()..add(MyLibraryRequestAllEvent()),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
