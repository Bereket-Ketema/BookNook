import 'package:book_nook/core/injection/injection_container.dart';
import 'package:book_nook/features/library/domain/usecases/get_books.dart';
import 'package:book_nook/features/library/presentation/cubit/book_cubit.dart';
import 'package:book_nook/features/library/presentation/cubit/book_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookPage extends StatelessWidget {
  const BookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookCubit(sl<GetBooksUseCase>()),
      child: const BookView(),
    );
  }
}

class BookView extends StatelessWidget {
  const BookView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book')),
      body: BlocListener<BookCubit, BookState>(
        listener: (context, state) {
          if (state is BookError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }

          if (state is BookLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Books loaded successfully'),
              ),
            );
          }
        },
        child: BlocBuilder<BookCubit, BookState>(
        builder: (context, state) {
          if (state is BookInitial) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  context.read<BookCubit>().loadBooks();
                },
                child: const Text('Load Books'),
              ),
            );
          }

          if (state is BookLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is BookLoaded) {
            return Center(child: Text(state.books.toString()));
          }

          if (state is BookError) {
            return Center(child: Text(state.message));
          }

          return const SizedBox();
        },
      ),
      ),
    );
  }
}
