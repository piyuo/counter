// invitation_screen.dart
// Description: Invitation code entry screen
//
// Sections:
//   - InvitationScreen widget
import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:feature_onboarding/widgets/onboarding_scaffold.dart';
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  String? _codeError;
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
    _codeController.addListener(
      () => setState(() {
        _codeError = null;
      }),
    );
  }

  @override
  void dispose() {
    _codeController.dispose();
    _codeFocusNode.dispose();
    super.dispose();
  }

  Future<void> _submitCode(String code) async {
    final invitationService = ref.read(core_domain.invitationServiceProvider);
    if (!invitationService.isValidCode(code)) {
      setState(() => _codeError = 'Invalid invitation code format.');
      return;
    }

    setState(() {
      _isValidating = true;
      _codeError = null;
    });

    final invitation = await invitationService.download(code);

    if (!mounted) return;

    if (invitation == null) {
      setState(() {
        _codeError = 'Invitation not found. Please check the code and try again.';
        _isValidating = false;
      });
      return;
    }

    setState(() => _isValidating = false);

    final appController = ref.read(core_domain.appProvider.notifier);
    appController.setBusinessDataServer(invitation.businessDataServer, invitation.bearerToken);
    ref.go(core_domain.OpenOnboardingInvitationSummary(invitation: invitation));
  }

  @override
  Widget build(BuildContext context) {
    final bool isComplete = _codeController.text.length == _codeLength;
    return OnboardingScaffold(
      isLoading: _isValidating,
      onNextPressed: (isComplete && !_isValidating)
          ? () => _submitCode(_codeController.text.trim().toUpperCase())
          : null,
      children: [
        feature_pip.PipPanel(
          margin: EdgeInsets.only(top: 10),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
          child: Column(
            children: [
              Text('Enter Invitation Code', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 4),
              Text(
                'Check your email invitation to get the 10-character code.',
                style: TextStyle(fontSize: 16.0, color: Colors.grey.shade400),
              ),
            ],
          ),
        ),

        const SizedBox(height: 28.0),
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
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 6.0,
            fontFamily: 'monospace',
          ),
          decoration: InputDecoration(
            counterText: '',
            hintText: 'XXXXX XXXXX',
            hintStyle: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 22,
              letterSpacing: 6.0,
              fontFamily: 'monospace',
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
        if (_codeError != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
            child: Text(_codeError!, style: const TextStyle(fontSize: 16, color: Colors.red)),
          ),
        if (_codeError != null)
          TextButton(
            onPressed: () {
              _codeController.clear();
              _codeFocusNode.requestFocus();
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text('Clear', style: TextStyle(fontSize: 16, color: Colors.blue)),
          ),
      ],
    );
  }
}
