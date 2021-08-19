import 'package:braval_ui/braval_ui.dart';
import 'package:flutter/material.dart';

class BravalTextInput extends StatefulWidget {
  const BravalTextInput({
    Key? key,
    this.label,
    required this.hint,
    this.inputType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.obscureText = false,
    this.errorText,
    this.onChanged,
  }) : super(key: key);

  final String? label;
  final String hint;
  final TextInputType inputType;
  final TextInputAction textInputAction;
  final bool obscureText;
  final String? errorText;
  final ValueChanged<String>? onChanged;

  @override
  _BravalTextInputState createState() => _BravalTextInputState();
}

class _BravalTextInputState extends State<BravalTextInput> {
  Color currentBorderColor = BravalColors.oceanGreen;
  bool showPassword = false;

  @override
  void initState() {
    super.initState();
    showPassword = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label ?? '', style: textTheme.headline6),
        TextFormField(
          style: textTheme.bodyText1,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: textTheme.caption,
            errorText: widget.errorText,
            focusColor: BravalColors.oceanGreen,
            filled: true,
            fillColor: BravalColors.shark,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: BravalColors.black54),
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: BravalColors.oceanGreen),
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            border: const UnderlineInputBorder(
              borderSide: BorderSide(color: BravalColors.oceanGreen),
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            suffixIcon: widget.obscureText
                ? IconButton(
                    onPressed: () =>
                        setState(() => showPassword = !showPassword),
                    icon: Icon(
                      showPassword ? Icons.visibility : Icons.visibility_off,
                      color: showPassword
                          ? BravalColors.oceanGreen
                          : BravalColors.silver,
                    ),
                  )
                : null,
          ),
          cursorColor: BravalColors.oceanGreen,
          keyboardType: widget.inputType,
          textInputAction: widget.textInputAction,
          obscureText: showPassword,
          onChanged: (text) {
            if (widget.onChanged != null) widget.onChanged!(text);
          },
        ),
      ],
    );
  }
}
