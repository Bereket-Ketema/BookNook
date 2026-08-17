import 'package:book_nook/features/library/domain/entities/book.dart';
import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final Book book;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const BookCard({
    super.key,
    required this.book,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              Colors.grey.shade50,
            ],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF6C63FF),
                  Color(0xFF9D8DFF),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.book,
              color: Colors.white,
              size: 28,
            ),
          ),
          title: Text(
            book.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A2E),
              letterSpacing: 0.3,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(
              children: [
                Icon(
                  Icons.person_outline,
                  size: 14,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    book.author,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade700,
                      letterSpacing: 0.2,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          trailing: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.edit_outlined,
                    color: Color(0xFF6C63FF),
                    size: 20,
                  ),
                  onPressed: onEdit,
                  splashRadius: 20,
                  padding: const EdgeInsets.all(8),
                  constraints: const BoxConstraints(),
                ),
                Container(
                  width: 1,
                  height: 24,
                  color: Colors.grey.shade300,
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Color(0xFFFF6B6B),
                    size: 20,
                  ),
                  onPressed: onDelete,
                  splashRadius: 20,
                  padding: const EdgeInsets.all(8),
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
          onTap: () {
            // Optional: Add tap feedback or navigation
            // Keep your existing onTap logic if any
          },
        ),
      ),
    );
  }
}