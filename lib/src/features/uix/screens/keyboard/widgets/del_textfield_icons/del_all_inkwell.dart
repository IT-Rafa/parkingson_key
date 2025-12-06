import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DelAllInkWell extends StatelessWidget {
  const DelAllInkWell({super.key, required TextEditingController controller})
    : _controller = controller;

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _controller.text = '';
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.backspace, color: Colors.blue, size: 18),
          Text(
            "KEYBOARD_all",
            style: Theme.of(
              context,
            ).textTheme.labelMedium!.copyWith(color: Colors.black),
          ).tr(),
        ],
      ),
    );
  }
}
