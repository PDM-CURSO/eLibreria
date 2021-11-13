import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:libreria/models/libreria.dart';

class LibraryRepository {
  static final LibraryRepository _libraryRepository =
      LibraryRepository._internal();
  factory LibraryRepository() => _libraryRepository;

  LibraryRepository._internal();

  Future<Libreria> getAvailableBooks(String query) async {
    // String link = "https://www.googleapis.com/books/v1/volumes?q=";
    final _url = Uri(
      scheme: "https",
      host: "www.googleapis.com",
      path: "books/v1/volumes",
      queryParameters: {"q": query},
    );

    try {
      final response = await get(_url);
      if (response.statusCode == HttpStatus.ok) {
        var _responseAsJson = jsonDecode(response.body);
        Libreria _libreria = Libreria.fromJson(_responseAsJson);

        return _libreria;
      } else {
        return Libreria(totalItems: 0);
      }
    } catch (e) {
      print("Error request a API:\n${e.toString()}");
      throw "Error en request a API";
      // return Libreria(totalItems: 0);
    }
  }
}
