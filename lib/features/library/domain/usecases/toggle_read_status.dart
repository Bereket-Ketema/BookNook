import 'package:dartz/dartz.dart';
import 'package:flutter_first/features/library/domain/failures/failure.dart';
import 'package:flutter_first/features/library/domain/repositories/book_repository.dart';

class ToggleReadStatusUseCase {
  final BookRepository repository;

  ToggleReadStatusUseCase(this.repository);

  Future<Either<Failure, Unit>> call(String id) {
    return repository.toggleReadStatus(id);
  }
}
