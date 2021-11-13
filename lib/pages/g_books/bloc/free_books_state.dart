part of 'free_books_bloc.dart';

abstract class FreeBooksState extends Equatable {
  const FreeBooksState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends FreeBooksState {}

class SearchLoadingState extends FreeBooksState {}

class SearchErrorState extends FreeBooksState {
  final String errorMsg;

  SearchErrorState({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}

class ContentAvailableState extends FreeBooksState {
  final List<Item> booksList;
  final int totalBooks;

  ContentAvailableState({
    required this.booksList,
    required this.totalBooks,
  });

  @override
  List<Object> get props => [booksList, totalBooks];
}
