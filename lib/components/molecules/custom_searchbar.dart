import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomSearchBar extends HookWidget {
  final ValueChanged<String> onTextChanged;

  const CustomSearchBar({Key? key, required this.onTextChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textEditingController = useTextEditingController();

    return TextField(
      controller: textEditingController,
      onChanged: onTextChanged,
      decoration: InputDecoration(
        hintText: 'Search...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
