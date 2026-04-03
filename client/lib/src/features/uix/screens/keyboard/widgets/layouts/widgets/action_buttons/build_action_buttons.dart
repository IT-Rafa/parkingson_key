import 'dart:io';

import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:parkingson_key/src/core/providers/appbar_visibility_notifier.dart';
import 'package:parkingson_key/src/core/providers/contact_storage_provider.dart';
import 'package:parkingson_key/src/core/providers/phrase_tree_provider.dart';
import 'package:parkingson_key/src/core/providers/server_host_provider.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/layouts/widgets/action_buttons/widgets/contact/contact_picker.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/layouts/widgets/action_buttons/widgets/phrase/phrase_category_picker.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/layouts/widgets/action_buttons/action_button.dart';
import 'package:parkingson_key/src/models/phrase/phrase_node.dart';

List<Widget> buildActionButtons(
  BuildContext context, {
  required WidgetRef ref,
  required TextEditingController controller,
  required bool isPortrait,
}) {
  final showAppBar = ref.watch(appBarVisibilityProvider);

  Widget keyBox({required Widget child, required bool isPortrait}) {
    return SizedBox(
      width: isPortrait ? 88 : 120,
      height: isPortrait ? 60 : 40,
      child: child,
    );
  }

  return [
    keyBox(
      isPortrait: isPortrait,
      child: ActionButton(
        title: showAppBar
            ? 'KEYBOARD_hide_title'.tr()
            : 'KEYBOARD_show_title'.tr(),
        onAccepted: () {
          ref.read(appBarVisibilityProvider.notifier).toggle();
        },
      ),
    ),
    keyBox(
      isPortrait: isPortrait,
      child: ActionButton(
        title: "KEYBOARD_savePhrase".tr(),
        onAccepted: () async {
          final text = controller.text.trim();
          if (text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("KEYBOARD_empty_phrase".tr()),
              ),
            );
            return;
          }

          final selectedCategoryId = await showModalBottomSheet<String>(
            context: context,
            isScrollControlled: true,
            builder: (_) => const PhraseCategoryPicker(),
          );

          if (selectedCategoryId == null) return;

          final newPhrase = PhraseNode(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            title: text,
            isCategory: false,
            children: const [],
          );

          await ref.read(phraseTreeProvider.notifier).addPhrase(
                selectedCategoryId,
                newPhrase,
              );
        },
      ),
    ),
    keyBox(
      isPortrait: isPortrait,
      child: ActionButton(
        title: "KEYBOARD_syncServer".tr(),
        onAccepted: () async {
          final messenger = ScaffoldMessenger.of(context);
          final notifier = ref.read(phraseTreeProvider.notifier);
          final serverHost = ref.read(serverHostProvider);
          messenger.removeCurrentSnackBar();
          messenger.showSnackBar(
            SnackBar(
              content: Text('KEYBOARD_sync_in_progress'.tr()),
              duration: const Duration(seconds: 15),
            ),
          );
          try {
            await notifier.syncToServer();
            messenger.removeCurrentSnackBar();
            messenger.showSnackBar(
              SnackBar(content: Text('KEYBOARD_sync_success'.tr())),
            );
          } catch (error) {
            messenger.removeCurrentSnackBar();
            messenger.showSnackBar(
              SnackBar(content: Text(_syncErrorMessage(error, serverHost))),
            );
          }
        },
      ),
    ),
    keyBox(
      isPortrait: isPortrait,
      child: ActionButton(
        title: "KEYBOARD_contacts".tr(),
        onAccepted: () {
          final text = controller.text.trim();
          final contacts = ref.read(contactProvider);
          if (contacts.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('KEYBOARD_no_contacts'.tr())),
            );
            return;
          }

          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => ContactPicker(message: text),
          );
        },
      ),
    ),
  ];
}

String _syncErrorMessage(Object error, String serverHost) {
  if (error is TimeoutException || error is SocketException || error is http.ClientException) {
    return '${'KEYBOARD_sync_server_not_found'.tr()} ($serverHost)';
  }

  if (error is HttpException) {
    final message = error.message.isNotEmpty
        ? error.message
        : 'KEYBOARD_sync_failed'.tr();
    return '${'KEYBOARD_sync_failed'.tr()}: $message';
  }

  if (error is FormatException) {
    return '${'KEYBOARD_sync_failed'.tr()}: ${error.message}';
  }

  return '${'KEYBOARD_sync_failed'.tr()}: ${error.toString()}';
}
