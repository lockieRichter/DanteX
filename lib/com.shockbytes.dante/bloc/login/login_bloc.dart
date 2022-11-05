import 'package:dantex/com.shockbytes.dante/data/authentication/authentication_repository.dart';

class LoginBloc {
  final AuthenticationRepository _repository;

  LoginBloc(this._repository);

  Future<bool> isLoggedIn() async {
    return true; // TODO Remove after login is complete
    // return (await _repository.getAccount()) != null;
  }

  void loginWithGoogle() {
    _repository.loginWithGoogle().then(
      (value) {
        print('Logged in with Google!');
        // TODO Update UI
      },
    );
  }

  void loginAnonymously() {
    _repository.loginAnonymously().then(
          (value) => {
            print('Logged in anonymously')
            // TODO Update UI
          },
        );
  }

  void loginWithEmail() {
    // TODO
  }
}
