import 'package:counter/l10n/l10n.dart';
import 'package:counter/pip/pip.dart' as pip;
import 'package:flutter/cupertino.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;

class ExampleScreen extends StatelessWidget {
  const ExampleScreen({required this.scrollController, super.key});

  /// the scroll controller
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return pip.PipScaffold(
      titleWidget: Text('Hello Title', style: TextStyle(color: CupertinoColors.secondaryLabel.resolveFrom(context))),
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            pip.PipHeader(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Image(image: AssetImage('assets/icon/icon.png'), width: 84, height: 84),
                  const SizedBox(height: 8.0),
                  Text(context.l.product_name, style: const TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4.0),
                  Text(
                    context.l.wizard_screen_desc,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12.0, color: CupertinoColors.secondaryLabel.resolveFrom(context)),
                  ),
                ],
              ),
            ),

            CupertinoListSection(
              header: Text('Hello List Section'),
              backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
              children: [
                CupertinoListTile(
                  leading: Icon(CupertinoIcons.info),
                  title: Text(context.l.wizard_screen_about),
                  trailing: CupertinoListTileChevron(),
                ),
                CupertinoListTile(
                  leading: Icon(CupertinoIcons.globe),
                  title: Text(context.l.wizard_screen_language),
                  trailing: CupertinoListTileChevron(),
                ),
                CupertinoListTile(
                  leading: Icon(CupertinoIcons.mail),
                  title: Text(context.l.wizard_screen_email_us),
                  trailing: CupertinoListTileChevron(),
                  onTap: () {
                    //throw MyReleaseException('Email us is not implemented yet');
                    appkit.netOpenMailTo('service@piyuo.com', '', '');
                  },
                ),
              ],
            ),
            pip.PipFooter(),
          ],
        ),
      ),
    );
  }
}
