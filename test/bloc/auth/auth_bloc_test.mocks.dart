// Mocks generated by Mockito 5.3.2 from annotations
// in dantex/test/bloc/auth/auth_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:dantex/src/data/authentication/authentication_repository.dart'
    as _i2;
import 'package:dantex/src/data/authentication/entity/dante_user.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [AuthenticationRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthenticationRepository extends _i1.Mock
    implements _i2.AuthenticationRepository {
  MockAuthenticationRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<_i4.DanteUser?> getAccount() => (super.noSuchMethod(
        Invocation.method(
          #getAccount,
          [],
        ),
        returnValue: _i3.Future<_i4.DanteUser?>.value(),
      ) as _i3.Future<_i4.DanteUser?>);
  @override
  _i3.Future<void> loginWithGoogle() => (super.noSuchMethod(
        Invocation.method(
          #loginWithGoogle,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<void> loginWithEmail({
    required String? email,
    required String? password,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #loginWithEmail,
          [],
          {
            #email: email,
            #password: password,
          },
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<void> loginAnonymously() => (super.noSuchMethod(
        Invocation.method(
          #loginAnonymously,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<void> logout() => (super.noSuchMethod(
        Invocation.method(
          #logout,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<List<_i4.AuthenticationSource>> fetchSignInMethodsForEmail(
          {required String? email}) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchSignInMethodsForEmail,
          [],
          {#email: email},
        ),
        returnValue: _i3.Future<List<_i4.AuthenticationSource>>.value(
            <_i4.AuthenticationSource>[]),
      ) as _i3.Future<List<_i4.AuthenticationSource>>);
  @override
  _i3.Future<void> createAccountWithMail({
    required String? email,
    required String? password,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #createAccountWithMail,
          [],
          {
            #email: email,
            #password: password,
          },
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<void> upgradeAnonymousAccount({
    required String? email,
    required String? password,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #upgradeAnonymousAccount,
          [],
          {
            #email: email,
            #password: password,
          },
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<void> updateMailPassword({required String? password}) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateMailPassword,
          [],
          {#password: password},
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<void> sendPasswordResetRequest({required String? email}) =>
      (super.noSuchMethod(
        Invocation.method(
          #sendPasswordResetRequest,
          [],
          {#email: email},
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
}

/// A class which mocks [DanteUser].
///
/// See the documentation for Mockito's code generation for more information.
class MockDanteUser extends _i1.Mock implements _i4.DanteUser {
  MockDanteUser() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get userId => (super.noSuchMethod(
        Invocation.getter(#userId),
        returnValue: '',
      ) as String);
  @override
  _i4.AuthenticationSource get source => (super.noSuchMethod(
        Invocation.getter(#source),
        returnValue: _i4.AuthenticationSource.google,
      ) as _i4.AuthenticationSource);
}
