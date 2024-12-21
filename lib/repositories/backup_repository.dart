import 'dart:convert';

import 'package:dantex/models/backup_data.dart';
import 'package:dantex/models/book.dart';
import 'package:dantex/models/book_label.dart';
import 'package:dantex/models/book_state.dart';
import 'package:dantex/models/dante_language.dart';
import 'package:dantex/models/page_record.dart';
import 'package:device_marketing_names/device_marketing_names.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:ulid/ulid.dart';

class BackupRepository {
  const BackupRepository({required DriveApi driveApi}) : _driveApi = driveApi;

  final DriveApi _driveApi;

  Future<List<BackupData>> listGoogleDriveBackups() async {
    final response = await _driveApi.files.list(
      spaces: 'appDataFolder',
      q: "mimeType = 'application/json'",
    );

    final files = response.files;
    if (files == null) {
      return [];
    }

    return files.map((file) {
      final fileName = file.name;
      String? deviceName;
      var isLegacyBackup = true;
      var timeStamp = DateTime.now();
      var bookCount = 0;

      if (fileName != null) {
        final data = fileName
            .split(RegExp('_'))
            .where(
              (it) => it.isNotEmpty,
            )
            .toList();

        // We have a legacy backup.
        if (data.length == 5) {
          deviceName = fileName.substring(
            fileName.indexOf(data[4]),
            fileName.lastIndexOf('.'),
          );
          isLegacyBackup = true;
        } else {
          // We have a new backup.
          deviceName = fileName.substring(
            fileName.indexOf(data[4]),
            fileName.lastIndexOf('_'),
          );
          isLegacyBackup = false;
        }

        final oldTimeStamp = int.tryParse(data[2]) ?? 0;
        if (oldTimeStamp > 0) {
          timeStamp = DateTime.fromMillisecondsSinceEpoch(oldTimeStamp);
        }

        bookCount = int.tryParse(data[3]) ?? 0;
      }

      return BackupData(
        id: file.id ?? 'missing-id',
        device: deviceName ?? 'missing-device',
        fileName: fileName ?? 'missing-file-name',
        bookCount: bookCount,
        timeStamp: timeStamp,
        isLegacyBackup: isLegacyBackup,
      );
    }).toList();
  }

  Future<List<Book>> fetchBackup(
    String id, {
    bool isLegacyBackup = true,
  }) async {
    final response = await _driveApi.files.get(
      id,
      downloadOptions: DownloadOptions.fullMedia,
    );

    if (response is! Media) {
      return [];
    }

    final backupJson = await utf8.decodeStream(response.stream);
    final backupData = jsonDecode(backupJson) as Map<String, dynamic>;

    final booksList = backupData['books'] as List<dynamic>? ?? [];
    final books = booksList.cast<Map<String, dynamic>>();

    final recordList = backupData['records'] as List<dynamic>? ?? [];
    final pageRecordMap = recordList.cast<Map<String, dynamic>>();

    if (isLegacyBackup) {
      final pageRecords = pageRecordMap.map(_convertLegacyPageRecord).toList();
      return books.map((legacyBook) {
        final bookPageRecords = pageRecords
            .where((record) => record.bookId == legacyBook['id'].toString())
            .toList();
        return _convertLegacyBook(legacyBook, bookPageRecords);
      }).toList();
    } else {
      return books.map(Book.fromJson).toList();
    }
  }

  Future<void> delete(String id) async {
    await _driveApi.files.delete(id);
  }

  Future<void> createBackup(List<Book> books) async {
    final backupData = {
      'books': books.map((book) => book.toJson()).toList(),
    };

    final backupJson = jsonEncode(backupData);
    final utf8EncodedBackupJson = utf8.encode(backupJson);
    final timeStamp = DateTime.now().millisecondsSinceEpoch;
    final deviceNames = DeviceMarketingNames();
    final deviceName = await deviceNames.getSingleName();
    final fileName =
        'google-drive_man_${timeStamp}_${books.length}_${deviceName}_v2.json';

    await _driveApi.files.create(
      File.fromJson({
        'name': fileName,
        'mimeType': 'application/json',
        'parents': ['appDataFolder'],
      }),
      uploadMedia: Media(
        Stream.value(utf8EncodedBackupJson),
        utf8EncodedBackupJson.length,
      ),
    );
  }
}

Book _convertLegacyBook(
  Map<String, dynamic> legacyBook,
  List<PageRecord> records,
) {
  final labelsList = legacyBook['labels'] as List<dynamic>;
  final labelsData = labelsList.cast<Map<String, dynamic>>();
  final labels = labelsData.map(_convertLegacyBookLabel).toList();

  return Book(
    id: (legacyBook['id'] as int).toString(),
    title: legacyBook['title'] as String,
    subTitle: legacyBook['subTitle'] as String,
    author: legacyBook['author'] as String,
    state: convertLegacyBookState(legacyBook['state'] as String),
    pageCount: legacyBook['pageCount'] as int,
    currentPage: legacyBook['currentPage'] as int,
    publishedDate: legacyBook['publishedDate'] as String,
    position: legacyBook['position'] as int,
    isbn: legacyBook['isbn'] as String,
    thumbnailAddress: legacyBook['thumbnailAddress'] as String?,
    startDate: legacyBook['startDate'] == 0
        ? null
        : DateTime.fromMillisecondsSinceEpoch(legacyBook['startDate'] as int),
    endDate: legacyBook['endDate'] == 0
        ? null
        : DateTime.fromMillisecondsSinceEpoch(legacyBook['endDate'] as int),
    forLaterDate: legacyBook['forLaterDate'] == 0
        ? null
        : DateTime.fromMillisecondsSinceEpoch(
            legacyBook['wishlistDate'] as int,
          ),
    language: languageFromIsoCode(legacyBook['language'] as String),
    rating: legacyBook['rating'] as int,
    notes: legacyBook['notes'] as String?,
    summary: legacyBook['summary'] as String?,
    labels: labels,
    googleBooksLink: legacyBook['googleBooksLink'] as String?,
    pageRecords: records,
  );
}

PageRecord _convertLegacyPageRecord(Map<String, dynamic> legacyRecord) {
  return PageRecord(
    id: Ulid().toString(),
    bookId: (legacyRecord['bookId'] as int).toString(),
    fromPage: legacyRecord['fromPage'] as int,
    toPage: legacyRecord['toPage'] as int,
    timestamp: DateTime.fromMillisecondsSinceEpoch(
      legacyRecord['timestamp'] as int,
    ),
  );
}

BookLabel _convertLegacyBookLabel(Map<String, dynamic> legacyLabel) {
  return BookLabel(
    // This ID comes from Firebase, so for now can just use -1 as placeholder.
    id: '-1',
    hexColor: legacyLabel['hexColor'] as String,
    title: legacyLabel['title'] as String,
  );
}
