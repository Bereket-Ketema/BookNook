import 'package:book_nook/features/library/domain/usecases/get_books.dart';
import 'package:book_nook/features/library/presentation/cubit/book_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookCubit extends Cubit<BookState> {
  final GetBooksUseCase getBooksUseCase;

BookCubit(this.getBooksUseCase) : super(BookInitial());

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
}
