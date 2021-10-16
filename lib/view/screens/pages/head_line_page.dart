import 'package:flutter/material.dart';

class HeadLinePage extends StatelessWidget {
  const HeadLinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          // TODO
          body: Container(
            child: Center(
              child: Text('Headlihne Page'),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.refresh),
            onPressed: () => onRefresh(),
          )),
    );
  }

  // TODO 更新処理
  onRefresh() {
    print('HeadLinePage.onRefresh');
  }
}
