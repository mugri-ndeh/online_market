import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'error_mapping.dart';
import 'error_strings.dart';

/// Data class for passing errors.
///
/// Errors will be handled in [CustomConsumer]s listener method.
class GlobalErrorData extends Equatable {
  final String? _errorMessage;

  /// The actual error/exception element.
  ///
  /// Might be an dynamic Error, FirebaseAuthException, SocketError etc....
  final dynamic error;
  final StackTrace? stackTrace;

  ///
  /// If null, [CustomBlocConsumer] will use the implemented logic of [ErrorService.shouldBeReported] to determine whether to report an error or not. E.g. internet errors will never be reported.
  ///
  ///
  /// Defaults to null.

  /// Whether a dialog should be displayed.
  ///
  /// Defaults to true.
  final bool showToUser;

  const GlobalErrorData(this.error,
      {this.stackTrace,
      this.showToUser = true,

      /// Optional, user facing message.
      ///
      /// If null, the [errorMessage] method will be applied to extract a message automatically.
      String? errorMessage})
      : _errorMessage = errorMessage;

  ErrorType get errorType => getErrorType(error);

  /// Returns the specific error message for this error.
  ///
  /// The method has several fallbacks:
  ///
  /// 1. Custom [_errorMessage] passed to the data class (always preferred)
  /// 2. A specific message depending on the ErrorType. Check [errorStrings] for messages.
  /// 3. The stringified version of the exception/error.
  /// 4. Message about an unknown error (last option).
  String get errorMessage {
    if (_errorMessage != null) return _errorMessage!;
    final detectedErrorType = errorType;

    if (detectedErrorType == ErrorType.FirebaseAuth) {
      assert(error is FirebaseAuthException);
      return getFirebaseErrorMessage((error as FirebaseAuthException).code);
    }

    if (detectedErrorType != ErrorType.Unknown) {
      // If you get an error here, just find out which [error] was actually thrown by debugging and add a message for it in the [errorStrings] section.
      return errorStrings[detectedErrorType]!;
    }

    return error?.toString() ?? errorStrings[ErrorType.Unknown]!;
  }

  @override
  List<Object?> get props => [
        errorMessage,
        error,
        stackTrace,
        showToUser,
      ];
}
