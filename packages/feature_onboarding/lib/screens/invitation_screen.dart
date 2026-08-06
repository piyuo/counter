// invitation_screen.dart
// Description: Invitation code entry screen
//
// Sections:
//   - InvitationScreen widget
import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/onboarding_scaffold.dart';

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return newValue.copyWith(text: newValue.text.toUpperCase());
  }
}

class InvitationScreen extends ConsumerStatefulWidget {
  const InvitationScreen({super.key});

  @override
  ConsumerState<InvitationScreen> createState() => _InvitationScreenState();
}

class _InvitationScreenState extends ConsumerState<InvitationScreen> {
  static const int _codeLength = 10;
  final TextEditingController _codeController = TextEditingController();
  final FocusNode _codeFocusNode = FocusNode();

  bool _isValidating = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final code = ref.read(core_domain.invitationCodeProvider);
      if (code != null && code.length == _codeLength) {
        _codeController.text = code.toUpperCase();
        await Future.delayed(const Duration(milliseconds: 800));
        if (!mounted) return;
        _submitCode(code);
      } else {
        _codeFocusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    _codeController.dispose();
    _codeFocusNode.dispose();
    super.dispose();
  }

  String getMessageByInvitationError(core_domain.InvitationError error, {String? serverCode}) {
    return switch (error) {
      core_domain.InvitationError.networkFailure => 'Network error. Please check your connection and try again.',
      core_domain.InvitationError.serverError => 'Server error. Please try again later.',
      core_domain.InvitationError.invalidFormat => 'Received invalid response from server. Please try again later.',
      core_domain.InvitationError.serverRejected =>
        'Invitation code rejected by server: ${serverCode ?? "unknown reason"}.',
      core_domain.InvitationError.unknown => 'An unknown error occurred. Please try again later.',
    };
  }

  Future<void> _submitCode(String code) async {
    final invitationService = ref.read(core_domain.invitationServiceProvider);
    if (!invitationService.isValidCode(code)) {
      final message = getMessageByInvitationError(core_domain.InvitationError.invalidFormat);
      appkit.showMessage(message: message);
      return;
    }

    setState(() {
      _isValidating = true;
    });

    final result = await invitationService.download(code);

    if (!mounted) return;
    if (result is core_domain.InvitationFailure) {
      final message = getMessageByInvitationError(result.error, serverCode: result.serverCode);
      appkit.showMessage(message: message);
      setState(() {
        _isValidating = false;
      });
      return;
    }

    final invitation = (result as core_domain.InvitationSuccess).invitation;
    setState(() => _isValidating = false);
    final appController = ref.read(core_domain.appProvider.notifier);

    if (invitation.businessPiyuoServer != null) {
      await appController.selectBusinessPiyuoServer(invitation.businessPiyuoServer!, invitation.bearerToken);
    } else if (invitation.businessCustomServer != null) {
      await appController.selectBusinessCustomServer(invitation.businessCustomServer!, invitation.bearerToken);
    }
    ref.go(core_domain.OpenOnboardingInvitationSuccess(invitation: invitation));
  }

  @override
  Widget build(BuildContext context) {
    final bool isComplete = _codeController.text.length == _codeLength;
    return OnboardingScaffold(
      title: 'Enter Invitation Code',
      isLoading: _isValidating,
      onNextButtonPressed: (isComplete && !_isValidating)
          ? () => _submitCode(_codeController.text.trim().toUpperCase())
          : null,
      builder: (context) => [
        Text(
          'Enter the 10-character invitation code from your email or message.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),

        onboardingSpacer(),

        Text(
          'The invitation will automatically configure this device for your organization.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
        ),
        onboardingSpacer(),
        TextField(
          controller: _codeController,
          focusNode: _codeFocusNode,
          maxLength: _codeLength,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.characters,
          textAlign: TextAlign.center,
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[A-Za-z0-9]')), UpperCaseTextFormatter()],
          onChanged: (value) {
            if (value.length == _codeLength) _submitCode(value.trim().toUpperCase());
          },
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 6.0,
            fontFamily: 'monospace',
          ),
          decoration: InputDecoration(
            counterText: '',
            hintText: 'ABCD1 EFGH2',
            hintStyle: TextStyle(
              fontSize: 22,
              letterSpacing: 6.0,
              fontFamily: 'monospace',
              color: Colors.grey.shade400,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: Colors.grey, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: Color.fromRGBO(114, 178, 238, 1), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          ),
        ),
        onboardingSpacer(),
        Text(
          "Didn't receive an invitation?\n"
          "Contact your administrator.",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
