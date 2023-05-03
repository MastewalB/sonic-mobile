import 'package:flutter/material.dart';
import 'package:sonic_mobile/core/core.dart';

class ErrorHandlerWidget extends StatelessWidget {
  final BuildContext context;
  final ErrorType errorType;
  final VoidCallback? callback;
  final String? text;

  const ErrorHandlerWidget({
    Key? key,
    required this.context,
    required this.errorType,
    required this.callback,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SnackBarAction? actionWidget = (text != null)
        ? SnackBarAction(label: text!, onPressed: callback!)
        : null;

    switch (errorType) {
      case ErrorType.NONE:
        // TODO: Handle this case.
        break;
      case ErrorType.HTTP_401_EXPIRED_TOKEN:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text(Constants.loginRequired),
            action: actionWidget,
            duration: Constants.longDuration,
            showCloseIcon: true,
          ));
        });
        break;
      case ErrorType.HTTP_401_USER_INACTIVE:
        // TODO: Handle this case.
        break;
      case ErrorType.HTTP_403:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text(Constants.notEnoughPermission),
            action: actionWidget,
            duration: Constants.longDuration,
            showCloseIcon: true,
          ));
        });
        break;
      case ErrorType.HTTP_404:
        // TODO: Handle this case.
        break;
      case ErrorType.HTTP_500:
        // TODO: Handle this case.
        break;
      case ErrorType.CONNECTION_ERROR:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text(Constants.connectionError),
          action: actionWidget,
          duration: Constants.longDuration,
          showCloseIcon: true,
        ));

        break;
    }
    return Container();
  }
}
