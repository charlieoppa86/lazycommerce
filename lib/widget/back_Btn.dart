import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:lazyclub/services/utils.dart';

class BackBtn extends StatelessWidget {
  const BackBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).color;
    return InkWell(
      child: Icon(
        IconlyLight.arrowLeft2,
        color: color,
      ),
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}
