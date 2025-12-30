import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/providers/appbar_visibility_notifier.dart';
import 'package:parkingson_key/src/core/providers/language_config.dart';
import 'package:parkingson_key/src/core/providers/language_provider.dart';
import 'package:parkingson_key/src/core/providers/tts_service_provider.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/landscape_layout.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/portrait_layout.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/settings_menu.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/textfield_row.dart';

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

  @override
  Widget build(BuildContext context) {
    final showAppBar = ref.watch(appBarVisibilityProvider);

    ref.listen(languageProvider, (prev, next) {
      final locale = ttsLocaleFromLanguage(next);
      ref.read(ttsServiceProvider).safeSetLocale(locale);
    });

    return SafeArea(
      child: Scaffold(
        appBar: showAppBar
            ? AppBar(
                title: const Text("KEYBOARD_title").tr(),
                actions: const [SettingsMenu()],
              )
            : null,
        body: OrientationBuilder(
          builder: (context, orientation) {
            final isPortrait = orientation == Orientation.portrait;

            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextFieldRow(
                    controller: _controller,
                    focusNode: _focusNode,
                  ),
                ),
                Expanded(
                  child: isPortrait
                      ? PortraitLayout(controller: _controller)
                      : LandscapeLayout(controller: _controller),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
