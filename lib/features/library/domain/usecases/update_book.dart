import 'package:dartz/dartz.dart';
import 'package:flutter_first/features/library/domain/entities/book.dart';
import 'package:flutter_first/features/library/domain/failures/failure.dart';
import 'package:flutter_first/features/library/domain/repositories/book_repository.dart';

class UpdateBookUseCase {
  final BookRepository repository;

  UpdateBookUseCase(this.repository);

  Future<Either<Failure, Unit>> call(Book book) {
    return repository.updateBook(book);
  }
}
