import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/del_texfield_icons/del_all_inkwell.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/del_texfield_icons/del_letter_inkwell.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/del_texfield_icons/del_word_inkwell.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/key_keyboard_wrap.dart';

class KeyboardScreen extends ConsumerStatefulWidget {
  const KeyboardScreen({super.key});

  @override
  ConsumerState<KeyboardScreen> createState() => _KeyboardScreenState();
}

class _KeyboardScreenState extends ConsumerState<KeyboardScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 80,
            margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      readOnly: true,
                      controller: _controller,
                      decoration: const InputDecoration(
                        fillColor: Colors.red,
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 65,
                  color: Colors.grey[300],
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 5.0,
                  ),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.volume_up, color: Colors.green),
                            Text(
                              "KEYBOARD_read",
                              style: Theme.of(context).textTheme.labelMedium!
                                  .copyWith(color: Colors.green),
                            ).tr(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 65,
                  color: Colors.grey[300],
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 5.0,
                  ),
                  margin: const EdgeInsets.all(8.0),
                  child: Row(
                    spacing: 30,
                    children: [
                      DelLetterInkWell(controller: _controller),
                      DelWordInkWell(controller: _controller),
                      DelAllInkWell(controller: _controller),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/settings');
                  },
                  icon: Icon(Icons.menu, size: 40),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey[300],
              margin: const EdgeInsets.symmetric(
                horizontal: 18.0,
                vertical: 5.0,
              ),
              padding: const EdgeInsets.all(15.0),
              child: KeyKeyboardWrap(controller: _controller),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(200, 50),
                  ),
                  child: Text("KEYBOARD_savePhrase").tr(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(200, 50),
                  ),
                  child: Text("KEYBOARD_sendWhatsApp").tr(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
