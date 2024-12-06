import 'package:dantex/models/book.dart';
import 'package:dantex/models/book_state.dart';
import 'package:dantex/models/google_books_response.dart';
import 'package:dantex/providers/auth.dart';
import 'package:dantex/providers/client.dart';
import 'package:dantex/providers/firebase.dart';
import 'package:dantex/repositories/book_image_repository.dart';
import 'package:dantex/repositories/book_repository.dart';
import 'package:dantex/repositories/recommendations_repository.dart';
import 'package:dantex/repositories/user_image_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'book.g.dart';

@riverpod
DatabaseReference? bookDatabaseRef(Ref ref) {
  final database = ref.watch(firebaseDatabaseProvider);

  // Only watch authStateChanges here so that the database reference is only
  // recreated when the user signs in or out.
  final userId = ref.watch(authStateChangesProvider).value?.uid;
  if (userId == null) {
    return null;
  }

  return database.ref(BookRepository.booksPath(userId));
}

@riverpod
Reference? bookImageStorageRef(Ref ref) {
  final storage = ref.watch(firebaseStorageProvider);

  // Only watch authStateChanges here so that the database reference is only
  // recreated when the user signs in or out.
  final userId = ref.watch(authStateChangesProvider).value?.uid;
  if (userId == null) {
    return null;
  }

  return storage.ref(BookImageRepository.imagesPath(userId));
}

@riverpod
Reference? userImageStorageRef(Ref ref) {
  final storage = ref.watch(firebaseStorageProvider);

  // Only watch authStateChanges here so that the database reference is only
  // recreated when the user signs in or out.
  final userId = ref.watch(authStateChangesProvider).value?.uid;
  if (userId == null) {
    return null;
  }

  return storage.ref(UserImageRepository.imagesPath(userId));
}

@riverpod
BookRepository bookRepository(Ref ref) {
  final bookDatabase = ref.watch(bookDatabaseRefProvider);

  if (bookDatabase == null) {
    throw Exception('Database reference is null');
  }

  return BookRepository(bookDatabase: bookDatabase);
}

@riverpod
Stream<List<Book>> allBooks(Ref ref) =>
    ref.watch(bookRepositoryProvider).allBooks();

@riverpod
Stream<List<Book>> booksForState(Ref ref, BookState bookState) =>
    ref.watch(bookRepositoryProvider).booksForState(bookState).map(
          (books) => books
            ..sort(
              (a, b) => a.position.compareTo(b.position),
            ),
        );

@riverpod
Future<List<Book>> searchRemoteBooks(
  Ref ref,
  String searchTerm,
) async {
  final googleBooksClient = ref.watch(googleBooksClientProvider);
  final response = await googleBooksClient.get<Map<String, dynamic>>(
    '/volumes',
    queryParameters: <String, dynamic>{
      'q': searchTerm,
    },
  );

  final data = response.data;
  if (data == null) {
    return [];
  }

  final parsedResponse = GoogleBooksResponse.fromJson(data);

  final items = parsedResponse.items;

  return items.map((e) => e.toBook()).nonNulls.toList();
}

@riverpod
Future<String> scanIsbn(Ref ref) async => FlutterBarcodeScanner.scanBarcode(
      '#00000000', // Transparent line
      'add_book.cancel_scan'.tr(),
      false,
      ScanMode.BARCODE,
    );

@Riverpod(keepAlive: true)
class BackupInProgressNotifier extends _$BackupInProgressNotifier {
  @override
  bool build() => false;

  void start() => state = true;

  void done() => state = false;
}

@riverpod
Stream<Book?> book(Ref ref, String bookId) =>
    ref.watch(bookRepositoryProvider).getBook(bookId);

@riverpod
RecommendationsRepository recommendationsRepository(Ref ref) {
  final user = ref.watch(userProvider).value;
  final client = ref.watch(recommendationsClientProvider);

  return RecommendationsRepository(authToken: user?.authToken, client: client);
}

@riverpod
BookImageRepository bookImageRepository(Ref ref) {
  final bookImageStorageRef = ref.watch(bookImageStorageRefProvider);

  if (bookImageStorageRef == null) {
    throw Exception('Book image storage reference is null');
  }

  return BookImageRepository(bookImageStorageRef: bookImageStorageRef);
}

@riverpod
UserImageRepository userImageRepository(Ref ref) {
  final userImageStorageRef = ref.watch(userImageStorageRefProvider);

  if (userImageStorageRef == null) {
    throw Exception('User image storage reference is null');
  }

  return UserImageRepository(userImageStorageRef: userImageStorageRef);
}
