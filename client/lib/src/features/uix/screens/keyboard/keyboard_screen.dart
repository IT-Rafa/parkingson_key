import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/providers/app_language_enum.dart';
import 'package:parkingson_key/src/core/providers/appbar_visibility_notifier.dart';
import 'package:parkingson_key/src/core/providers/keyboard_profile_provider.dart';
import 'package:parkingson_key/src/core/providers/keyboard_type_provider.dart';
import 'package:parkingson_key/src/core/providers/language_provider.dart';
import 'package:parkingson_key/src/core/providers/tts_service_provider.dart';
import 'package:parkingson_key/src/core/providers/phrase_tree_provider.dart';
import 'package:parkingson_key/src/core/controllers/keyboard_repeat_controller.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/layouts/landscape_layout.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/layouts/portrait_layout.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/app_bar/settings_icon_button.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/textfield_row/textfield_base.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_layout_resolver.dart';

// Widget keyboard_screen
class KeyboardScreen extends ConsumerStatefulWidget {
  const KeyboardScreen({super.key});

  @override
  ConsumerState<KeyboardScreen> createState() => _KeyboardScreenState();
}

// State of the keyboard screen
class _KeyboardScreenState extends ConsumerState<KeyboardScreen> {
  // Controller of the text field on keyboard_screen
  late final TextEditingController _textFieldController;

  // Focus node for the text field
  late final FocusNode _focusNode;

  late final KeyboardRepeatController _repeatController;

  bool _initialSyncDone = false;

  @override
  void initState() {
    super.initState();
    _textFieldController = TextEditingController();
    _focusNode = FocusNode();
    _repeatController = KeyboardRepeatController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && !_initialSyncDone) {
        _initialSyncDone = true;
        ref.read(phraseTreeProvider.notifier).syncFromServer().catchError((_) {
          // Silently ignore errors on initial sync
        });
      }
      if (mounted) _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Watch the app bar visibility provider
    final showAppBar = ref.watch(appBarVisibilityProvider);
    final profile = ref.watch(keyboardProfileProvider);

    final keyboardType = ref.watch(keyboardTypeProvider);
    final appLanguage = ref.watch(languageProvider);
    final keyboardLayout = keyboardLayoutResolve(keyboardType, appLanguage);

    // Update TTS locale
    ref.listen<AppLanguage>(languageProvider, (prev, next) {
      // EasyLocalization locale
      final locale =
          next == AppLanguage.en ? const Locale('en') : const Locale('es');
      if (context.locale != locale) {
        context.setLocale(locale);
      }

      // TTS locale (usa String)
      final ttsLocale = next == AppLanguage.en ? 'en' : 'es';
      ref.read(ttsServiceProvider).setLocale(ttsLocale);
    });
    return SafeArea(
      child: Scaffold(
        appBar: showAppBar
            ? AppBar(
                title: const Text("KEYBOARD_title").tr(),
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                actions: const [SettingsIconButton()],
              )
            : null,
        body: OrientationBuilder(
          builder: (context, orientation) {
            final isPortrait = orientation == Orientation.portrait;

            return Column(
              children: [
                TextFieldBase(
                  controller: _textFieldController,
                  focusNode: _focusNode,
                ),
                // KeyboardBase + ActionButtonsBase
                Expanded(
                  child: isPortrait
                      ? PortraitLayout(
                          layout: keyboardLayout,
                          controller: _textFieldController,
                          repeatController: _repeatController,
                          profile: profile,
                        )
                      : LandscapeLayout(
                          layout: keyboardLayout,
                          controller: _textFieldController,
                          repeatController: _repeatController,
                          profile: profile,
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
