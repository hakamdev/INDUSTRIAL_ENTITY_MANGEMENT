import 'package:flutter/material.dart';
import 'package:oqvt_industrial_entity_management/widgets/label.dart';
import 'package:oqvt_industrial_entity_management/widgets/search_bar.dart';

class DropDownListSheet<T> extends StatefulWidget {
  const DropDownListSheet(
      {super.key,
      required this.title,
      required this.options,
      this.getOptionText,
      this.selected});

  final String title;
  final List<T> options;
  final String Function(T)? getOptionText;
  final T? selected;

  @override
  State<DropDownListSheet<T>> createState() => _DropDownListSheetState<T>();
}

class _DropDownListSheetState<T> extends State<DropDownListSheet<T>> {
  List<T> filteredOptions = [];

  // String? searchQuery;

  void updateOptionsOnSearch(String query) {
    filteredOptions = widget.options.where((op) {
      final optionToText = widget.getOptionText?.call(op) ?? op.toString();
      return optionToText.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  @override
  void initState() {
    filteredOptions = widget.options;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SizedBox(
        // height: MediaQuery.of(context).size.height * .68,
        child: Column(
          children: [
            XLabel(
              label: widget.title,
              maxLines: 1,
              align: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),

            /// SEARCH FIELD
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: XSearchBar(
                hintText: "Search health centers...",
                showTrailing: false,
                onChanged: (v) {
                  updateOptionsOnSearch(v);
                  setState(() {});
                },
              ),
            ),

            /// OPTIONS/SEARCH RESULT LIST
            // const SizedBox(height: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Material(
                  borderRadius: BorderRadius.circular(16),
                  clipBehavior: Clip.antiAlias,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      index = index % filteredOptions.length;

                      return ListTile(
                        title: Text(
                          widget.getOptionText?.call(filteredOptions[index]) ??
                              filteredOptions[index].toString(),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 24),
                        titleTextStyle:
                            Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                        // tileColor: index % 2 == 0
                        //     ? Theme.of(context)
                        //         .colorScheme
                        //         .inversePrimary.withAlpha(100)
                        //     : Theme.of(context)
                        //     .colorScheme
                        //     .inversePrimary.withAlpha(50),
                        onTap: () =>
                            Navigator.pop<T>(context, filteredOptions[index]),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(
                      height: 0,
                      thickness: 1,
                      color: Theme.of(context).dividerColor.withAlpha(50),
                    ),
                    itemCount: filteredOptions.length,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
