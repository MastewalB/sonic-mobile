import 'package:flutter/material.dart';
import 'package:sonic_mobile/core/core.dart';

class ErrorHandlerWidget extends StatelessWidget {
  final BuildContext context;
  final ErrorType errorType;
  final VoidCallback callback;

  const ErrorHandlerWidget({
    Key? key,
    required this.context,
    required this.errorType,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (errorType) {
      case ErrorType.NONE:
        // TODO: Handle this case.
        break;
      case ErrorType.HTTP_401_EXPIRED_TOKEN:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("You Need to Login to complete this action."),
            duration: Duration(seconds: 5),
          ));
        });
        break;
      case ErrorType.HTTP_401_USER_INACTIVE:
      // TODO: Handle this case.
        break;
      case ErrorType.HTTP_403:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("You don't have enough permission."),
            duration: Duration(seconds: 5),
          ));
        });
        break;
      case ErrorType.HTTP_404:
        // TODO: Handle this case.
        break;
      case ErrorType.HTTP_500:
        // TODO: Handle this case.
        break;

    }
    return Container();
  }
}
