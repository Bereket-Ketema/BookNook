import 'package:book_nook/features/library/domain/entities/book.dart';
import 'package:book_nook/features/library/presentation/cubit/book_cubit.dart';
import 'package:book_nook/features/library/presentation/cubit/book_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final titleController = TextEditingController();
  final authorController = TextEditingController();
  final descriptionController = TextEditingController();
  final coverImageController = TextEditingController();
  final categoryController = TextEditingController();
  final publishedYearController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    titleController.dispose();
    authorController.dispose();
    descriptionController.dispose();
    coverImageController.dispose();
    categoryController.dispose();
    publishedYearController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Book')),

      body: BlocListener<BookCubit, BookState>(
        listener: (context, state) {
          if (state is BookActionSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));

            Navigator.pop(context, true);
          }

          if (state is BookActionError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: titleController,
                      decoration: const InputDecoration(labelText: 'Title'),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a title';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 12),

                    TextFormField(
                      controller: authorController,
                      decoration: const InputDecoration(labelText: 'Author'),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter an author';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 12),

                    TextFormField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a description';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 12),

                    TextFormField(
                      controller: coverImageController,
                      decoration: const InputDecoration(labelText: 'Image'),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter an Image';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 12),

                    TextFormField(
                      controller: categoryController,
                      decoration: const InputDecoration(labelText: 'Category'),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a Category';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 12),

                    TextFormField(
                      controller: publishedYearController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Year'),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter the published year';
                        }

                        if (int.tryParse(value.trim()) == null) {
                          return 'Please enter a valid year';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final book = Book(
                            id: DateTime.now().millisecondsSinceEpoch
                                .toString(),
                            title: titleController.text.trim(),
                            author: authorController.text.trim(),
                            description: descriptionController.text.trim(),
                            coverImageUrl: coverImageController.text.trim(),
                            category: categoryController.text.trim(),
                            publishedYear: int.parse(
                              publishedYearController.text.trim(),
                            ),
                            isFavorite: false,
                            isRead: false,
                          );

                          context.read<BookCubit>().addBook(book);
                        }
                      },
                      child: const Text('Add Book'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
