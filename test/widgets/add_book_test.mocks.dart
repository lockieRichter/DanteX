// Mocks generated by Mockito 5.4.4 from annotations
// in dantex/test/widgets/add_book_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:dantex/models/book.dart' as _i4;
import 'package:dantex/models/book_state.dart' as _i5;
import 'package:dantex/repositories/book_repository.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [BookRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockBookRepository extends _i1.Mock implements _i2.BookRepository {
  MockBookRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Stream<List<_i4.Book>> allBooks() => (super.noSuchMethod(
        Invocation.method(
          #allBooks,
          [],
        ),
        returnValue: _i3.Stream<List<_i4.Book>>.empty(),
      ) as _i3.Stream<List<_i4.Book>>);

  @override
  _i3.Stream<List<_i4.Book>> booksForState(_i5.BookState? bookState) =>
      (super.noSuchMethod(
        Invocation.method(
          #booksForState,
          [bookState],
        ),
        returnValue: _i3.Stream<List<_i4.Book>>.empty(),
      ) as _i3.Stream<List<_i4.Book>>);

  @override
  _i3.Future<void> addBookToState(
    _i4.Book? book,
    _i5.BookState? bookState,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #addBookToState,
          [
            book,
            bookState,
          ],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> clearBooks() => (super.noSuchMethod(
        Invocation.method(
          #clearBooks,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> overwriteBooks(List<_i4.Book>? books) => (super.noSuchMethod(
        Invocation.method(
          #overwriteBooks,
          [books],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> mergeBooks(List<_i4.Book>? books) => (super.noSuchMethod(
        Invocation.method(
          #mergeBooks,
          [books],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> updatePositions(List<_i4.Book>? books) =>
      (super.noSuchMethod(
        Invocation.method(
          #updatePositions,
          [books],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> addBook(_i4.Book? book) => (super.noSuchMethod(
        Invocation.method(
          #addBook,
          [book],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
}
