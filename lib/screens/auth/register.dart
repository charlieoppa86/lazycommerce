import 'package:card_swiper/card_swiper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:lazyclub/inner_screens/feed_screen.dart';
import 'package:lazyclub/screens/auth/firebase_consts.dart';
import 'package:lazyclub/screens/auth/login.dart';
import 'package:lazyclub/screens/bottom_bar.dart';
import 'package:lazyclub/screens/loading_manager.dart';
import 'package:lazyclub/services/global_methods.dart';
import 'package:lazyclub/services/utils.dart';
import 'package:lazyclub/widget/auth_button.dart';
import 'package:lazyclub/widget/const.dart';
import 'package:lazyclub/widget/text_widget.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/RegisterScreen';
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailFocusNode = FocusNode();
  final _passFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  bool _obscureText = true;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passTextController = TextEditingController();
  TextEditingController addressTextController = TextEditingController();
  @override
  void dispose() {
    fullNameController.dispose();
    emailTextController.dispose();
    passTextController.dispose();
    addressTextController.dispose();
    _emailFocusNode.dispose();
    _passFocusNode.dispose();
    _addressFocusNode.dispose();
    super.dispose();
  }

  bool _isLoading = false;

  void submitFormOnRegister() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    setState(() {
      _isLoading = true;
    });

    if (isValid) {
      _formKey.currentState!.save();

      try {
        await authInstance.createUserWithEmailAndPassword(
            email: emailTextController.text.toLowerCase().trim(),
            password: passTextController.text.trim());
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
    final theme = Utils(context).getTheme;
    Color color = Utils(context).color;
    return Scaffold(
      body: LoadingManager(
        isLoading: _isLoading,
        child: Stack(children: [
          Swiper(
            duration: 1000,
            autoplayDelay: 2000,
            itemCount: Consts.authImagesPaths.length,
            itemBuilder: (BuildContext context, int index) {
              return Image.asset(
                Consts.authImagesPaths[index],
                fit: BoxFit.cover,
              );
            },
            autoplay: true,
          ),
          Container(
            color: Colors.black.withOpacity(0.7),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 60,
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(12),
                    child: Icon(
                      IconlyLight.arrowLeft2,
                      size: 24,
                      color: theme == true ? Colors.white : Colors.black,
                    ),
                    onTap: () => Navigator.canPop(context)
                        ? Navigator.pop(context)
                        : null,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextWidget(
                    text: '어서오세요',
                    color: Colors.white,
                    textSize: 30,
                    isTitle: true,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextWidget(
                    text: '계속하려면 회원가입이 필요해요',
                    color: Colors.white,
                    textSize: 18,
                    isTitle: false,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_emailFocusNode),
                            controller: fullNameController,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return '이름을 입력해주세요';
                              } else {
                                return null;
                              }
                            },
                            style: TextStyle(color: Colors.white, fontSize: 16),
                            decoration: InputDecoration(
                                labelText: "이름(닉네임)",
                                hintText: "이름(닉네임)",
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
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            focusNode: _emailFocusNode,
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_passFocusNode),
                            controller: emailTextController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty || !value.contains('@')) {
                                return '이메일 형식이 맞지 않습니다';
                              } else {
                                return null;
                              }
                            },
                            style: TextStyle(color: Colors.white, fontSize: 16),
                            decoration: InputDecoration(
                                labelText: "이메일을 입력하세요",
                                hintText: '이메일',
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
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            focusNode: _passFocusNode,
                            obscureText: _obscureText,
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_addressFocusNode),
                            controller: passTextController,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) {
                              if (value!.isEmpty || value.length < 8) {
                                return '비밀번호 입력이 없거나, 너무 짧네요!';
                              } else {
                                return null;
                              }
                            },
                            style: TextStyle(color: Colors.white, fontSize: 16),
                            decoration: InputDecoration(
                                labelText: "비밀번호를 입력하세요",
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                    child: _obscureText
                                        ? Icon(IconlyLight.hide)
                                        : Icon(IconlyLight.show)),
                                hintText: '비밀번호',
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
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.done,
                            focusNode: _addressFocusNode,
                            onEditingComplete: submitFormOnRegister,
                            controller: addressTextController,
                            validator: (value) {
                              if (value!.isEmpty || value.length < 10) {
                                return '유효한 주소를 입력해주세요';
                              } else {
                                return null;
                              }
                            },
                            style: TextStyle(color: Colors.white, fontSize: 16),
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                                labelText: "주소를 입력해주세요",
                                hintText: '주소',
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
                          SizedBox(
                            height: 8,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () {
                                  //  GlobalMethods.navigateTo(context: context, routeName: FeedsScreen.routeName);
                                },
                                child: Text(
                                  '비밀번호를 잊으셨어요?',
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: Colors.lightBlue,
                                    fontSize: 15,
                                    decoration: TextDecoration.underline,
                                  ),
                                )),
                          ),
                          AuthButton(
                              fct: () {
                                submitFormOnRegister();
                              },
                              buttontext: '회원가입'),
                          SizedBox(
                            height: 8,
                          ),
                          RichText(
                            text: TextSpan(
                                text: '이미 가입하셨나요?',
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          '                                               로그인',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.lightBlue,
                                          fontWeight: FontWeight.normal),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.pushReplacementNamed(
                                              context, LoginScreen.routeName);
                                        })
                                ]),
                          )
                        ],
                      ))
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
