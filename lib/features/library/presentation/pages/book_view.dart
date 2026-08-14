import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/book_cubit.dart';
import '../cubit/book_state.dart';

import 'add_book_page.dart';

class BookView extends StatelessWidget {
  const BookView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Nook'),
      ),

      body: BlocBuilder<BookCubit, BookState>(
        builder: (context, state) {

          if (state is BookLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }


          if (state is BookError) {
            return Center(
              child: Text(state.message),
            );
          }


          if (state is BookLoaded) {
            if (state.books.isEmpty) {
              return const Center(
                child: Text('No books found'),
              );
            }

            return ListView.builder(
              itemCount: state.books.length,
              itemBuilder: (context, index) {

                final book = state.books[index];

                return ListTile(
                  title: Text(book.title),
                  subtitle: Text(book.author),
                );
              },
            );
          }

          return const SizedBox();
        },
      ),


      floatingActionButton: FloatingActionButton(
        onPressed: () async {

          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: context.read<BookCubit>(),
                child: const AddBookPage(),
              ),
            ),
          );

          if (result == true) {
            // ignore: use_build_context_synchronously
            context.read<BookCubit>().loadBooks();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}