// Mocks generated by Mockito 5.4.5 from annotations
// in dantex/test/ui/backup/backup_list_card_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:dantex/models/backup_data.dart' as _i4;
import 'package:dantex/models/book.dart' as _i5;
import 'package:dantex/repositories/backup_repository.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [BackupRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockBackupRepository extends _i1.Mock implements _i2.BackupRepository {
  MockBackupRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i4.BackupData>> listGoogleDriveBackups() =>
      (super.noSuchMethod(
        Invocation.method(
          #listGoogleDriveBackups,
          [],
        ),
        returnValue: _i3.Future<List<_i4.BackupData>>.value(<_i4.BackupData>[]),
      ) as _i3.Future<List<_i4.BackupData>>);

  @override
  _i3.Future<List<_i5.Book>> fetchBackup(
    String? id, {
    bool? isLegacyBackup = true,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchBackup,
          [id],
          {#isLegacyBackup: isLegacyBackup},
        ),
        returnValue: _i3.Future<List<_i5.Book>>.value(<_i5.Book>[]),
      ) as _i3.Future<List<_i5.Book>>);

  @override
  _i3.Future<void> delete(String? id) => (super.noSuchMethod(
        Invocation.method(
          #delete,
          [id],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> createBackup(List<_i5.Book>? books) => (super.noSuchMethod(
        Invocation.method(
          #createBackup,
          [books],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> overwriteBooksFromBackup(List<_i5.Book>? books) =>
      (super.noSuchMethod(
        Invocation.method(
          #overwriteBooksFromBackup,
          [books],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> mergeBooksFromBackup(List<_i5.Book>? books) =>
      (super.noSuchMethod(
        Invocation.method(
          #mergeBooksFromBackup,
          [books],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
}
