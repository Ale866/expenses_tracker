import 'package:flutter/material.dart';

class MoneyTracker extends StatelessWidget {
  const MoneyTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(children: [
          Row(
            children: [
              Text('aa'),
            ],
          ),
          Row(),
          Row(),
        ]),
      ),
    );
  }
}
