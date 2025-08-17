import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class DropdownFormWidget<T> extends StatelessWidget {
  final String title;
  final void Function(T?)? onChanged;
  final List<DropdownMenuItem<T>>? items;
  final Signal<String?> textDropdown;
  final Signal<IconData?> iconDropdown;
  final Signal<T?>? selectedValue;

  const DropdownFormWidget({
    super.key,
    required this.title,
    required this.onChanged,
    required this.items,
    required this.textDropdown,
    required this.iconDropdown,
    required this.selectedValue,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme fonts = TextTheme.of(context);

    return DropdownButtonHideUnderline(
      child: DropdownButton<T>(
        value: selectedValue?.watch(context),
        hint: Row(
          children: [
            if (iconDropdown.watch(context) != null)
              Icon(iconDropdown.watch(context)),
            const SizedBox(width: 4),
            Text(
              textDropdown.watch(context) ?? title,
              style: fonts.titleSmall,
            ),
          ],
        ),
        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white70),
        dropdownColor: Colors.grey[900],
        style: const TextStyle(color: Colors.white),
        isExpanded: true,
        items: items,
        onChanged: (value) {
          if (value != null) {
            textDropdown.value = value.toString();
            selectedValue?.value = value;
          } else {
            textDropdown.value = null;
            selectedValue?.value = null;
          }
          onChanged?.call(value);
        },
      ),
    );
  }
}
