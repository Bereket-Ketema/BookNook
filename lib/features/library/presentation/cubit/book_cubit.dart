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

    await result.fold(
      (failure) async {
        emit(BookActionError('Failed to add book'));
      },
      (_) async {
        emit(BookActionSuccess('Book added successfully'));

        await loadBooks();
      },
    );
  }


  Future<void> updateBook(Book book) async {
    emit(BookActionLoading());

    final result = await updateBookUseCase(book);

    await result.fold(
      (failure) async {
        emit(BookActionError('Failed to update book'));
      },
      (_) async {
        emit(BookActionSuccess('Book updated successfully'));

        await loadBooks();
      },
    );
  }


  Future<void> deleteBook(String id) async {
    emit(BookActionLoading());

    final result = await deleteBookUseCase(id);

    if (result.isLeft()) {
      emit(BookActionError('Failed to delete book'));
      return;
    }

    emit(BookActionSuccess('Book deleted successfully'));

    await loadBooks();
  }
}