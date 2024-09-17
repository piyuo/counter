import 'package:flutter/material.dart';

class LoginField extends StatefulWidget {
  final String label;
  final IconData? icon;
  final bool obscureText;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onFieldSubmitted;

  const LoginField(
      {required this.label,
      this.icon,
      required this.controller,
      this.obscureText = false,
      this.validator,
      this.focusNode,
      required this.textInputAction,
      this.onFieldSubmitted,
      super.key});

  @override
  LoginFieldState createState() => LoginFieldState();
}

class LoginFieldState extends State<LoginField> {
  TextEditingController? controller;

  /// 默认遮挡密码
  ValueNotifier<bool>? obscureNotifier;

  //FocusNode myFocusNode;

  @override
  void initState() {
    controller = widget.controller ?? TextEditingController();
    obscureNotifier = ValueNotifier(widget.obscureText);
    //myFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    //myFocusNode.dispose();
    if (obscureNotifier != null) {
      obscureNotifier!.dispose();
    }
    // 默认没有传入controller,需要内部释放
    if (widget.controller == null) {
      controller!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //var theme = Theme.of(context);
    return Padding(
      //padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: ValueListenableBuilder(
        valueListenable: obscureNotifier!,
        builder: (BuildContext context, bool value, Widget? child) => TextFormField(
          controller: controller,
          obscureText: value,
          validator: (String? text) {
            var validator = widget.validator ?? (_) => null;
            text = text ?? '';
            return text.trim().isNotEmpty ? validator(text) : 'fieldNotNull';
          },
          //focusNode: myFocusNode,
          textInputAction: widget.textInputAction,
          onFieldSubmitted: widget.onFieldSubmitted,
          decoration: InputDecoration(
            //prefixIcon: Icon(widget.icon, color: theme.accentColor, size: 22),
            hintText: widget.label,
            labelText: "${widget.label}hello",
            //focusedBorder: UnderlineInputBorder(
            //  borderSide: BorderSide(color: Color.fromRGBO(206, 116, 28, 1))),
            // labelStyle:
            //   myFocusNode.hasFocus ? TextStyle(color: Colors.red) : null,
            //        labelStyle: TextStyle(color: Color.fromRGBO(255, 158, 0, 1)),

            //hintStyle: TextStyle(fontSize: 16),
            suffixIcon: LoginFieldSuffixIcon(
              controller: controller!,
              obscureText: widget.obscureText,
              obscureNotifier: obscureNotifier!,
            ),
          ),
        ),
      ),
    );
  }
}

class LoginFieldSuffixIcon extends StatelessWidget {
  final TextEditingController controller;

  final ValueNotifier<bool> obscureNotifier;

  final bool obscureText;

  const LoginFieldSuffixIcon({
    super.key,
    required this.controller,
    required this.obscureNotifier,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Offstage(
          offstage: !obscureText,
          child: InkWell(
            onTap: () {
              obscureNotifier.value = !obscureNotifier.value;
            },
            child: ValueListenableBuilder(
              valueListenable: obscureNotifier,
              builder: (BuildContext context, bool value, Widget? child) => Icon(
                value ? Icons.lock_outline : Icons.lock_open,
                size: 20,
                color: value ? theme.hintColor : theme.colorScheme.secondary,
              ),
            ),
          ),
        ),
        LoginFieldClearIcon(controller)
      ],
    );
  }
}

class LoginFieldClearIcon extends StatefulWidget {
  final TextEditingController controller;

  const LoginFieldClearIcon(this.controller, {super.key});

  @override
  LoginFieldClearIconState createState() => LoginFieldClearIconState();
}

class LoginFieldClearIconState extends State<LoginFieldClearIcon> {
  ValueNotifier<bool> notifier = ValueNotifier(false);

  @override
  void initState() {
    notifier = ValueNotifier(widget.controller.text.isEmpty);
    widget.controller.addListener(() {
      if (mounted) notifier.value = widget.controller.text.isEmpty;
    });
    super.initState();
  }

  @override
  void dispose() {
    notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: notifier,
      builder: (context, bool value, child) {
        return Offstage(
          offstage: value,
          child: child,
        );
      },
      child: InkWell(
          onTap: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              widget.controller.clear();
            });
          },
          child: Icon(Icons.clear, size: 20, color: Theme.of(context).hintColor)),
    );
  }
}
