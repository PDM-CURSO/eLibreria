part of 'my_library_bloc.dart';

abstract class MyLibraryEvent extends Equatable {
  const MyLibraryEvent();

  @override
  List<Object> get props => [];
}

class MyLibraryRequestAllEvent extends MyLibraryEvent {
  final String bookName;

  MyLibraryRequestAllEvent({this.bookName = ""});
  @override
  List<Object> get props => [bookName];
}
