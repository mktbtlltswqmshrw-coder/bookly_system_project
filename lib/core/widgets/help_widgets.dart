import 'package:flutter/material.dart';

/// Widget لعرض أيقونة مساعدة مع نافذة منبثقة للشرح
class HelpIconButton extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final double iconSize;

  const HelpIconButton({
    super.key,
    required this.title,
    required this.message,
    this.icon = Icons.help_outline,
    this.iconSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, size: iconSize),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(child: Text(message)),
            actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('فهمت'))],
          ),
        );
      },
    );
  }
}

/// Widget لعرض TextField مع أيقونة مساعدة
class TextFieldWithHelp extends StatelessWidget {
  final String labelText;
  final String hintText;
  final String helpTitle;
  final String helpMessage;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int? maxLines;
  final bool enabled;

  const TextFieldWithHelp({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.helpTitle,
    required this.helpMessage,
    this.controller,
    this.validator,
    this.keyboardType,
    this.maxLines = 1,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      maxLines: maxLines,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        suffixIcon: HelpIconButton(title: helpTitle, message: helpMessage),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
