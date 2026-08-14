import 'package:book_nook/core/injection/injection_container.dart';
import 'package:book_nook/features/library/domain/usecases/get_books.dart';
import 'package:book_nook/features/library/presentation/cubit/book_cubit.dart';
import 'package:book_nook/features/library/presentation/cubit/book_state.dart';
import 'package:book_nook/features/library/presentation/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookPage extends StatelessWidget {
  const BookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookCubit(sl<GetBooksUseCase>()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Book Nook')),
        body: const BookView(),
      ),
    );
  }
}

class BookView extends StatefulWidget {
  const BookView({super.key});

  @override
  State<BookView> createState() => _BookViewState();
}

class _BookViewState extends State<BookView> {
  @override
  void initState() {
    super.initState();

    context.read<BookCubit>().loadBooks();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookCubit, BookState>(
      //Build my UI using the state produced by BookCubit
      builder: (context, state) {
        if (state is BookInitial) {
          return const Center(child: Text('Ready to load books'));
        }

        if (state is BookLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is BookLoaded) {
          if (state.books.isEmpty) {
            return const Center(
              child: Text('No books found'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: state.books.length,
            itemBuilder: (context, index) {
              final book = state.books[index];

              return BookCard(
                book: book,
              );
            },
          );
        }

        if (state is BookError) {
          return Center(
            child: Text(state.message),
          );
        }

        return SizedBox.shrink();
      },
    );
  }

}
