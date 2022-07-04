import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
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

  void _forgetPassFCT() async {}

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    return Scaffold(
      body: Stack(children: [
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
    );
  }
}
