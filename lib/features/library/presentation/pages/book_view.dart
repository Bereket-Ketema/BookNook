import 'package:book_nook/features/library/presentation/pages/edit_book_page.dart';
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

      body: BlocConsumer<BookCubit, BookState>(
        listener: (context, state) {
          if (state is BookActionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }

          if (state is BookActionError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
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
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // EDIT
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () async {
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
                            // ignore: use_build_context_synchronously
                            context.read<BookCubit>().loadBooks();
                          }
                        },
                      ),

                      // DELETE
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
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
                            context.read<BookCubit>().deleteBook(book.id);
                          }
                        },
                      ),
                    ],
                  ),
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