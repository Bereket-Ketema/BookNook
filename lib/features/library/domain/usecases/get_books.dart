import 'package:dartz/dartz.dart';
import 'package:book_nook/features/library/domain/entities/book.dart';
import 'package:book_nook/features/library/domain/failures/failure.dart';
import 'package:book_nook/features/library/domain/repositories/book_repository.dart';

class GetBooksUseCase {
  final BookRepository repository;

  GetBooksUseCase(this.repository);

  Future<Either<Failure, List<Book>>> call() async {

    final result = await repository.getBooks();

    return result;
  }
}