import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthClient {
  final FirebaseAuth auth = FirebaseAuth.instance;

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
  ) async {
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await credential.user!.updateDisplayName(name);
      await FirebaseFirestore.instance
          .collection('usersList')
          .doc(auth.currentUser!.uid)
          .set(<String, dynamic>{
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'name': name,
        'userId': auth.currentUser!.uid,
      });
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
