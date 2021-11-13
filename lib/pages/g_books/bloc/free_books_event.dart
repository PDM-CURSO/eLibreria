part of 'free_books_bloc.dart';

abstract class FreeBooksEvent extends Equatable {
  const FreeBooksEvent();

  @override
  List<Object> get props => [];
}

class SearchBookEvent extends FreeBooksEvent {
  final String queryText;

  SearchBookEvent({required this.queryText});
  @override
  List<Object> get props => [queryText];
}
