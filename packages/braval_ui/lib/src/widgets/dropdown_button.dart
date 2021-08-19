import 'package:braval_ui/braval_ui.dart';
import 'package:flutter/material.dart';

class BravalDropdownButton extends StatefulWidget {
  const BravalDropdownButton({
    Key? key,
    required this.items,
    required this.value,
    required this.onChanged,
    this.label,
  }) : super(key: key);

  final List<DropdownMenuItem<String>> items;
  final String value;
  final void Function(String?) onChanged;
  final String? label;

  @override
  _BravalDropdownButtonState createState() => _BravalDropdownButtonState();
}

class _BravalDropdownButtonState extends State<BravalDropdownButton> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label ?? '', style: textTheme.headline6),
        DropdownButtonFormField(
          items: widget.items,
          value: widget.value,
          onChanged: widget.onChanged,
          icon: const Icon(Icons.arrow_drop_down),
          isExpanded: true,
          dropdownColor: BravalColors.shark,
          focusColor: BravalColors.oceanGreen,
          decoration: const InputDecoration(
            focusColor: BravalColors.oceanGreen,
            filled: true,
            fillColor: BravalColors.shark,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: BravalColors.oceanGreen),
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: BravalColors.oceanGreen),
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: BravalColors.oceanGreen),
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
          ),
        ),
      ],
    );
  }
}
