import 'package:flutter/material.dart';
import 'package:libcli/delta/delta.dart' as delta;
import 'package:provider/provider.dart';

import 'quick_start_provider.dart';

class QuickStart extends StatelessWidget {
  const QuickStart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<QuickStartProvider>(
        create: (context) => QuickStartProvider(),
        child: Consumer<QuickStartProvider>(
          builder: (context, provide, _) => Padding(
            padding: delta.paddingToCenter(context, 900),
            child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
              if (constraints.maxWidth < 600) {
                return SizedBox(
                    height: 320,
                    child: Column(
                      children: [
                        Expanded(child: _intro()),
                        _lines(),
                      ],
                    ));
              }
              if (constraints.maxWidth < 800) {
                return SizedBox(
                    height: 380,
                    child: Column(
                      children: [
                        Expanded(child: _intro()),
                        IntrinsicHeight(child: _blocks()),
                      ],
                    ));
              }
              return SizedBox(
                  height: 300,
                  child: Row(children: [
                    Expanded(
                      flex: 2,
                      child: _intro(),
                    ),
                    Expanded(
                      flex: 3,
                      child: _blocks(),
                    ),
                  ]));
            }),
          ),
        ));
  }

  Widget _intro() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Get started with Piyuo',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Expanded(
            child: Align(
          child: Text(
            'Complete the following steps to get started with Piyuo',
          ),
        ))
      ],
    );
  }

  Widget _blockItem({
    required Color color,
    required Color linkColor,
    required String title,
    required String desc,
    required String link,
  }) =>
      Expanded(
        child: Container(
            color: color,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    )),
                const SizedBox(height: 20),
                Expanded(
                  child: Text(desc,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      )),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton.icon(
                    icon: Text(link, style: TextStyle(color: linkColor)),
                    label: Icon(Icons.chevron_right, color: linkColor),
                    onPressed: () {},
                  ),
                )
              ],
            )),
      );

  Widget _blocks() {
    return Column(
      //crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _blockItem(
                color: Colors.blue[100]!,
                linkColor: Colors.blue[900]!,
                title: 'Payouts',
                desc: 'Setups and manage your payouts',
                link: 'goto payouts settings',
              ),
              _blockItem(
                color: Colors.red[100]!,
                linkColor: Colors.red[900]!,
                title: 'Products',
                desc: 'Setups and manage your products',
                link: 'goto product settings',
              ),
            ],
          ),
        ),
        Expanded(
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _blockItem(
              color: Colors.green[100]!,
              linkColor: Colors.green[900]!,
              title: 'Store & Location',
              desc: 'Setups and manage your payouts',
              link: 'goto payouts settings',
            ),
            _blockItem(
              color: Colors.yellow[100]!,
              linkColor: Colors.yellow[900]!,
              title: 'Take Order',
              desc: 'Setups and manage your products',
              link: 'goto product settings',
            ),
          ],
        ))
      ],
    );
  }

  Widget _lineItem({
    required Color color,
    required Color linkColor,
    required String link,
  }) =>
      Container(
        color: color,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: TextButton.icon(
          icon: Text(link, style: TextStyle(color: linkColor, fontSize: 18)),
          label: Icon(Icons.chevron_right, color: linkColor),
          onPressed: () {},
        ),
      );

  Widget _lines() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _lineItem(
          color: Colors.blue[100]!,
          linkColor: Colors.blue[900]!,
          link: 'goto payouts settings',
        ),
        _lineItem(
          color: Colors.red[100]!,
          linkColor: Colors.red[900]!,
          link: 'goto product settings',
        ),
        _lineItem(
          color: Colors.green[100]!,
          linkColor: Colors.green[900]!,
          link: 'goto dine-in settings',
        ),
        _lineItem(
          color: Colors.yellow[100]!,
          linkColor: Colors.yellow[900]!,
          link: 'goto delivery settings',
        ),
      ],
    );
  }
}
