import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SendInkwell extends StatelessWidget {
  const SendInkwell({super.key, required TextEditingController controller});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //Icon(Icons.volume_up, color: Colors.green, size: 18),
          Text(
            "KEYBOARD_send",
            textAlign: TextAlign.center,

            style: Theme.of(
              context,
            ).textTheme.labelMedium!.copyWith(color: Colors.black),
          ).tr(),
        ],
      ),
    );
  }
}
