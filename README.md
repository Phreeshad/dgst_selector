Provides a custom [TypeAhead](https://pub.dev/packages/flutter_typeahead) bindable with a **single selective** or **multi selective** item list. Multiple selections, can be shown as id based **chips**.

## Usage

```dart
final List<DgstSelectionItem> initItems = <DgstSelectionItem>[
    const DgstSelectionItem(id: 1, name: 'Item 1'),
    const DgstSelectionItem(id: 2, name: 'Item 2')
];
```

```dart
DgstSelector(
    title: 'Multi-Selector',
    dgstSelectorType: DgstSelectorType.MULTI_SELECTOR,
    sourceCallback: testCallback(),
    initialSelectedItems: initItems,
    onSelectedItemsChanged: (value) => print(' > Selected Items Changed < : $value'),
)
```

<div style="width: 480px">
  <img src="https://github.com/Phreeshad/dgst_selector/raw/main/output.gif" style="width: 100%;" alt="Output">
</div>

---

Any contributions will be appreciated.
