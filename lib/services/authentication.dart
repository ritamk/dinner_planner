import 'package:dinner_planner/models/user.dart';
import 'package:dinner_planner/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  UserID? _userFromFirebaseUser(User? user) {
    return (user != null) ? UserID(uid: user.uid) : null;
  }

  Stream<UserID?> get user {
    return _firebaseAuth
        .authStateChanges()
        .map((User? user) => _userFromFirebaseUser(user));
  }

  Future signInAnonymously() async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInAnonymously();
      User? user = userCredential.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInWithEmailAndPass(String mail, String pass) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: mail, password: pass);
      User? user = userCredential.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future registerWithEmailAndPass(
      String mail, String pass, String username) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: mail, password: pass);
      User? user = userCredential.user;

      await DatabaseService(uid: user!.uid).updateUserData(ExtendedUserData(
          uid: user.uid,
          name: username,
          userPic: "https://robohash.org/$username",
          /* "https://avatars.dicebear.com/api/micah/$username.svg?mood[]=happy" */
          email: user.email,
          phone: "",
          landmark: "",
          adLine: "",
          city: "",
          state: "",
          pin: ""));

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
