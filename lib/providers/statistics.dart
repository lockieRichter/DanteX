import 'dart:collection';

import 'package:dantex/models/book_state.dart';
import 'package:dantex/providers/book.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'statistics.g.dart';

const zeroBookCount = (readLaterCount: 0, readingCount: 0, readCount: 0);

@riverpod
({int readLaterCount, int readingCount, int readCount}) bookCounts(Ref ref) {
  final books = ref.watch(allBooksProvider);

  return books.when(
    data: (books) {
      final readLaterCount =
          books.where((book) => book.state == BookState.readLater).length;
      final readingCount =
          books.where((book) => book.state == BookState.reading).length;
      final readCount =
          books.where((book) => book.state == BookState.read).length;

      return (
        readLaterCount: readLaterCount,
        readingCount: readingCount,
        readCount: readCount
      );
    },
    error: (e, s) => zeroBookCount,
    loading: () => zeroBookCount,
  );
}

const zeroPageCount = (pagesWaiting: 0, pagesRead: 0);

@riverpod
({int pagesWaiting, int pagesRead}) pageCounts(Ref ref) {
  final books = ref.watch(allBooksProvider);

  return books.when(
    data: (books) {
      final pagesWaiting = books
          .where((book) => book.state == BookState.readLater)
          .map((book) => book.pageCount)
          .fold<int>(0, (prev, pages) => prev + pages);
      final pagesRead = books
          .where((book) => book.state == BookState.read)
          .map((book) => book.pageCount)
          .fold<int>(0, (prev, pages) => prev + pages);
      return (pagesWaiting: pagesWaiting, pagesRead: pagesRead);
    },
    error: (e, s) => zeroPageCount,
    loading: () => zeroPageCount,
  );
}

typedef BooksPerMonthStats = Map<DateTime, int>;

@riverpod
BooksPerMonthStats booksPerMonthStats(Ref ref) {
  final books = ref.watch(booksForStateProvider(BookState.read));

  return books.when(
    data: (books) {
      final stats = BooksPerMonthStats();
      for (final book in books) {
        final endDate = book.endDate;
        if (endDate == null) {
          continue;
        }

        final month = DateTime(endDate.year, endDate.month);
        stats.update(month, (count) => count + 1, ifAbsent: () => 1);
      }

      return SplayTreeMap.from(stats);
    },
    error: (e, s) => {},
    loading: () => {},
  );
}

typedef PagesPerMonthStats = Map<DateTime, int>;

@riverpod
PagesPerMonthStats pagesPerMonthStats(Ref ref) {
  final books = ref.watch(booksForStateProvider(BookState.read));

  return books.when(
    data: (books) {
      final stats = PagesPerMonthStats();
      for (final book in books) {
        final endDate = book.endDate;
        if (endDate == null) {
          continue;
        }

        final month = DateTime(endDate.year, endDate.month);
        stats.update(
          month,
          (count) => count + book.pageCount,
          ifAbsent: () => book.pageCount,
        );
      }

      return SplayTreeMap.from(stats);
    },
    error: (e, s) => {},
    loading: () => {},
  );
}

typedef BooksPerYearStats = Map<DateTime, int>;

@riverpod
BooksPerYearStats booksPerYearStats(Ref ref) {
  final books = ref.watch(booksForStateProvider(BookState.read));

  return books.when(
    data: (books) {
      final stats = BooksPerYearStats();
      for (final book in books) {
        final endDate = book.endDate;
        if (endDate == null) {
          continue;
        }

        final month = DateTime(endDate.year);
        stats.update(month, (count) => count + 1, ifAbsent: () => 1);
      }

      return SplayTreeMap.from(stats);
    },
    error: (e, s) => {},
    loading: () => {},
  );
}
