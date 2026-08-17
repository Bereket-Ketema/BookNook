import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:book_nook/features/library/presentation/pages/edit_book_page.dart';
import 'package:book_nook/features/library/presentation/widgets/book_list.dart';

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

      body: BlocConsumer<BookCubit, BookState>(
        listener: (context, state) {
        },

        builder: (context, state) {
          // LOADING
          if (state is BookLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // ERROR
          if (state is BookError) {
            return Center(
              child: Text(state.message),
            );
          }

          // LOADED
          if (state is BookLoaded) {
            // EMPTY
            if (state.books.isEmpty) {
              return const Center(
                child: Text('No books found'),
              );
            }

            // BOOK LIST
            return BookList(
              books: state.books,

              onEdit: (book) async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: context.read<BookCubit>(),
                      child: EditBookPage(
                        book: book,
                      ),
                    ),
                  ),
                );

                if (result == true) {
                  // Reload books after editing
                  // ignore: use_build_context_synchronously
                  context.read<BookCubit>().loadBooks();
                }
              },

              onDelete: (book) async {
                final confirmed = await showDialog<bool>(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text(
                        'Delete Book',
                      ),

                      content: const Text(
                        'Are you sure you want to delete this book?',
                      ),

                      actions: [
                        // CANCEL
                        TextButton(
                          onPressed: () {
                            Navigator.pop(
                              context,
                              false,
                            );
                          },
                          child: const Text(
                            'Cancel',
                          ),
                        ),

                        // DELETE
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(
                              context,
                              true,
                            );
                          },
                          child: const Text(
                            'Delete',
                          ),
                        ),
                      ],
                    );
                  },
                );

                if (confirmed == true) {
                  // ignore: use_build_context_synchronously
                  context.read<BookCubit>().deleteBook(
                        book.id,
                      );
                }
              },
            );
          }

          // INITIAL / UNKNOWN STATE
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
            // Reload books after adding
            // ignore: use_build_context_synchronously
            context.read<BookCubit>().loadBooks();
          }
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}