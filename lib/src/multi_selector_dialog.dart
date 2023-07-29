// ignore_for_file: curly_braces_in_flow_control_structures, no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:dgst_selector/src/dgst_future_builder.dart';
import 'package:dgst_selector/src/dgst_list_view_item.dart';
import 'package:dgst_selector/src/models/dgst_selection_item.dart';
import 'package:flutter/material.dart';

class MultiSelectorDialog extends StatefulWidget {
  final Future<List<DgstSelectionItem>?> sourceCallback;
  final List<DgstSelectionItem>? initialSelectedItems;
  const MultiSelectorDialog({
    Key? key,
    required this.sourceCallback,
    this.initialSelectedItems,
  }) : super(key: key);

  @override
  MultiSelectorDialogState createState() => MultiSelectorDialogState();
}

class MultiSelectorDialogState extends State<MultiSelectorDialog> {
  List<DgstSelectionItem> allItems = [];
  List<DgstSelectionItem> selectedItems0 = [];
  List<DgstSelectionItem> selectedItems = [];
  Timer? _debounce;
  String searchQuery = '';

  @override
  void initState() {
    selectedItems = widget.initialSelectedItems ?? [];
    selectedItems0 = [...selectedItems];

    super.initState();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
        onClosing: () => selectedItems,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DgstFutureBuilder(
                  future: widget.sourceCallback,
                  futureBlock: (context, data) {
                    var _allItems = [...data ?? []];
                    allItems = [];
                    for (DgstSelectionItem item in _allItems) if (item.name.contains(searchQuery)) allItems.add(item);
                    return Expanded(
                        child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        DgstSelectionItem item = allItems[index];
                        return DgstListViewItem(
                          selectionItem: item,
                          selected: selectedItems.containsItem(item),
                          onSelectionChanged: (selected) {
                            selected ? selectedItems0.addItem(item) : selectedItems0.removeItem(item.id);
                          },
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(height: 3.0),
                      itemCount: allItems.length,
                    ));
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Search',
                          isDense: true,
                          border: OutlineInputBorder(),
                        ),
                        onChanged: _onSearchChanged,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    ElevatedButton.icon(
                      onPressed: () {
                        selectedItems = [...selectedItems0];
                        Navigator.pop(context, selectedItems);
                      },
                      icon: const Icon(Icons.check),
                      label: const Text('Confirm'),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  _onSearchChanged(String query) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 600), () async {
      setState(() {
        searchQuery = query;
      });
    });
  }
}
