import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/providers/keyboard_provider.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/keyboard_base.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/keyboard_land_header.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/keyboard_port_header.dart';

class KeyboardScreen extends ConsumerStatefulWidget {
  const KeyboardScreen({super.key});

  @override
  ConsumerState<KeyboardScreen> createState() => _KeyboardScreenState();
}

class _KeyboardScreenState extends ConsumerState<KeyboardScreen> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _insertText(String value) {
    final newText = _controller.text + value;
    _controller.text = newText;
    _controller.selection = TextSelection.collapsed(offset: newText.length);

    if (!_focusNode.hasFocus) _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final layout = ref.watch(keyboardProvider(orientation));

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              orientation == Orientation.portrait
                  ? KeyboardPortHeader(
                      controller: _controller,
                      focusNode: _focusNode,
                    )
                  : KeyboardLandHeader(
                      controller: _controller,
                      focusNode: _focusNode,
                    ),

              const SizedBox(height: 20),
              Expanded(
                child: KeyboardBase(layout: layout, onKeyPressed: _insertText),
              ),
              const SizedBox(height: 20),

              Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
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
                            style: Theme.of(context).textTheme.labelMedium!
                                .copyWith(color: Colors.red),
                          ).tr(),
                        ],
                      ),
                    ),
                    InkWell(
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
                            style: Theme.of(context).textTheme.labelMedium!
                                .copyWith(color: Colors.red),
                          ).tr(),
                        ],
                      ),
                    ),
                    InkWell(
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
                            style: Theme.of(context).textTheme.labelMedium!
                                .copyWith(color: Colors.red),
                          ).tr(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
