import 'package:dantex/models/book_state.dart';
import 'package:dantex/repositories/book_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_utilities.dart';

void main() async {
  final mockDatabase = await getMockDatabase();
  final bookRef = mockDatabase.ref(BookRepository.booksPath('userId'));

  group('Given a book repository', () {
    final bookRepository = BookRepository(bookDatabase: bookRef);
    group('When the repository has books', () {
      test(
        'Then allBooks returns all the books',
        () async {
          final books = await bookRepository.allBooks().first;
          expect(books, hasLength(89));
        },
      );
      test(
        'Then booksForState returns the books in the current state',
        () async {
          final books =
              await bookRepository.booksForState(BookState.reading).first;
          expect(books, hasLength(1));
          expect(
            books.every((book) => book.state == BookState.reading),
            isTrue,
          );
        },
      );

      test(
        'Then addBookToState adds a book to the database with the correct state',
        () async {
          final book = getMockBook();
          await bookRepository.addBook(book.copyWith(state: BookState.reading));
          final books =
              await bookRepository.booksForState(BookState.reading).first;
          expect(books, hasLength(2));
        },
      );
      // test('Then overwrite books replaces the books in the database', () async {
      //   final book = getMockBook();
      //   await bookRepository.overwriteBooksFromBackup([book]);
      //   final readingBooks =
      //       await bookRepository.booksForState(BookState.reading).first;
      //   expect(readingBooks, hasLength(1));
      //   final readLaterBooks =
      //       await bookRepository.booksForState(BookState.readLater).first;
      //   expect(readLaterBooks, hasLength(0));
      //   final readBooks =
      //       await bookRepository.booksForState(BookState.read).first;
      //   expect(readBooks, hasLength(0));
      // });
      // test('Then merge books adds any books with a different ISBN', () async {
      //   final book1 = getMockBook();
      //   final book2 = getMockBook(isbn: 'isbn2');
      //   final book3 = getMockBook();
      //   await bookRepository.overwriteBooksFromBackup([book1]);
      //   await bookRepository.mergeBooksFromBackup([book2, book3]);
      //   final readingBooks =
      //       await bookRepository.booksForState(BookState.reading).first;
      //   expect(readingBooks, hasLength(2));
      // });
      // test('Then update positions updates the positions of the books',
      //     () async {
      //   final book1 = getMockBook(position: 1, id: '1');
      //   final book2 = getMockBook(position: 2, id: '2');
      //   final book3 = getMockBook(position: 3, id: '3');
      //   await bookRepository.overwriteBooksFromBackup([book1, book2, book3]);

      //   // Get the newly inserted books so we can update their positions using the
      //   // generated IDs.
      //   final books =
      //       await bookRepository.booksForState(BookState.reading).first;
      //   await bookRepository.updatePositions([
      //     books[1],
      //     books[2],
      //     books[0],
      //   ]);
      //   final readingBooks =
      //       await bookRepository.booksForState(BookState.reading).first;
      //   expect(readingBooks, hasLength(3));
      //   expect(readingBooks[0].position, 2);
      //   expect(readingBooks[1].position, 0);
      //   expect(readingBooks[2].position, 1);
      // });
      test('Then add book adds a book to the database', () async {
        final oldBooks = await bookRepository.allBooks().first;
        final book = getMockBook();
        await bookRepository.addBook(book);
        final books = await bookRepository.allBooks().first;
        expect(books, hasLength(oldBooks.length + 1));
      });
      // test('Then move book to state updates the state of a book', () async {
      //   final book = getMockBook(state: BookState.reading);
      //   await bookRepository.overwriteBooksFromBackup([book]);
      //   final books =
      //       await bookRepository.booksForState(BookState.reading).first;
      //   final readingBook = books.first;
      //   await bookRepository.moveBookToState(readingBook.id, BookState.read);
      //   final readBooks =
      //       await bookRepository.booksForState(BookState.read).first;
      //   expect(readBooks.map((b) => b.id), contains(readingBook.id));
      // });
      // test('Then delete book deletes a book from the database', () async {
      //   final book = getMockBook();
      //   await bookRepository.overwriteBooksFromBackup([book]);
      //   final books = await bookRepository.allBooks().first;
      //   final bookToDelete = books.first;
      //   await bookRepository.delete(bookToDelete.id);
      //   final newBooks = await bookRepository.allBooks().first;
      //   expect(newBooks, hasLength(books.length - 1));
      //   expect(newBooks.map((b) => b.id), isNot(contains(bookToDelete.id)));
      // });
      // test('Then getBook returns the book', () async {
      //   final book = getMockBook();
      //   await bookRepository.overwriteBooksFromBackup([book]);
      //   final books = await bookRepository.allBooks().first;
      //   final bookToGet = books.first;
      //   final bookStream = bookRepository.getBook(bookToGet.id);
      //   final bookStreamValue = await bookStream.first;
      //   expect(bookStreamValue, bookToGet);
      // });
      // test('Then update book updates the book', () async {
      //   final book = getMockBook();
      //   await bookRepository.overwriteBooksFromBackup([book]);
      //   final books = await bookRepository.allBooks().first;
      //   final bookToUpdate = books.first;
      //   final updatedBook = bookToUpdate.copyWith(
      //     title: 'Updated Title',
      //   );
      //   await bookRepository.updateBook(updatedBook);
      //   final updatedBooks = await bookRepository.allBooks().first;
      //   final updatedBookFromRepo =
      //       updatedBooks.firstWhere((b) => b.id == bookToUpdate.id);
      //   expect(updatedBookFromRepo.title, 'Updated Title');
      // });
    });
  });
}
