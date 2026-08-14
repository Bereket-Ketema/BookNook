import 'package:book_nook/features/library/domain/entities/book.dart';

abstract class BookState {}

class BookInitial extends BookState {}

class BookLoading extends BookState {}

class BookLoaded extends BookState {
  final List<Book> books;

  BookLoaded(this.books);
}

class BookError extends BookState {
  final String message;

  BookError(this.message);
}

// CRUD action states

class BookActionLoading extends BookState {}

class BookActionSuccess extends BookState {
  final String message;

  BookActionSuccess(this.message);
}

class BookActionError extends BookState {
  final String message;

  BookActionError(this.message);
}