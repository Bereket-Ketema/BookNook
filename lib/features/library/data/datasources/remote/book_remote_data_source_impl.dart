import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:book_nook/features/library/data/datasources/remote/book_remote_data_source.dart';
import 'package:book_nook/features/library/data/exceptions/server_exception.dart';
import 'package:book_nook/features/library/data/model/book_model.dart';

class BookRemoteDataSourceImpl implements BookRemoteDataSource {
  final HttpClient client;

  BookRemoteDataSourceImpl(this.client);

  @override
  Future<void> addBook(BookModel book) async {
    final request = await client.post('host', 5000, '/books');

    request.headers.contentType = ContentType
        .json; // we are telling the server that the body am sending is JSON

    request.write(jsonEncode(book.toJson())); // convert to json then sends

    final response = await request.close();

    if (response.statusCode != 201) {
      throw ServerException();
    }
  }

  @override
  Future<void> deleteBook(String id) async {
    final request = await client.delete('host', 5000, '/books/$id');

    final response = await request.close();

    if (response.statusCode != 204) {
      throw ServerException();
    }
  }

  @override
  Future<BookModel> getBookById(String id) async {
    final request = await client.get('host', 5000, '/books/$id');

    final response = await request.close(); //get response

    if (response.statusCode != 200) {
      throw ServerException();
    }

    final responseBody = await response.transform(utf8.decoder).join();

    final Map<String, dynamic> jsonData = jsonDecode(responseBody);

    return BookModel.fromJson(jsonData);
  }

  @override
  Future<List<BookModel>> getBooks() async {
    try {
      final request = await client
          .get(
            'host',
            5000,
            '/books',
          )
          .timeout(
            const Duration(seconds: 5),
          );

      final response = await request
          .close()
          .timeout(
            const Duration(seconds: 5),
          );

      if (response.statusCode != 200) {
        throw ServerException();
      }

      final responseBody = await response
          .transform(utf8.decoder)
          .join();

      final List<dynamic> jsonList = jsonDecode(responseBody);

      return jsonList
          .map((json) => BookModel.fromJson(json))
          .toList();
    } on TimeoutException {
      throw ServerException();
    } on SocketException {
      throw ServerException();
    }
  }

  @override
  Future<void> updateBook(BookModel book) async {
    final request = await client.put('host', 5000, '/books/${book.id}');

    request.headers.contentType = ContentType.json;

    request.write(jsonEncode(book.toJson()));

    final response = await request.close();

    if (response.statusCode != 200) {
      throw ServerException();
    }
  }

  @override
  Future<void> toggleFavorite(String id) async {
    final request = await client.patch(
      'host',
      5000,
      '/books/$id/favorite',
    );

    await request.close();
  }

  @override
  Future<void> toggleReadStatus(String id) async {
    final request = await client.patch(
      'host',
      5000,
      '/books/$id/read',
    );

    await request.close();
  }


}
