import 'package:flutter/material.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({super.key, required this.hinText, this.onChanged});
  final String hinText;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return TextField(
      onChanged: onChanged,
      cursorColor: Colors.grey,
      decoration: InputDecoration(
        hintText: hinText,
        hintStyle: TextStyle(color: colors.onSurfaceVariant, fontSize: 15),
        prefixIcon: Icon(Icons.search, color: colors.onSurfaceVariant),
        contentPadding: EdgeInsets.symmetric(vertical: 12),
        fillColor: colors.surfaceContainerHighest,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
