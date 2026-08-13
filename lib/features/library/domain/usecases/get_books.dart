import 'package:dartz/dartz.dart';
import 'package:flutter_first/features/library/domain/entities/book.dart';
import 'package:flutter_first/features/library/domain/failures/failure.dart';
import 'package:flutter_first/features/library/domain/repositories/book_repository.dart';

class GetBooksUseCase {
  final BookRepository repository;

  GetBooksUseCase(this.repository);

  Future<Either<Failure, List<Book>>> call() {
    return repository.getBooks();
  }
}