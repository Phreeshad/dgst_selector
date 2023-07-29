import 'package:flutter/foundation.dart' show immutable;

@immutable
class DgstSelectionItem {
  final int id;
  final String name;
  const DgstSelectionItem({
    required this.id,
    required this.name,
  });

  DgstSelectionItem copyWith({
    int? id,
    String? name,
  }) =>
      DgstSelectionItem(
        id: id ?? this.id,
        name: name ?? this.name,
      );
}

extension SelectionOperations on List<DgstSelectionItem> {
  bool containsItem(DgstSelectionItem selectionItem) => indexWhere((item) => item.id == selectionItem.id) != -1;

  void addItem(DgstSelectionItem selectionItem) {
    bool exists = containsItem(selectionItem);
    if (!exists) add(selectionItem);
  }

  void removeItem(int id) {
    removeWhere((item) => item.id == id);
  }
}
