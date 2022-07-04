import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingManager extends StatelessWidget {
  const LoadingManager(
      {super.key, required this.isLoading, required this.child});

  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        !isLoading
            ? Container(
                color: Colors.black.withOpacity(0.6),
              )
            : Container(),
        isLoading
            ? Center(
                child: SpinKitFadingFour(
                  color: Colors.white,
                ),
              )
            : Container(),
        child,
      ],
    );
  }
}
