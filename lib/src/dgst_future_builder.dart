import 'package:dgst_selector/src/models/dgst_selection_item.dart';
import 'package:flutter/material.dart';

class DgstFutureBuilder extends StatefulWidget {
  final Future<List<DgstSelectionItem>?> future;
  final Widget Function(BuildContext, List<DgstSelectionItem>?) futureBlock;
  const DgstFutureBuilder({
    Key? key,
    required this.future,
    required this.futureBlock,
  }) : super(key: key);

  @override
  State<DgstFutureBuilder> createState() => _DgstFutureBuilderState();
}

class _DgstFutureBuilderState extends State<DgstFutureBuilder> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.future,
      builder: (BuildContext context, AsyncSnapshot<List<DgstSelectionItem>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: SizedBox(
              height: 20.0,
              width: 20.0,
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                '${snapshot.error.toString()} occured',
              ),
            );
          } else if (snapshot.hasData) {
            return widget.futureBlock(context, snapshot.data);
          } else {
            return Text('Unknown Error [code: 1], snapshot: ${snapshot.data.toString()}');
          }
        } else {
          return const Text('Unknown Error [code: 2]');
        }
      },
    );
  }
}
