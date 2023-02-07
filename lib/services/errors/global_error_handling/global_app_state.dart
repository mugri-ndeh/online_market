import 'package:equatable/equatable.dart';

import '../models/global_error_data.dart';

export '../models/global_error_data.dart';

/// These states are used in order to handle raised errors the same way in the whole app.
///
/// See attached readme.md for more information on how to use this.

abstract class GlobalAppState extends Equatable {
  const GlobalAppState();

  GlobalErrorData? get error {
    return null;
  }

  @override
  List<Object?> get props => [error];
}
