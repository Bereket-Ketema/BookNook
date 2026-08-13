import 'package:book_nook/features/library/data/model/book_model.dart';

abstract class BookLocalDataSource {
  Future<List<BookModel>> getCachedBooks();

  Future<void> cacheBooks(List<BookModel> books);
  Future<BookModel> getCachedBookById(String id);
}