import 'package:dgst_selector/src/models/dgst_selection_item.dart';
import 'package:flutter/material.dart';

class DgstChipsWrapper extends StatelessWidget {
  final List<DgstSelectionItem>? items;
  final void Function(int)? onItemDeleted;
  const DgstChipsWrapper({super.key, this.items, this.onItemDeleted});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
        decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: Colors.grey),
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        ),
        child: Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: (items ?? [])
              .map((item) => Chip(
                  label: Text(item.name),
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                  onDeleted: () => onItemDeleted!(item.id)))
              .toList(),
        ));
  }
}
