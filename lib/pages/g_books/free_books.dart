import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:libreria/books/item_book.dart';
import 'package:libreria/models/item.dart';

import 'bloc/free_books_bloc.dart';

class FreeBooks extends StatefulWidget {
  FreeBooks({Key? key}) : super(key: key);

  @override
  _FreeBooksState createState() => _FreeBooksState();
}

class _FreeBooksState extends State<FreeBooks> {
  var _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
        left: 8,
        right: 8,
      ),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: "Ingrese titulo",
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  BlocProvider.of<FreeBooksBloc>(context).add(
                    SearchBookEvent(queryText: _searchController.text),
                  );
                },
              ),
              border: OutlineInputBorder(),
            ),
          ),
          Expanded(
            child: BlocBuilder<FreeBooksBloc, FreeBooksState>(
              builder: (context, state) {
                if (state is SearchLoadingState) {
                  // retornar widget de cargando...
                  return _searchingView();
                } else if (state is SearchErrorState) {
                  // retornar widget de error...
                  return _error(state.errorMsg);
                } else if (state is ContentAvailableState) {
                  // retornar widget de lista con libros ...
                  return _booksListView(state.booksList);
                }
                return Center(
                  child: Text("Ingrese titulo de libro para buscar..."),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _error(String msg) {
    return Center(child: Text("$msg"));
  }

  Widget _searchingView() {
    return ListView.builder(
      itemCount: 15,
      itemBuilder: (BuildContext context, int index) {
        return ListTileShimmer();
      },
    );
  }

  Widget _booksListView(List<Item> booksList) {
    return ListView.builder(
      itemCount: booksList.length,
      itemBuilder: (BuildContext context, int index) {
        return ItemBook(book: booksList[index]);
      },
    );
  }
}
