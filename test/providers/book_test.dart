import 'package:dantex/models/book_state.dart';
import 'package:dantex/providers/auth.dart';
import 'package:dantex/providers/book.dart';
import 'package:dantex/providers/client.dart';
import 'package:dantex/providers/firebase.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

import '../test_utilities.dart';

void main() async {
  group('Given a booksForStateProvider', () {
    group('When the bookState is reading', () {
      test('Then the provider returns the books with state reading', () async {
        final mockDatabase = await getMockDatabase();

        final mockUser = MockUser(
          uid: 'userId',
          email: 'bob@somedomain.com',
          displayName: 'Bob',
        );

        final container = createContainer(
          overrides: [
            authStateChangesProvider.overrideWith(
              (ref) => Stream.value(mockUser),
            ),
            firebaseDatabaseProvider.overrideWithValue(mockDatabase),
          ],
        );

        final subscription = container.listen(
          booksForStateProvider(BookState.reading).future,
          (_, __) {},
        );
        await container.pump();

        final books = await subscription.read();
        expect(books, hasLength(1));
        expect(books.every((book) => book.state == BookState.reading), isTrue);
      });
    });
  });
  group('Given a searchRemoteBooksProvider', () {
    final mockGoogleBooksClient = Dio(BaseOptions());
    final dioAdapter = DioAdapter(dio: mockGoogleBooksClient);

    const path = '/volumes';
    group('When the googleBooksClient returns no data', () {
      dioAdapter.onGet(
        path,
        (server) => server.reply(
          200,
          null,
        ),
      );

      test('Then no books are returned', () async {
        final container = createContainer(
          overrides: [
            googleBooksClientProvider.overrideWithValue(mockGoogleBooksClient),
          ],
        );

        final subscription = container.listen(
          searchRemoteBooksProvider('searchTerm').future,
          (_, __) {},
        );

        await container.pump();

        final books = await subscription.read();
        expect(books, isEmpty);
      });
    });
    group('When the googleBooksClient returns some data but no items', () {
      test('Then no books are returned', () async {
        dioAdapter.onGet(
          path,
          (server) => server.reply(
            200,
            getMockGoogleBookResponse(items: []).toJson(),
          ),
        );
        final container = createContainer(
          overrides: [
            googleBooksClientProvider.overrideWithValue(mockGoogleBooksClient),
          ],
        );

        final subscription = container.listen(
          searchRemoteBooksProvider('searchTerm').future,
          (_, __) {},
        );

        await container.pump();

        final books = await subscription.read();
        expect(books, isEmpty);
      });
    });
    group('When the googleBooksClient return some data with items', () {
      test('Then no books are returned', () async {
        dioAdapter.onGet(
          path,
          (server) => server.reply(
            200,
            getMockGoogleBookResponse().toJson(),
          ),
        );
        final container = createContainer(
          overrides: [
            googleBooksClientProvider.overrideWithValue(mockGoogleBooksClient),
          ],
        );

        final subscription = container.listen(
          searchRemoteBooksProvider('searchTerm').future,
          (_, __) {},
        );

        await container.pump();

        final books = await subscription.read();
        expect(books, isNotEmpty);
      });
    });
  });
}
