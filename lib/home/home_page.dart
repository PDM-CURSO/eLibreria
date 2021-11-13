import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:libreria/books/item_book.dart';
import 'package:libreria/models/item.dart';

import 'bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home page"),
      ),
      body: Padding(
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
                    BlocProvider.of<HomeBloc>(context).add(
                      SearchBookEvent(queryText: _searchController.text),
                    );
                  },
                ),
                border: OutlineInputBorder(),
              ),
            ),
            Expanded(
              child: BlocBuilder<HomeBloc, HomeState>(
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
