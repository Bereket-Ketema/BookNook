import 'package:dartz/dartz.dart';
import 'package:flutter_first/features/library/domain/failures/failure.dart';
import 'package:flutter_first/features/library/domain/repositories/book_repository.dart';

class ToggleFavoriteUseCase {
  final BookRepository repository;

  ToggleFavoriteUseCase(this.repository);

  Future<Either<Failure, Unit>> call(String id) {
    return repository.toggleFavorite(id);
  }
}
