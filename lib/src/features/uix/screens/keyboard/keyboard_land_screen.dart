import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/del_texfield_icons/del_all_inkwell.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/del_texfield_icons/del_letter_inkwell.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/del_texfield_icons/del_word_inkwell.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/del_texfield_icons/read_inkwell.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/key_keyboard_wrap.dart';

class KeyboardLandScreen extends ConsumerStatefulWidget {
  const KeyboardLandScreen({super.key});

  @override
  ConsumerState<KeyboardLandScreen> createState() => _KeyboardLandScreenState();
}

class _KeyboardLandScreenState extends ConsumerState<KeyboardLandScreen> {
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
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 10,
      
            children: [
              Row(
                spacing: 10,
      
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      readOnly: true,
                      controller: _controller,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 0.0),
                        fillColor: Colors.red,
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
      
                  Container(
                    color: Colors.grey[300],
                    padding: const EdgeInsets.all(10.0),
      
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [ReadInkwell(controller: _controller)],
                    ),
                  ),
                  Container(
                    color: Colors.grey[300],
                    padding: const EdgeInsets.all(10.0),
      
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
      
              Container(
                color: Colors.grey[300],
                padding: const EdgeInsets.all(10.0),
                child: KeyKeyboardWrap(controller: _controller),
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
        ),
      ),
    );
  }
}
