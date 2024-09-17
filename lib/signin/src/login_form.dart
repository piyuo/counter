import 'package:flutter/material.dart';
import 'login_field.dart';
import 'login_button.txt';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Stack(
              children: <Widget>[
                //padding: EdgeInsets.symmetric(vertical: 0),
                Center(
                    child: Container(
                  width: 375,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
                    LoginField(
                      label: 'email address or phone number',
                      controller: _nameController,
                      textInputAction: TextInputAction.next,
                    ),
                    LoginButton(_nameController),
                  ]),
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
