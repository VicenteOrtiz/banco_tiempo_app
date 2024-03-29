import 'package:banco_tiempo_app/app/presentation/app_theme.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Center(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.grey.withOpacity(0.55),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
                horizontalSpace24,
                Text("Loading..."),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
