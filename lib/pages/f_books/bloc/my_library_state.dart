part of 'my_library_bloc.dart';

abstract class MyLibraryState extends Equatable {
  const MyLibraryState();

  @override
  List<Object> get props => [];
}

class MyLibraryInitial extends MyLibraryState {}

class MyLibraryLoadingState extends MyLibraryState {}

class MyLibraryReadyState extends MyLibraryState {
  final List<Map<String, dynamic>> booksList;

  MyLibraryReadyState({required this.booksList});
  @override
  List<Object> get props => [booksList];
}

class MyLibraryEmptyState extends MyLibraryState {}

class MyLibraryErrorState extends MyLibraryState {
  final String errorMsg;

  MyLibraryErrorState({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}
