import 'package:card_swiper/card_swiper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lazyclub/screens/auth/firebase_consts.dart';
import 'package:lazyclub/screens/loading_manager.dart';
import 'package:lazyclub/services/global_methods.dart';
import 'package:lazyclub/services/utils.dart';
import 'package:lazyclub/widget/auth_button.dart';
import 'package:lazyclub/widget/const.dart';
import 'package:lazyclub/widget/text_widget.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const routeName = '/ForgetPasswordScreen';
  ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  //bool _isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  bool _isLoading = false;
  void _forgetPassFCT() async {
    if (emailController.text.isEmpty || !emailController.text.contains("@")) {
      GlobalMethods.errorDialog(content: '이메일을 입력해주세요', context: context);
    } else {
      setState(() {
        _isLoading = true;
      });
      try {
        await authInstance.sendPasswordResetEmail(
            email: emailController.text.toLowerCase());
        Fluttertoast.showToast(
            msg: "이메일 발송에 성공했어요🎉",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey.shade700,
            textColor: Colors.white,
            fontSize: 16.0);
      } on FirebaseException catch (error) {
        GlobalMethods.errorDialog(
            content: '${error.message}', context: context);
        setState(() {
          _isLoading = false;
        });
      } catch (error) {
        GlobalMethods.errorDialog(content: '$error', context: context);
        setState(() {
          _isLoading = false;
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    return Scaffold(
      body: LoadingManager(
        isLoading: _isLoading,
        child: Stack(children: [
          Swiper(
              itemBuilder: (BuildContext context, int index) {
                return Image.asset(
                  Consts.authImagesPaths[index],
                  fit: BoxFit.cover,
                );
              },
              itemCount: Consts.authImagesPaths.length),
          Container(
            color: Colors.black.withOpacity(0.7),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.1,
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    Navigator.canPop(context) ? Navigator.pop(context) : null;
                  },
                  child: Icon(
                    IconlyLight.arrowLeft2,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                TextWidget(
                    text: '비밀번호를 잊으셨어요?', color: Colors.white, textSize: 30),
                SizedBox(height: 20),
                TextField(
                  controller: emailController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      hintText: '이메일 주소를 입력하세요',
                      labelText: '이메일 주소를 입력하세요',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      )),
                ),
                SizedBox(height: 20),
                AuthButton(
                    fct: () {
                      _forgetPassFCT();
                    },
                    buttontext: '리셋하기')
              ],
            ),
          )
        ]),
      ),
    );
  }
}
