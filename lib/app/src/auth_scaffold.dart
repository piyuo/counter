import 'package:flutter/material.dart';
import 'package:libcli/delta/delta.dart' as delta;
import 'package:provider/provider.dart';

import 'logo.dart';

/// AuthScaffold provide scaffold for auth
abstract class AuthScaffold<T extends ChangeNotifier?> extends StatelessWidget {
  const AuthScaffold({
    required this.createModel,
    super.key,
  });

  /// modelBuilder create model use in scaffold
  final Create<T> createModel;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
        create: (context) => createModel(context),
        child: Scaffold(
            appBar: AppBar(
              //backToRoot: true,
              centerTitle: true,
              title: const SizedBox(
                height: 52,
                width: 52,
                child: Logo(),
              ),
            ),
            body: Consumer<T>(
                builder: (context, model, _) => SafeArea(
                      right: false,
                      bottom: false,
                      child: delta.Responsive(
                        phoneScreen: () => _portrait(context, model),
                        notPhoneScreen: () => _landscape(context, model),
                      ),
                    ))));
  }

  /// portrait render page in portrait mode
  Widget _portrait(BuildContext context, T model) {
    return Container(
        padding: const EdgeInsets.fromLTRB(20, 2, 20, 2),
        child: SingleChildScrollView(
            child: Column(children: <Widget>[
          const SizedBox(height: 20),
          Center(
            child: caption(context, true, model),
          ),
          Center(
            child: cardInPortrait()
                ? Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: body(context, model),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(3),
                    child: body(context, model),
                  ),
          ),
          const SizedBox(height: 40),
        ])));
  }

  /// _landscape render page in landscape mode
  Widget _landscape(BuildContext context, T model) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.fromLTRB(40, 20, 30, 0),
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(
                  width: 1.0,
                ),
              ),
            ),
            child: caption(context, false, model),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(40, 30, 40, 30),
              child: body(context, model),
            ),
          ),
        ),
      ],
    );
  }

  @protected
  Widget caption(BuildContext context, bool portrait, T model);

  @protected
  Widget body(BuildContext context, T model);

  @protected
  bool cardInPortrait() {
    return true;
  }
}
