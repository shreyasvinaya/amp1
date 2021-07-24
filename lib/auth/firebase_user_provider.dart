import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class Amp1FirebaseUser {
  Amp1FirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

Amp1FirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<Amp1FirebaseUser> amp1FirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<Amp1FirebaseUser>((user) => currentUser = Amp1FirebaseUser(user));
