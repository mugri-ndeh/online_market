/// See readme.md in this folder for more information
import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_market/util/helper.dart';
import 'package:online_market/util/widgets/custom_flushbar.dart';

import 'global_app_state.dart';

/// Consumer that checks for an error state so our custom error widget can be displayed.
///
/// Use this Consumer instead of a regular CustomBlocConsumer or BlocConsumer if your Cubit calls functions that might throw errors.
///
/// Automatically displays errors when an error state is thrown.
class CustomBlocConsumer<B extends BlocBase<S>, S extends GlobalAppState>
    extends StatelessWidget {
  const CustomBlocConsumer({
    Key? key,
    required this.builder,
    this.listener,
    this.buildWhen,
    this.listenWhen,
  }) : super(key: key);

  final Widget Function(BuildContext context, S state) builder;

  /// A listener that will be executed within the the error report listener of the custom consumer.
  final void Function(BuildContext context, S state)? listener;
  final bool Function(S, S)? buildWhen;
  final bool Function(S, S)? listenWhen;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<B, S>(
        builder: builder,
        listenWhen: listenWhen,
        buildWhen: buildWhen,
        listener: (ctx, state) {
          if (state.error != null) {
            final GlobalErrorData error = state.error!;
            if (error.showToUser) showCustomFlushbar(error.errorMessage, ctx);
            // showToast(error.errorMessage);
          }

          if (listener != null) {
            listener!(ctx, state);
          }
        });
  }
}
