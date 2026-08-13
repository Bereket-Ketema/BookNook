import 'dart:io';

import 'package:book_nook/core/network/network_info_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:book_nook/core/network/network_info.dart';

import 'package:book_nook/features/library/data/datasources/local/book_local_data_source.dart';
import 'package:book_nook/features/library/data/datasources/local/book_local_data_source_impl.dart';
import 'package:book_nook/features/library/data/datasources/remote/book_remote_data_source.dart';
import 'package:book_nook/features/library/data/datasources/remote/book_remote_data_source_impl.dart';

import 'package:book_nook/features/library/domain/repositories/book_repository.dart';

import 'package:book_nook/features/library/data/repositories/book_repository_impl.dart';

import 'package:book_nook/features/library/domain/usecases/get_books.dart';
import 'package:book_nook/features/library/domain/usecases/get_book_by_id.dart';
import 'package:book_nook/features/library/domain/usecases/add_book.dart';
import 'package:book_nook/features/library/domain/usecases/update_book.dart';
import 'package:book_nook/features/library/domain/usecases/delete_book.dart';
import 'package:book_nook/features/library/domain/usecases/toggle_favorite.dart';
import 'package:book_nook/features/library/domain/usecases/toggle_read_status.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final preferences = await SharedPreferences.getInstance();

  // SharedPreferences
  sl.registerLazySingleton<SharedPreferences>(
    () => preferences,
  );

  // Network
  sl.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker.createInstance(),
  );

  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      sl<InternetConnectionChecker>(),
    ),
  );

  // HTTP
  sl.registerLazySingleton<HttpClient>(
    () => HttpClient(),
  );

  // Local Data Source
  sl.registerLazySingleton<BookLocalDataSource>(
    () => BookLocalDataSourceImpl(
      sl<SharedPreferences>(),
    ),
  );

  // Remote Data Source
  sl.registerLazySingleton<BookRemoteDataSource>(
    () => BookRemoteDataSourceImpl(
      sl<HttpClient>(),
    ),
  );

  // Repository
  sl.registerLazySingleton<BookRepository>(
    () => BookRepositoryImpl(
      remoteDataSource: sl<BookRemoteDataSource>(),
      localDataSource: sl<BookLocalDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton<GetBooksUseCase>(
    () => GetBooksUseCase(sl<BookRepository>()),
  );

  sl.registerLazySingleton<GetBookByIdUseCase>(
    () => GetBookByIdUseCase(sl<BookRepository>()),
  );

  sl.registerLazySingleton<AddBookUseCase>(
    () => AddBookUseCase(sl<BookRepository>()),
  );

  sl.registerLazySingleton<UpdateBookUseCase>(
    () => UpdateBookUseCase(sl<BookRepository>()),
  );

  sl.registerLazySingleton<DeleteBookUseCase>(
    () => DeleteBookUseCase(sl<BookRepository>()),
  );

  sl.registerLazySingleton<ToggleFavoriteUseCase>(
    () => ToggleFavoriteUseCase(sl<BookRepository>()),
  );

  sl.registerLazySingleton<ToggleReadStatusUseCase>(
    () => ToggleReadStatusUseCase(sl<BookRepository>()),
  );
}