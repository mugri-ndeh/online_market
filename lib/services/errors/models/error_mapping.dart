// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

enum ErrorType {
  /// No stable internet connection
  NoConnection,
  FirebaseAuth,
  Unknown
}

ErrorType getErrorType(dynamic error) {
  if (isInternetError(error)) return ErrorType.NoConnection;

  if (error is FirebaseAuthException) return ErrorType.FirebaseAuth;

  return ErrorType.Unknown;
}

bool isInternetError(dynamic error) {
  if (error == null) return false; // Unknown error

  // Firebase request failed.
  // A network error (such as timeout, interrupted connection or unreachable host) has occurred.
  if (error is FirebaseAuthException &&
      error.code == 'network-request-failed') {
    return true;
  }
  if (error is FirebaseException &&
      error.plugin == 'cloud_firestore' &&
      error.code == 'unavailable') {
    return true;
  }

  // No internet at all
  if (error is SocketException && error.osError?.errorCode == 7) {
    return true;
  }

  if (error
      .toString()
      .contains('Connection closed before full header was received')) {
    return true;
  }
  //SocketException: Software caused connection abort
  if (error is SocketException && error.osError?.errorCode == 103) {
    return true;
  }
  //HandshakeException has no errorCode, unstable internet.
  if (error is HandshakeException) {
    return true;
  }
  return false;
}
