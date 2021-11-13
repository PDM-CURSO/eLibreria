import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:libreria/models/item.dart';
import 'package:libreria/repositories/library_repository.dart';

part 'free_books_event.dart';
part 'free_books_state.dart';

class FreeBooksBloc extends Bloc<FreeBooksEvent, FreeBooksState> {
  final LibraryRepository _libraryRepository = LibraryRepository();

  FreeBooksBloc() : super(HomeInitial()) {
    on<SearchBookEvent>(_onSearchBook);
  }

  void _onSearchBook(
    SearchBookEvent event,
    Emitter emitState,
  ) async {
    try {
      emitState(SearchLoadingState());
      var libreria =
          await _libraryRepository.getAvailableBooks(event.queryText);
      emitState(
        ContentAvailableState(
          booksList: libreria.items ?? [],
          totalBooks: libreria.totalItems ?? 0,
        ),
      );
    } catch (e) {
      emitState(
        SearchErrorState(
          errorMsg: "Error al buscar libors por favor intente despues.",
        ),
      );
    }
  }
}
