import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messenger/networking/firestore_client.dart';

class FirebaseAuthClient {
  final FirebaseAuth auth = FirebaseAuth.instance;
  static FirestoreClient firestore = FirestoreClient();

  Future<String?> validateEmail(String email, bool isSignUp) async {
    try {
      List authMethods = await auth.fetchSignInMethodsForEmail(email);
      if (!isSignUp && authMethods.isEmpty) {
        return 'No users with this email';
      } else if (isSignUp && authMethods.contains('password')) {
        return 'Email already registered';
      } else {
        return null;
      }
    } on Exception catch (_) {
      return 'No Internet connection';
    }
  }

  Future<String?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on Exception catch (_) {
      List authMethods = await auth.fetchSignInMethodsForEmail(email);
      if (authMethods.contains('password')) {
        return 'Wrong password';
      } else if (authMethods.isEmpty) {
        return 'No users with this email';
      } else {
        return 'Error';
      }
    }
    return null;
  }

  Future<String?> signUpWithEmailAndPassword(
    String email,
    String password,
    String name,
    int colorIndex,
  ) async {
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await credential.user!.updateDisplayName(name);
      await firestore.createUserRecord(name, colorIndex);
    } on Exception catch (_) {
      List authMethods = await auth.fetchSignInMethodsForEmail(email);
      if (authMethods.contains('password')) {
        return 'Email already registered';
      } else {
        return 'Error';
      }
    }
    return null;
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}
