import 'package:flutter/material.dart';

class SigninAction {
  String name;
  String password;
  SigninAction({required this.name, required this.password});
}

Future<Map> reducer(BuildContext context, Map old, dynamic action) async {
  if (action is SigninAction) {
    var state = Map.from(old);
    state['name'] = action.name;
    state['password'] = action.password;
    return state;
  }
  return old;
}
