// ignore_for_file: constant_identifier_names, curly_braces_in_flow_control_structures

library dgst_selector;

import 'package:dgst_selector/src/chips_wrapper.dart';
import 'package:dgst_selector/src/models/dgst_selection_item.dart';
import 'package:dgst_selector/src/multi_selector_dialog.dart';
import 'package:dgst_selector/src/single_selector_dialog.dart';
import 'package:flutter/material.dart';

export 'package:dgst_selector/src/models/dgst_selection_item.dart';
export 'package:dgst_selector/src/dgst_future_builder.dart';
export 'package:dgst_selector/src/dgst_list_view_item.dart';
export 'package:dgst_selector/src/single_selector_dialog.dart';
export 'package:dgst_selector/src/multi_selector_dialog.dart';

enum DgstSelectorType { SINGLE_SELECTOR, MULTI_SELECTOR }

/// A selector dialog layout with chips item binding.
class DgstSelector extends StatefulWidget {
  final DgstSelectorType? dgstSelectorType;
  final Future<List<DgstSelectionItem>?> sourceCallback;
  final List<DgstSelectionItem>? initialSelectedItems;
  final ValueChanged<List<DgstSelectionItem>>? onSelectedItemsChanged;
  final String? title;
  final String? setButtonLabel;
  final String? addButtonLabel;
  final String? changeButtonLabel;
  final InputDecoration? inputDecoration;

  const DgstSelector({
    super.key,
    this.dgstSelectorType = DgstSelectorType.SINGLE_SELECTOR,
    this.title,
    this.setButtonLabel,
    this.addButtonLabel,
    this.changeButtonLabel,
    required this.sourceCallback,
    this.initialSelectedItems,
    this.onSelectedItemsChanged,
    this.inputDecoration,
  });

  @override
  State<DgstSelector> createState() => _DgstSelectorState();
}

class _DgstSelectorState extends State<DgstSelector> {
  List<DgstSelectionItem> selectedItems = [];
  String selectorActionButtonLabel = '';

  @override
  void initState() {
    selectedItems = widget.initialSelectedItems ?? [];
    setSelectorActionButtonLabel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Wrap(spacing: 6.0, runSpacing: 4.0, runAlignment: WrapAlignment.center, crossAxisAlignment: WrapCrossAlignment.center, children: [
          Text(widget.title ?? ''),
          if (widget.dgstSelectorType == DgstSelectorType.SINGLE_SELECTOR && selectedItems.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
              decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Colors.grey),
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              ),
              child: Text(selectedItems[0].name), // Text(selectedItems.single.name),
            ),
          ActionChip(
            label: Text(selectorActionButtonLabel),
            onPressed: () => showModalBottomSheet(
              context: context,
              builder: (context) => widget.dgstSelectorType == DgstSelectorType.SINGLE_SELECTOR
                  ? SingleSelectorDialog(
                      sourceCallback: widget.sourceCallback,
                      initialSelectedItems: selectedItems,
                    )
                  : MultiSelectorDialog(
                      sourceCallback: widget.sourceCallback,
                      initialSelectedItems: selectedItems,
                    ),
            ).then((value) {
              setState(() {
                if (value != null) selectedItems = value as List<DgstSelectionItem>;
                if (widget.onSelectedItemsChanged != null) widget.onSelectedItemsChanged!(selectedItems);
                setSelectorActionButtonLabel();
              });
            }),
          )
        ]),
        if (widget.dgstSelectorType == DgstSelectorType.MULTI_SELECTOR)
          DgstChipsWrapper(
              items: selectedItems,
              onItemDeleted: (id) {
                setState(() {
                  selectedItems.removeItem(id);
                  if (widget.onSelectedItemsChanged != null) widget.onSelectedItemsChanged!(selectedItems);
                });
              }),
      ]),
    );
  }

  void setSelectorActionButtonLabel() {
    selectorActionButtonLabel = widget.dgstSelectorType == DgstSelectorType.SINGLE_SELECTOR
        ? (selectedItems.isEmpty ? widget.setButtonLabel ?? 'Set' : widget.changeButtonLabel ?? 'Change')
        : widget.addButtonLabel ?? 'Add';
  }
}
