import 'package:flutter/material.dart';
import 'package:oqvt_industrial_entity_management/api/utils/api_exception.dart';
import 'package:oqvt_industrial_entity_management/api/utils/errors.dart';
import 'package:oqvt_industrial_entity_management/api/utils/states.dart';
import 'package:oqvt_industrial_entity_management/utils/ui_utils.dart';

class XDropDownButton<T> extends StatefulWidget {
  const XDropDownButton({
    super.key,
    required this.title,
    required this.options,
    required this.onUpdateSelection,
    this.selected,
    this.convertToString,
    // this.defaultLabel,
    // this.buttonForegroundColor,
  });

  final String title;
  final List<T> options;
  final T? selected;
  final Future<bool> Function(T) onUpdateSelection;

  final String Function(T)? convertToString;

  // final String? defaultLabel;
  // final Color? buttonForegroundColor;

  @override
  State<XDropDownButton<T>> createState() => _XDropDownButtonState<T>();
}

class _XDropDownButtonState<T> extends State<XDropDownButton<T>> {
  TextEditingController controller = TextEditingController();
  XState state = XState.initial;
  T? selected;

  void updateSelection(T selection) async {
    setState(() => state = XState.loading);
    controller.text = "Updating...";
    try {
      final updated = await widget.onUpdateSelection(selection);
      if (!updated) {
        setState(() => state = XState.error);
        controller.text = getSelectedString();
        if (mounted) showError(context, error: XErrors.other);
        return;
      }
      selected = selection;
      setState(() => state = XState.initial);
      controller.text = getSelectedString();
    } on ApiException catch (e) {
      setState(() => state = XState.error);
      controller.text = getSelectedString();
      if (!mounted) return;
      showError(context, error: e.error);
    }
  }

  String getSelectedString() {
    return selected != null
        ? (widget.convertToString?.call(selected as T) ?? selected.toString())
        : "";
  }

  void onDropDownPressed() async {
    final selection = await showOptionsList<T>(
      context,
      title: widget.title,
      options: widget.options,
      selected: selected,
      getOptionText: widget.convertToString,
    );

    if (selection == null) return;
    updateSelection(selection);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      selected = widget.selected;
      controller.text = getSelectedString();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      enabled: state != XState.loading,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSurface,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      onTap: state != XState.loading ? onDropDownPressed : null,
      decoration: InputDecoration(
        hintText: "Select Health Center",
        enabled: state != XState.loading,
        suffixIcon: state != XState.loading
            ? const Icon(Icons.keyboard_arrow_down_rounded)
            : const SizedBox(
                width: 0,
                child: Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                    ),
                  ),
                ),
              ),
        constraints: const BoxConstraints(maxWidth: 300),
      ),
    );
  }
}
