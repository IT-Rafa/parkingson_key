import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DelLetterInkWell extends StatelessWidget {
  const DelLetterInkWell({super.key, required TextEditingController controller})
    : _controller = controller;

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (_controller.text.isNotEmpty) {
          _controller.text = _controller.text.substring(
            0,
            _controller.text.length - 1,
          );
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.backspace, color: Colors.red),
          Text(
            "KEYBOARD_letter",
            style: Theme.of(
              context,
            ).textTheme.labelMedium!.copyWith(color: Colors.red),
          ).tr(),
        ],
      ),
    );
  }
}
