//import 'wechat_signin_button.txt';
import 'package:counter/app/app.dart' as app;
import 'package:flutter/material.dart';

import 'login_form.dart';

class SigninView extends StatelessWidget {
  const SigninView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          right: false,
          bottom: false,
          child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth > 620) {
              return landscape(context);
            }
            return portrait(context);
          }),
        ));
  }

  Widget title(BuildContext context, double logoHeight) {
    return Container(
        color: Colors.white,
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            height: logoHeight,
            child: const app.Logo(),
          ),
          const Expanded(
            child: Center(
                child: Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: SizedBox(
                  width: double.infinity,
                  child:
                      //Container(color: Colors.red)
                      Text(
                    'Sign in or create an account',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      height: 0.9,
                    ),
                  )),
            )),
          ),
        ]));
  }

  Widget login(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      height: 180,
      child: const LoginForm(),
    );
  }

  Widget thirdPartyButton(Widget btn) {
    return Align(
      alignment: Alignment.center,
      child: Container(
          margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          width: 320,
          height: 40,
          child: btn),
    );
  }

  Widget thirdPartyLogin(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(240, 240, 240, 1),
        //color: Colors.grey[300],
        border: Border(
          bottom: BorderSide(width: 1.0, color: Color(0xFF000000)),
        ),
      ),
      height: 320.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            color: const Color.fromRGBO(45, 40, 37, 1),
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: const Text(
              'Or you can sign in using',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          //https://pub.dev/packages/flutter_auth_buttons#-example-tab-
/*          thirdPartyButton(AppleSignInButton(onPressed: () {/* ... */}, style: AppleButtonStyle.black)),
          thirdPartyButton(GoogleSignInButton(
            onPressed: () {/* ... */},
            darkMode: true, // default: false
          )),
          thirdPartyButton(FacebookSignInButton(
            onPressed: () {/* ... */},
          )),
          thirdPartyButton(WechatSignInButton(
            onPressed: () {/* ... */},
          )),
          */
        ],
      ),
    );
  }

  Widget createAccount(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(50),
      height: 300.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          OutlinedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(const Color(0X00000000)),
              side: MaterialStateProperty.all(const BorderSide(color: Colors.black)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(110),
              )),
              padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
            ),
            child: const Text(
              'Join now',
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {},
          ),
          const Text('Create an account and bring on the Rewards!'),
        ],
      ),
    );
  }

  Widget portrait(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: <Widget>[
      Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        height: 140.0,
        decoration: ShapeDecoration(
            shape: const RoundedRectangleBorder(),
            //color: Theme.of(context).cardColor,
            color: Colors.white,
            shadows: [
              BoxShadow(
                  //color: Theme.of(context).primaryColor.withAlpha(20),
                  color: Colors.black.withAlpha(80),
                  offset: const Offset(1.0, 1.0),
                  blurRadius: 3.0,
                  spreadRadius: 2.0),
            ]),
        child: title(context, 100),
      ),
      login(context),
      thirdPartyLogin(context),
      createAccount(context),
    ]));
  }

  Widget landscape(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Expanded(
        child: Container(
          //margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
          decoration: const BoxDecoration(
            color: Colors.white10,
            //color: Colors.grey[300],
            border: Border(
              right: BorderSide(width: 1.0, color: Color(0xFF000000)),
            ),
          ),
          //margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: title(context, 120),
        ),
      ),
      Expanded(
        child: SingleChildScrollView(
            child: Column(children: [
          login(context),
          thirdPartyLogin(context),
          createAccount(context),
        ])),
      ),
    ]);
  }
}
