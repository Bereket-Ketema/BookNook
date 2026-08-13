import 'package:flutter_first/features/library/data/model/book_model.dart';

abstract class BookRemoteDataSource {
  Future<List<BookModel>> getBooks();
  Future<BookModel> getBookById(String id);
  Future<void> addBook(BookModel book);
  Future<void> updateBook(BookModel book);
  Future<void> deleteBook(String id);
  Future<void> toggleFavorite(String id);
  Future<void> toggleReadStatus(String id);
}