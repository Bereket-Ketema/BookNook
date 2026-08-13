import 'package:dartz/dartz.dart';
import 'package:book_nook/features/library/domain/entities/book.dart';
import 'package:book_nook/features/library/domain/failures/failure.dart';
import 'package:book_nook/features/library/domain/repositories/book_repository.dart';

class AddBookUseCase {
  final BookRepository repository;

  AddBookUseCase(this.repository);

  Future<Either<Failure, Unit>> call(Book book) {
    return repository.addBook(book);
  }
}
