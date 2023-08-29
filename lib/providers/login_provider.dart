import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:pokedex_mobile/dtos/user_model.dart';

// Cuando ocurre un error al registrarse
class SignUpFailure implements Exception {}

// Cuando ocurre un error en el login
class LogInWithEmailAndPasswordFailure implements Exception {}

// Cuando ocurre un error con el login de google
class LogInWithGoogleFailure implements Exception {}

// Cuando ocurre un error cuando cerramos sesion
class LogOutFailure implements Exception {}

class AuthenticationRepository extends ChangeNotifier {



  // Stream User -> actual usuario cuando el estado de autenticacion cambia
  Stream<User> get user {
    var auth = firebase_auth.FirebaseAuth.instance;
    return auth.authStateChanges().map((firebaseUser) {
      return firebaseUser == null ? User.empty : firebaseUser.toUser;
    });
  }

  // Registrar usuario con email y password
  Future<void> signUp({
    required String email,
    required String password
  }) async {
    var auth = firebase_auth.FirebaseAuth.instance;
    assert(email != null && password != null);
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password);
    } on Exception {
      throw SignUpFailure();
    }
  }


  // Login con email y password
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password
  }) async {
    var auth = firebase_auth.FirebaseAuth.instance;
    assert(email != null && password != null);
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on Exception {
      throw LogInWithEmailAndPasswordFailure();
    }
  }
  
  // cerrar sesion
  Future<void> logOut() async {
    var auth = firebase_auth.FirebaseAuth.instance;
    try {
      await Future.wait([
        auth.signOut(),
      ]);
    } on Exception {
      throw LogOutFailure();
    }
  }

}

extension on firebase_auth.User {
  User get toUser {
    return User(email: email, id: uid, name: displayName, photo: photoURL);
  }
}