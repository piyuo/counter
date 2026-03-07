import 'package:feature_onboarding/widgets/next_button_container.dart';
import 'package:feature_pip/feature_pip.dart' as feature_pip;
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key});

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  static const int _codeLength = 6;
  final List<TextEditingController> _controllers = List.generate(_codeLength, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(_codeLength, (_) => FocusNode());
  bool _submitted = false;

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _handleChanged(int index, String value) {
    final String upper = value.toUpperCase();
    if (upper != value) {
      _controllers[index].text = upper;
      _controllers[index].selection = TextSelection.collapsed(offset: upper.length);
    }

    if (upper.isNotEmpty) {
      if (index < _focusNodes.length - 1) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
      }
    } else if (index > 0) {
      _focusNodes[index - 1].requestFocus();
    }

    _trySubmit();
  }

  void _trySubmit() {
    if (_submitted) {
      return;
    }
    final bool isComplete = _controllers.every((controller) => controller.text.trim().length == 1);
    if (!isComplete) {
      return;
    }
    _submitted = true;
    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final Color borderColor = CupertinoColors.systemGrey4.resolveFrom(context);
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
                    'Check your email invitation to get the 8-digit code.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14.0, color: CupertinoColors.systemGrey.resolveFrom(context)),
                  ),
                  const SizedBox(height: 20.0),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: List.generate(
                      _codeLength,
                      (index) => SizedBox(
                        width: 40.0,
                        child: CupertinoTextField(
                          controller: _controllers[index],
                          focusNode: _focusNodes[index],
                          maxLength: 1,
                          textAlign: TextAlign.center,
                          textCapitalization: TextCapitalization.characters,
                          keyboardType: TextInputType.text,
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[A-Za-z0-9]'))],
                          decoration: BoxDecoration(
                            color: CupertinoColors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(color: borderColor),
                          ),
                          onChanged: (value) => _handleChanged(index, value),
                        ),
                      ),
                    ),
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
