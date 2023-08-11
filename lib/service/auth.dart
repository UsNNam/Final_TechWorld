import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_app/service/database.dart';

class AuthService{
  final _auth = FirebaseAuth.instance;

  Stream<User?> get user{
    return _auth.authStateChanges();
  }

  //Sign up with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password
      );
    
      print('User registered: ${userCredential.user?.email}');
      return userCredential.user;
    } catch (e) {
      // Handle registration errors here, e.g., show an error message
      print('Registration error: $e');
      return null;
    }
  }


  //Sign in with email and password 
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password
      );
      // Handle successful sign-in here, e.g., navigate to another screen
      print('User signed in: ${userCredential.user?.email}');
      return userCredential.user;
    } catch (e) {
      // Handle sign-in errors here, e.g., show an error message
      print('Sign-in error: $e');
      return null;
    }
  }

  //Sign in anonymously
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return user;

    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //log out

  Future logOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

