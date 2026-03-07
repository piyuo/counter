// ===============================================
// Module: invitation_screen.dart
// Description: Invitation code entry screen
//
// Sections:
//   - InvitationScreen widget
// ===============================================
import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_onboarding/widgets/next_button_container.dart';
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';

class InvitationScreen extends ConsumerStatefulWidget {
  const InvitationScreen({this.token, super.key});

  final String? token;

  @override
  ConsumerState<InvitationScreen> createState() => _InvitationScreenState();
}

class _InvitationScreenState extends ConsumerState<InvitationScreen> {
  static const int _codeLength = 6;
  final TextEditingController _pinController = TextEditingController();
  final FocusNode _pinFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pinFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _pinController.dispose();
    _pinFocusNode.dispose();
    super.dispose();
  }

  void _onCompleted(String pin) {
    //todo: use real data from invitation download, when invitation backend is ready
    // we should use pin to fetch the invitation data from piyuo.com, and then use the data to setup the app state
    ref
        .read(core_domain.appProvider.notifier)
        .setup(
          core_domain.SetupBy.invitation(),
          core_domain.Backend.customServer(serverUrl: 'http://localhost', token: 'TOKEN_FROM_INVITATION'),
        );
  }

  @override
  Widget build(BuildContext context) {
    final Color borderColor = CupertinoColors.systemGrey2.resolveFrom(context);
    final defaultPinTheme = PinTheme(
      width: 48.0,
      height: 48.0,
      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: CupertinoColors.black),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: borderColor),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(color: Color.fromRGBO(234, 239, 243, 1)),
    );
    return feature_pip.PipScaffold(
      themeData: const CupertinoThemeData(brightness: Brightness.light),
      builder: (scrollController) {
        return NextButtonContainer(
          onNextPressed: () {},
          child: SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Enter invitation code',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: CupertinoColors.systemGreen, fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    'Check your email invitation to get the 6-digit code.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14.0, color: CupertinoColors.systemGrey.resolveFrom(context)),
                  ),
                  const SizedBox(height: 20.0),
                  Pinput(
                    length: _codeLength,
                    controller: _pinController,
                    focusNode: _pinFocusNode,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    submittedPinTheme: submittedPinTheme,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.characters,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[A-Za-z0-9]'))],
                    onCompleted: _onCompleted,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
