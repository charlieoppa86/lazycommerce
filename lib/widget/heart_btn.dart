import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:lazyclub/provider/favor_provider.dart';
import 'package:lazyclub/screens/auth/firebase_consts.dart';
import 'package:lazyclub/services/global_methods.dart';
import 'package:lazyclub/services/utils.dart';
import 'package:provider/provider.dart';

class HeartBTN extends StatelessWidget {
  const HeartBTN({super.key, required this.productId, this.isInFavor = false});
  final String productId;
  final bool? isInFavor;
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final favorProvider = Provider.of<FavorProvider>(context);
    return GestureDetector(
      onTap: () {
        final User? user = authInstance.currentUser;
        if (user == null) {
          GlobalMethods.errorDialog(content: '로그인이 필요합니다', context: context);
          return;
        }
        favorProvider.addRemoveProductToFavor(productId: productId);
      },
      child: Icon(
        isInFavor != null && isInFavor == true
            ? IconlyBold.heart
            : IconlyLight.heart,
        color: isInFavor != null && isInFavor == true ? Colors.red : color,
        size: 22,
      ),
    );
  }
}
