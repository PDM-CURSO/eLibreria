part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class SearchLoadingState extends HomeState {}

class SearchErrorState extends HomeState {
  final String errorMsg;

  SearchErrorState({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}

class ContentAvailableState extends HomeState {
  final List<Item> booksList;
  final int totalBooks;

  ContentAvailableState({
    required this.booksList,
    required this.totalBooks,
  });

  @override
  List<Object> get props => [booksList, totalBooks];
}
