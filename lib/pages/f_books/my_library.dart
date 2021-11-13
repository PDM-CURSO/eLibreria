import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:libreria/books/item_my_book.dart';

import 'bloc/my_library_bloc.dart';

class MyLibrary extends StatefulWidget {
  MyLibrary({Key? key}) : super(key: key);

  @override
  _MyLibraryState createState() => _MyLibraryState();
}

class _MyLibraryState extends State<MyLibrary> {
  var _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: "Ingrese titulo",
              prefixIcon: Icon(Icons.manage_search),
              suffixIcon: IconButton(
                tooltip: "Tap to search",
                icon: Icon(Icons.search),
                onPressed: () {
                  BlocProvider.of<MyLibraryBloc>(context).add(
                    MyLibraryRequestAllEvent(bookName: _searchController.text),
                  );
                },
              ),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Expanded(
          child: BlocConsumer<MyLibraryBloc, MyLibraryState>(
            listener: (context, state) {
              if (state is MyLibraryErrorState) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text("Ha ocurrido un error, intente nuevamente"),
                    ),
                  );
              }
            },
            builder: (context, state) {
              if (state is MyLibraryLoadingState)
                return _loadingStateView();
              else if (state is MyLibraryEmptyState)
                return _emptyStateView();
              else if (state is MyLibraryErrorState)
                return _errorStateView(state.errorMsg);
              else if (state is MyLibraryInitial)
                return _loadingStateView();
              else if (state is MyLibraryReadyState)
                return _booksListView(state.booksList);
              else
                return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ],
    );
  }

  Widget _loadingStateView() {
    return ListView.builder(
      itemCount: 15,
      itemBuilder: (BuildContext context, int index) {
        return ListTileShimmer();
      },
    );
  }

  Widget _booksListView(List<Map<String, dynamic>> booksList) {
    return ListView.builder(
      itemCount: booksList.length,
      itemBuilder: (BuildContext context, int index) {
        return ItemMyBook(book: booksList[index]);
      },
    );
  }

  Widget _errorStateView(String msg) {
    return Center(
      child: ListTile(
        trailing: Icon(Icons.error, color: Colors.red),
        title: Text("$msg"),
      ),
    );
  }

  Widget _emptyStateView() {
    return Center(
      child: ListTile(
        trailing: Icon(Icons.query_stats, color: Colors.red),
        title: Text("No se han encontrado libros disponibles"),
      ),
    );
  }
}
