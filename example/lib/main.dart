import 'package:dgst_selector/dgst_selector.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DgstSelector Test App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final List<DgstSelectionItem> initItems = <DgstSelectionItem>[
    const DgstSelectionItem(id: 1, name: 'Item 1'),
    const DgstSelectionItem(id: 2, name: 'Item 2')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DgstSelector Test App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DgstSelector(
              title: 'Single-Selector',
              sourceCallback: testCallback(),
              initialSelectedItems: initItems,
              onSelectedItemsChanged: (value) => print(' > Selected Item Changed < : $value'),
            ),
            const SizedBox(height: 10.0),
            DgstSelector(
              title: 'Multi-Selector',
              dgstSelectorType: DgstSelectorType.MULTI_SELECTOR,
              sourceCallback: testCallback(),
              initialSelectedItems: initItems,
              onSelectedItemsChanged: (value) => print(' > Selected Items Changed < : $value'),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<DgstSelectionItem>?> testCallback() async {
    return <DgstSelectionItem>[for (var i = 0; i < 10; i++) DgstSelectionItem(id: i, name: 'Item $i')];
  }
}
