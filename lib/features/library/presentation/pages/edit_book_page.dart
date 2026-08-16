import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:book_nook/features/library/domain/entities/book.dart';
import '../cubit/book_cubit.dart';
import '../cubit/book_state.dart';

class EditBookPage extends StatefulWidget {
  final Book book;

  const EditBookPage({super.key, required this.book});

  @override
  State<EditBookPage> createState() => _EditBookPageState();
}

class _EditBookPageState extends State<EditBookPage> {
  final titleController = TextEditingController();
  final authorController = TextEditingController();
  final descriptionController = TextEditingController();
  final coverImageController = TextEditingController();
  final categoryController = TextEditingController();
  final publishedYearController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    titleController.text = widget.book.title;
    authorController.text = widget.book.author;
    descriptionController.text = widget.book.description;
    coverImageController.text = widget.book.coverImageUrl;
    categoryController.text = widget.book.category;
    publishedYearController.text = widget.book.publishedYear.toString();
  }

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
      appBar: AppBar(
        title: const Text('Edit Book'),
      ),
      body: BlocListener<BookCubit, BookState>(
        listener: (context, state) {
          if (state is BookActionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );

            Navigator.pop(context, true);
          }

          if (state is BookActionError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
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
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final updatedBook = Book(
                        id: widget.book.id,
                        title: titleController.text.trim(),
                        author: authorController.text.trim(),
                        description: descriptionController.text.trim(),
                        coverImageUrl: coverImageController.text.trim(),
                        category: categoryController.text.trim(),
                        publishedYear: int.parse(
                          publishedYearController.text.trim(),
                        ),
                        isFavorite: widget.book.isFavorite,
                        isRead: widget.book.isRead,
                      );

                      context.read<BookCubit>().updateBook(updatedBook);
                    }
                  },
                  child: const Text('Update Book'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
