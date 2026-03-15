import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/providers/appbar_visibility_notifier.dart';
import 'package:parkingson_key/src/core/providers/phrase_tree_provider.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/layouts/widgets/action_buttons/contact_picker.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/layouts/widgets/action_buttons/phrase_category_picker.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/layouts/widgets/keyboard_body/widgets/keyboard_row/widgets/action_button.dart';
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
          if (text.isEmpty) return;

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
        title: "KEYBOARD_contacts".tr(),
        onAccepted: () {
          final text = controller.text.trim();

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
