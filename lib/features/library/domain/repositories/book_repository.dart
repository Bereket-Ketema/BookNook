import 'package:dartz/dartz.dart';
import 'package:flutter_first/features/library/domain/entities/book.dart';
import 'package:flutter_first/features/library/domain/failures/failure.dart';

abstract class BookRepository {
  Future<Either<Failure, List<Book>>> getBooks();

  Future<Either<Failure, Book>> getBookById(String id);

  Future<Either<Failure, Unit>> addBook(Book book);

  Future<Either<Failure, Unit>> updateBook(Book book);

  Future<Either<Failure, Unit>> deleteBook(String id);

  Future<Either<Failure, Unit>> toggleFavorite(String id);

  Future<Either<Failure, Unit>> toggleReadStatus(String id);
}