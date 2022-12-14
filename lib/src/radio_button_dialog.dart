import 'package:flutter/material.dart';

class RadioButtonDialog extends StatefulWidget {
  final String title;
  final String? cancelText;
  final String? confirmText;
  final List<String> buttonLabels;
  final ValueSetter<int?> onConfirm;
  final Widget? message;

  const RadioButtonDialog({
    Key? key,
    required this.title,
    required this.buttonLabels,
    required this.onConfirm,
    required this.cancelText,
    required this.confirmText,
    this.message,
  }) : super(key: key);

  @override
  State<RadioButtonDialog> createState() => _RadioButtonDialogState();
}

class _RadioButtonDialogState extends State<RadioButtonDialog> {
  int? _selectedIndex = 0;
  var _index = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final contentWidgets = <Widget>[];

    //Make sure we reset the index otherwise it'll keep growing
    _index = 0;

    for (final label in widget.buttonLabels) {
      contentWidgets.add(RadioListTile<int>(
        title: Text(label),
        groupValue: _selectedIndex,
        value: _index,
        onChanged: (buttonIndex) {
          setState(() {
            _selectedIndex = buttonIndex;
          });
        },
      ));
      _index++;
    }

    var content = Column(mainAxisSize: MainAxisSize.min, children: contentWidgets);

    if (widget.message != null) {
      content = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.message!,
          content,
        ],
      );
    }

    return AlertDialog(
      title: Text(widget.title),
      content: content,
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(widget.cancelText!),
        ),
        TextButton(
          onPressed: () => widget.onConfirm(_selectedIndex),
          child: Text(widget.confirmText!),
        ),
      ],
    );
  }
}
