import 'dart:convert';

import 'package:book_nook/features/library/data/datasources/local/book_local_data_source.dart';
import 'package:book_nook/features/library/data/exceptions/cache_exception.dart';
import 'package:book_nook/features/library/data/model/book_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookLocalDataSourceImpl implements BookLocalDataSource {
  final SharedPreferences preferences;

  BookLocalDataSourceImpl(this.preferences);

  static const String cachedBooksKey = 'CACHED_BOOKS';

  @override
  Future<void> cacheBooks(List<BookModel> books) async {
    final jsonList = books
        .map((book) => book.toJson())
        .toList();

    final jsonString = jsonEncode(jsonList);

    await preferences.setString(
      cachedBooksKey,
      jsonString,
    );
  }

  @override
  Future<BookModel> getCachedBookById(String id) async {
    final books = await getCachedBooks();

    return books.firstWhere(
      (book) => book.id == id,
    );
  }

  @override
  Future<List<BookModel>> getCachedBooks() async {
    final jsonString =
        preferences.getString(cachedBooksKey);

    if (jsonString == null) {
      throw CacheException();
    }

    final List<dynamic> jsonList =
        jsonDecode(jsonString);

    return jsonList
        .map((json) => BookModel.fromJson(json))
        .toList();
  }


  @override
  Future<void> addBook(BookModel book) async {
    List<BookModel> books;

    try {
      books = await getCachedBooks();
    } on CacheException {
      books = [];
    }

    books.add(book);

    await cacheBooks(books);
  }


  @override
  Future<void> updateBook(BookModel book) async {
    final books = await getCachedBooks();

    final index = books.indexWhere(
      (item) => item.id == book.id,
    );

    if (index == -1) {
      throw CacheException();
    }

    books[index] = book;

    await cacheBooks(books);
  }


  @override
  Future<void> deleteBook(String id) async {
    final books = await getCachedBooks();

    books.removeWhere(
      (book) => book.id == id,
    );

    await cacheBooks(books);
  }
}