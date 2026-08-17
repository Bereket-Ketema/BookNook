import 'package:flutter/material.dart';
import 'package:book_nook/features/library/domain/entities/book.dart';

import 'book_card.dart';

class BookList extends StatelessWidget {
  final List<Book> books;
  final void Function(Book book) onEdit;
  final void Function(Book book) onDelete;

  const BookList({
    super.key,
    required this.books,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];

        return BookCard(
          book: book,
          onEdit: () => onEdit(book),
          onDelete: () => onDelete(book),
        );
      },
    );
  }
}