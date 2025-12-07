import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ReadInkwell extends StatelessWidget {
  const ReadInkwell({super.key, required TextEditingController controller});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.volume_up, color: Colors.green, size: 18),
          Text(
            "KEYBOARD_read",
                        style: Theme.of(
              context,
            ).textTheme.labelMedium!.copyWith(color: Colors.black),
          ).tr(),
        ],
      ),
    );
  }
}
