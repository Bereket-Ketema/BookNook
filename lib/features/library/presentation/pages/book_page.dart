import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:book_nook/core/injection/injection_container.dart';

import 'package:book_nook/features/library/domain/usecases/get_books.dart';
import 'package:book_nook/features/library/domain/usecases/add_book.dart';
import 'package:book_nook/features/library/domain/usecases/update_book.dart';
import 'package:book_nook/features/library/domain/usecases/delete_book.dart';

import '../cubit/book_cubit.dart';
import 'book_view.dart';

class BookPage extends StatelessWidget {
  const BookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BookCubit(
        sl<GetBooksUseCase>(),
        sl<AddBookUseCase>(),
        sl<UpdateBookUseCase>(),
        sl<DeleteBookUseCase>(),
      )..loadBooks(),
      child: const BookView(),
    );
  }
}