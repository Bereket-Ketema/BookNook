import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:book_nook/features/library/domain/entities/book.dart';

import 'package:book_nook/features/library/domain/usecases/get_books.dart';
import 'package:book_nook/features/library/domain/usecases/add_book.dart';
import 'package:book_nook/features/library/domain/usecases/update_book.dart';
import 'package:book_nook/features/library/domain/usecases/delete_book.dart';

import 'book_state.dart';

class BookCubit extends Cubit<BookState> {
  final GetBooksUseCase getBooksUseCase;
  final AddBookUseCase addBookUseCase;
  final UpdateBookUseCase updateBookUseCase;
  final DeleteBookUseCase deleteBookUseCase;

  BookCubit(
    this.getBooksUseCase,
    this.addBookUseCase,
    this.updateBookUseCase,
    this.deleteBookUseCase,
  ) : super(BookInitial());


  Future<void> loadBooks() async {
    emit(BookLoading());

    final result = await getBooksUseCase();

    result.fold(
      (failure) {
        emit(BookError('Failed to load books'));
      },
      (books) {
        emit(BookLoaded(books));
      },
    );
  }


  Future<void> addBook(Book book) async {
    emit(BookActionLoading());

    final result = await addBookUseCase(book);

    result.fold(
      (failure) {
        emit(BookActionError('Failed to add book'));
      },
      (_) {
        emit(BookActionSuccess('Book added successfully'));
      },
    );
  }


  Future<void> updateBook(Book book) async {
    emit(BookActionLoading());

    final result = await updateBookUseCase(book);

    result.fold(
      (failure) {
        emit(BookActionError('Failed to update book'));
      },
      (_) {
        emit(BookActionSuccess('Book updated successfully'));
      },
    );
  }


  Future<void> deleteBook(String id) async {
    emit(BookActionLoading());

    final result = await deleteBookUseCase(id);

    result.fold(
      (failure) {
        emit(BookActionError('Failed to delete book'));
      },
      (_) {
        emit(BookActionSuccess('Book deleted successfully'));
      },
    );
  }
}