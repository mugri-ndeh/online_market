import 'error_mapping.dart';

const Map<String, String> _errorCodeMap = {
  "unknown": "Unknown error occurred. We'll take a look.",
  //LOGIN
  "invalid-email": "The email addresss provided is not properly formatted.",
  "wrong-password": "Your password is incorrect.",
  "user-not-found": "No user was found with this email address",
  "user-disabled": "This user has been disabled",
  "too-many-requests": "The server is busy please try again",
  "operation-not-allowed": "This login operation is not allowed.",
  //REGISTRIERUNG
  //https://firebase.google.com/docs/auth/admin/errors
  "email-already-exists":
      "Another user already exists with this email address.",
  "invalid-password": "Please input a propper password",
  "email-already-in-use": "This email has already been taken"
};

/// Prefix can be 'firebase-auth/'. It will be removed.
String getFirebaseErrorMessage(String errorCodeWithPrefix,
    {String prefix = "firebase-auth"}) {
  final String errorCode = errorCodeWithPrefix.replaceAll(prefix, '');

  if (_errorCodeMap.containsKey(errorCode)) return _errorCodeMap[errorCode]!;
  return "An unexpected error occurred.";
}

const Map<ErrorType, String> errorStrings = {
  ErrorType.NoConnection: "There is no internet connection.",
  ErrorType.Unknown: "An unknown error occured. Please try again."
};
