import 'dart:convert';

import 'package:book_nook/features/library/data/datasources/local/book_local_data_source.dart';
import 'package:book_nook/features/library/data/exceptions/cache_exception.dart';
import 'package:book_nook/features/library/data/model/book_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookLocalDataSourceImpl implements BookLocalDataSource {
  final SharedPreferences preferences;

  BookLocalDataSourceImpl(this.preferences);//dependency injection

  static const String cachedBooksKey = 'CACHED_BOOKS';// sharedPreferences stores data using keys

  @override
  Future<void> cacheBooks(List<BookModel> books) async {
    final jsonList = books.map((book) => book.toJson()).toList();

    final jsonString = jsonEncode(jsonList);

    await preferences.setString(cachedBooksKey, jsonString);// saving
  }
  
  @override
  Future<BookModel> getCachedBookById(String id) async {
    final books = await getCachedBooks();

    return books.firstWhere((book) => book.id == id);
  }

  @override
  Future<List<BookModel>> getCachedBooks() async {
    final jsonString = preferences.getString(cachedBooksKey);

    if (jsonString == null) {
      throw CacheException();
    }

    final List<dynamic> jsonList = jsonDecode(jsonString);

    return jsonList.map((json) => BookModel.fromJson(json)).toList();
  }
}
