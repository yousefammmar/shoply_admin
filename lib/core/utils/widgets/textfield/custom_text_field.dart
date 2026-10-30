import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.validator,
    required this.hinText,
    this.prefixIcon,
    this.obscureText,
    this.keyboardType,
    this.maxLines = 1,
  });
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hinText;
  final Widget? prefixIcon;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final int maxLines;

  @override
  State<CustomTextField> createState() => _MainTextFieldState();
}

class _MainTextFieldState extends State<CustomTextField> {
  bool? isHide;

  @override
  void initState() {
    isHide = widget.obscureText;
    super.initState();
  }

  void changeIsHide() {
    isHide = !(isHide ?? false);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return TextFormField(
      obscureText: isHide ?? false,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      maxLines: widget.maxLines,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: colors.onSurface,
      ),
      textInputAction: TextInputAction.next,
      validator: widget.validator,
      cursorColor: Colors.grey,
      decoration: InputDecoration(
        helperText: '',
        helperStyle: TextStyle(fontSize: 12),
        hintText: widget.hinText,
        hintStyle: TextStyle(color: colors.onSurfaceVariant, fontSize: 17),
        suffixIcon: widget.obscureText == true
            ? GestureDetector(
                onTap: () {
                  changeIsHide();
                },
                child: isHide ?? false
                    ? Icon(Icons.visibility_off_outlined, size: 28)
                    : Icon(Icons.visibility_outlined, size: 28),
              )
            : null,
        contentPadding: EdgeInsets.symmetric(vertical: 17, horizontal: 10),
        prefixIcon: widget.prefixIcon,
        fillColor: colors.surfaceContainerHighest,
        filled: true,
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: colors.error, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
