import 'package:dantex/models/book.dart';
import 'package:dantex/models/book_state.dart';
import 'package:dantex/models/dante_language.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_recommendation.freezed.dart';
part 'book_recommendation.g.dart';

@freezed
class BookRecommendation with _$BookRecommendation {
  const factory BookRecommendation({
    required String suggestionId,
    required BookRecommender suggester,
    required RecommendedBook suggestion,
    required String recommendation,
  }) = _BookRecommendation;

  factory BookRecommendation.fromJson(Map<String, dynamic> json) =>
      _$BookRecommendationFromJson(json);
}

@freezed
class RecommendedBook with _$RecommendedBook {
  const factory RecommendedBook({
    required String title,
    required String subTitle,
    required String author,
    required String state,
    required int pageCount,
    required String publishedDate,
    required String isbn,
    required String language,
    String? thumbnailAddress,
    String? summary,
  }) = _RecommendedBook;

  const RecommendedBook._();

  factory RecommendedBook.fromJson(Map<String, dynamic> json) =>
      _$RecommendedBookFromJson(json);

  factory RecommendedBook.fromBook(Book book) {
    return RecommendedBook(
      title: book.title,
      subTitle: book.subTitle,
      author: book.author,
      state: book.state.name,
      pageCount: book.pageCount,
      publishedDate: book.publishedDate,
      isbn: book.isbn,
      thumbnailAddress: book.thumbnailAddress,
      language: book.language.isoCode,
      summary: book.summary,
    );
  }

  Book get toBook => Book(
        id: '',
        title: title,
        subTitle: subTitle,
        author: author,
        state: state.toBookState(),
        pageCount: pageCount,
        currentPage: 0,
        publishedDate: publishedDate,
        position: 0,
        isbn: isbn,
        thumbnailAddress: thumbnailAddress,
        startDate: null,
        endDate: null,
        forLaterDate: null,
        language: languageFromIsoCode(language),
        rating: 0,
        notes: null,
        summary: summary,
        googleBooksLink: '',
      );
}

@freezed
class BookRecommender with _$BookRecommender {
  const factory BookRecommender({
    required String name,
    String? picture,
  }) = _BookRecommender;

  factory BookRecommender.fromJson(Map<String, dynamic> json) =>
      _$BookRecommenderFromJson(json);
}

@freezed
class RecommendationRequest with _$RecommendationRequest {
  const factory RecommendationRequest({
    required String recommendation,
    required RecommendedBook suggestion,
  }) = _RecommendationRequest;

  factory RecommendationRequest.fromJson(Map<String, dynamic> json) =>
      _$RecommendationRequestFromJson(json);
}
