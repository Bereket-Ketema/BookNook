import 'package:dartz/dartz.dart';
import 'package:book_nook/features/library/domain/entities/book.dart';
import 'package:book_nook/features/library/domain/failures/failure.dart';
import 'package:book_nook/features/library/domain/repositories/book_repository.dart';

class GetBookByIdUseCase {
  final BookRepository repository;

  GetBookByIdUseCase(this.repository);

  Future<Either<Failure, Book>> call(String id) {
    return repository.getBookById(id);
  }
}
