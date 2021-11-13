part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class SearchBookEvent extends HomeEvent {
  final String queryText;

  SearchBookEvent({required this.queryText});
  @override
  List<Object> get props => [queryText];
}
