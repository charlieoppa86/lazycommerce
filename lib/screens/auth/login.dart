import 'package:card_swiper/card_swiper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:lazyclub/screens/auth/firebase_consts.dart';
import 'package:lazyclub/screens/auth/register.dart';
import 'package:lazyclub/screens/bottom_bar.dart';
import 'package:lazyclub/screens/loading_manager.dart';
import 'package:lazyclub/services/global_methods.dart';
import 'package:lazyclub/widget/auth_button.dart';
import 'package:lazyclub/widget/const.dart';
import 'package:lazyclub/widget/google_button.dart';
import 'package:lazyclub/widget/text_widget.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/LoginScreen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _passFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  var _obscureText = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _passFocusNode.dispose();
    super.dispose();
  }

  bool _isLoading = false;

  void submitFormOnLogin() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    setState(() {
      _isLoading = true;
    });

    if (isValid) {
      _formKey.currentState!.save();

      try {
        await authInstance.signInWithEmailAndPassword(
            email: emailController.text.toLowerCase().trim(),
            password: passwordController.text.trim());
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => BottomBarScreen()));
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
    return Scaffold(
      body: LoadingManager(
        isLoading: _isLoading,
        child: Stack(
          children: [
            Swiper(
              duration: 1000,
              autoplayDelay: 4000,
              itemBuilder: (BuildContext context, int index) {
                return Image.asset(
                  Consts.authImagesPaths[index],
                  fit: BoxFit.cover,
                );
              },
              itemCount: Consts.authImagesPaths.length,
              pagination: SwiperPagination(
                  alignment: Alignment.bottomCenter,
                  builder: DotSwiperPaginationBuilder(
                    color: Colors.white,
                    activeColor: Colors.black,
                  )),
              autoplay: true,
            ),
            Container(
              color: Colors.black.withOpacity(0.5),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    TextWidget(
                      text: '안녕하세요',
                      color: Colors.white,
                      textSize: 30,
                      isTitle: true,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextWidget(
                      text: '계속하시려면 로그인이 필요합니다',
                      color: Colors.white,
                      textSize: 16,
                      isTitle: false,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(children: [
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(_passFocusNode),
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return '이메일 형식이 맞지 않습니다';
                            } else {
                              return null;
                            }
                          },
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              hintText: '이메일을 입력하세요',
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(15))),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          onEditingComplete: () {
                            submitFormOnLogin();
                          },
                          controller: passwordController,
                          focusNode: _passFocusNode,
                          obscureText: _obscureText,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 8) {
                              return '비밀번호 입력이 없거나, 너무 짧네요!';
                            } else {
                              return null;
                            }
                          },
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  child: _obscureText
                                      ? Icon(IconlyLight.hide)
                                      : Icon(IconlyLight.show)),
                              hintText: '비밀번호를 입력하세요',
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(15))),
                        )
                      ]),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                          onPressed: () {},
                          child: Text(
                            '비밀번호를 잊으셨어요?',
                            style:
                                TextStyle(decoration: TextDecoration.underline),
                          )),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    AuthButton(buttontext: '로그인', fct: submitFormOnLogin),
                    SizedBox(
                      height: 8,
                    ),
                    GoogleButton(),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Divider(
                          color: Colors.white,
                          thickness: 2,
                        )),
                        SizedBox(
                          width: 5,
                        ),
                        TextWidget(
                            text: '혹은', color: Colors.white, textSize: 18),
                        Expanded(
                            child: Divider(
                          color: Colors.white,
                          thickness: 2,
                        )),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    AuthButton(
                      buttontext: '비회원으로 입장하기',
                      fct: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => BottomBarScreen()));
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    RichText(
                      text: TextSpan(text: '계정이 아직 없으시다면?  ', children: [
                        TextSpan(
                            text:
                                '                                          회원가입',
                            style: TextStyle(
                                color: Colors.lightBlue,
                                fontWeight: FontWeight.normal),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                GlobalMethods.navigateTo(
                                    context: context,
                                    routeName: RegisterScreen.routeName);
                              })
                      ]),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
