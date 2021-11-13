import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'my_library_event.dart';
part 'my_library_state.dart';

class MyLibraryBloc extends Bloc<MyLibraryEvent, MyLibraryState> {
  final _cFirestore = FirebaseFirestore.instance;

  MyLibraryBloc() : super(MyLibraryInitial()) {
    // un solo evento para traer datos
    on<MyLibraryRequestAllEvent>((event, emit) async {
      emit(MyLibraryLoadingState());
      try {
        var booksList = await _getBooks(event.bookName);
        if (booksList != null) {
          emit(MyLibraryReadyState(booksList: booksList));
          // emit(MyLibraryReadyState(booksList: booksList??[]));
        } else if (booksList == null || booksList.length == 0) {
          emit(MyLibraryEmptyState());
        }
      } catch (e) {
        emit(MyLibraryErrorState(errorMsg: "Error al obtener la informacion"));
      }
    });
  }
  Future<List<Map<String, dynamic>>?> _getBooks(String query) async {
    try {
      if (query.isNotEmpty) {
        // buscar
        // No se pueden poner varios wheres sobre el mismo field
        // al terminar un where si no encuentra datos, el siguiente
        // va a intentar buscar sobre eso y retornara una excepcion
        var myBooks = await _cFirestore
            .collection("eLibrary")
            // .where("title", isEqualTo: query.trim())
            .where("title", isGreaterThanOrEqualTo: query.trim())
            // .where("title", isGreaterThanOrEqualTo: query.trim().toUpperCase())
            // .where("title", isGreaterThanOrEqualTo: query.trim().toLowerCase())
            // .where("title", isGreaterThanOrEqualTo: query.trim().firstToCap())
            // .where("title", isGreaterThanOrEqualTo: query.trim().toTitleCase())
            .get();

        return myBooks.docs
            .map(
              (book) => {
                "title": book["title"] as String?,
                "img": book["img"] as String?,
                "details": {
                  "description": book["details"]["description"] as String?,
                  "link": book["details"]["link"] as String?,
                  "price": book["details"]["price"] as String?,
                  "qr": book["details"]["qr"] as String?,
                  "tags": book["details"]["tags"].cast<String>(),
                  "images": book["details"]["images"].cast<String>(),
                },
              },
            )
            .toList();
      } else {
        // traerse todo
        var myBooks = await _cFirestore.collection("eLibrary").get();
        return myBooks.docs
            .map(
              (book) => {
                "title": book["title"] as String?,
                "img": book["img"] as String?,
                "details": {
                  "description": book["details"]["description"] as String?,
                  "link": book["details"]["link"] as String?,
                  "price": book["details"]["price"] as String?,
                  "qr": book["details"]["qr"] as String?,
                  "tags": book["details"]["tags"].cast<String>(),
                  "images": book["details"]["images"].cast<String>(),
                },
              },
            )
            .toList();
      }
    } catch (e) {
      print(e.toString());
      throw "Ha ocurrido un error:\n${e.toString()}";
      //return null;
    }
  }
}
