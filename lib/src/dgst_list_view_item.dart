import 'package:dgst_selector/src/models/dgst_selection_item.dart';
import 'package:flutter/material.dart';

class DgstListViewItem extends StatefulWidget {
  final DgstSelectionItem selectionItem;
  final bool selected;
  final ValueChanged<bool>? onSelectionChanged;

  const DgstListViewItem({
    super.key,
    required this.selectionItem,
    this.selected = false,
    this.onSelectionChanged,
  });

  @override
  DgstListViewItemState createState() => DgstListViewItemState();
}

class DgstListViewItemState extends State<DgstListViewItem> {
  bool selected = false;

  @override
  void initState() {
    selected = widget.selected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(widget.selectionItem.name),
        selected: selected,
        onTap: () {
          setState(() {
            selected = !selected;
          });
          if (widget.onSelectionChanged != null) widget.onSelectionChanged!(selected);
        });
  }
}
