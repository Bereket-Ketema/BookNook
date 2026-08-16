import 'package:dartz/dartz.dart';
import 'package:book_nook/features/library/data/exceptions/cache_exception.dart';
import 'package:book_nook/features/library/data/exceptions/server_exception.dart';
import 'package:book_nook/features/library/data/datasources/local/book_local_data_source.dart';
import 'package:book_nook/core/network/network_info.dart';
import 'package:book_nook/features/library/data/datasources/remote/book_remote_data_source.dart';
import 'package:book_nook/features/library/data/model/book_model.dart';
import 'package:book_nook/features/library/domain/entities/book.dart';
import 'package:book_nook/features/library/domain/failures/cache_failure.dart';
import 'package:book_nook/features/library/domain/failures/failure.dart';
import 'package:book_nook/features/library/domain/failures/server_failure.dart';
import 'package:book_nook/features/library/domain/repositories/book_repository.dart';

class BookRepositoryImpl implements BookRepository {
  final BookRemoteDataSource remoteDataSource;
  final BookLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  BookRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Unit>> addBook(Book book) async {
    try {
      final model = BookModel.fromEntity(book);

      await localDataSource.addBook(model);

      return const Right(unit);
    } on CacheException {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteBook(String id) async {
    try {
      await localDataSource.deleteBook(id);

      return const Right(unit);
    } on CacheException {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Book>> getBookById(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final book = await remoteDataSource.getBookById(id);

        return Right(book.toEntity());
      } on ServerException {
        return const Left(ServerFailure());
      }
    } else {
      try {
        final book = await localDataSource.getCachedBookById(id);

        return Right(book.toEntity());
      } on CacheException {
        return const Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<Book>>> getBooks() async {
    try {
      final books = await localDataSource.getCachedBooks();

      return Right(
        books.map(
          (model) => model.toEntity(),
        ).toList(),
      );
    } on CacheException {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> toggleFavorite(String id) async {
    if (!await networkInfo.isConnected) {
      return const Left(
        ServerFailure('No internet connection'),
      );
    }

    try {
      await remoteDataSource.toggleFavorite(id);

      return const Right(unit);
    } on ServerException {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> toggleReadStatus(String id) async {
    if (!await networkInfo.isConnected) {
      return const Left(
        ServerFailure('No internet connection'),
      );
    }

    try {
      await remoteDataSource.toggleReadStatus(id);

      return const Right(unit);
    } on ServerException {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateBook(Book book) async {
    try {
      final model = BookModel.fromEntity(book);

      await localDataSource.updateBook(model);

      return const Right(unit);
    } on CacheException {
      return const Left(CacheFailure());
    }
  }

}