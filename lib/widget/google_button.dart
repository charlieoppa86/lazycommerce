import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lazyclub/screens/auth/firebase_consts.dart';
import 'package:lazyclub/screens/bottom_bar.dart';
import 'package:lazyclub/services/global_methods.dart';
import 'package:lazyclub/widget/text_widget.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  Future<void> _googleSignIn(context) async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        try {
          await authInstance.signInWithCredential(GoogleAuthProvider.credential(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken,
          ));
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => BottomBarScreen()));
        } on FirebaseException catch (error) {
          GlobalMethods.errorDialog(
              content: '${error.message}', context: context);
        } catch (error) {
          GlobalMethods.errorDialog(content: '$error', context: context);
        } finally {}
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          _googleSignIn(context);
        },
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Image.asset(
            'assets/google_icon.png',
            width: 40,
          ),
          SizedBox(
            width: 60,
          ),
          TextWidget(text: '구글 아이디로 로그인', color: Colors.black87, textSize: 18)
        ]),
      ),
    );
  }
}
