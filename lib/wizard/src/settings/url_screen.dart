import 'dart:developer';
import 'dart:io';

import 'package:counter/l10n/l10n.dart';
import 'package:counter/pip/pip.dart' as pip;
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

/// example url for testing
/// https://cdn-004.whatsupcams.com/hls/hr_pula06.m3u8
/// rtsp://807e9439d5ca.entrypoint.cloud.wowza.com:1935/app-rC94792j/068b9c9a_stream2
/// rtsp://wowzaec2demo.streamlock.net/vod/mp4:BigBuckBunny_115k.mov

class UrlScreen extends StatelessWidget {
  const UrlScreen({
    required this.initialUrl,
    required this.onScroll,
    this.nextRouteBuilder,
    this.previousPageTitle,
    super.key,
  });

  /// the scroll event handler need by pip screen
  final pip.ScrollCallback onScroll;

  /// the initial url
  final String initialUrl;

  /// the next route builder
  final Future<String> Function(String url)? nextRouteBuilder;

  /// the previous page title
  final String? previousPageTitle;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UrlScreenProvider>(
      create: (_) => UrlScreenProvider(initialUrl, onScroll),
      child: Consumer<UrlScreenProvider>(
        builder: (context, urlScreenProvider, child) {
          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (bool didPop, result) async {
              if (didPop) {
                return;
              }
              final url = urlScreenProvider.urlFieldController.text;
              if (initialUrl.isEmpty || initialUrl == url) {
                if (context.mounted) Navigator.pop(context);
                return;
              }
              final shouldPop = await urlScreenProvider.pingUrl(url);
              if (shouldPop) {
                if (context.mounted) Navigator.pop(context, url);
              }
            },
            child: pip.PipScaffold(
              previousPageTitle: previousPageTitle,
              child: SingleChildScrollView(
                  controller: urlScreenProvider._scrollController,
                  child: Column(
                    children: [
                      pip.PipHeader(
                        child: Column(
                          children: [
                            Icon(CupertinoIcons.cloud, size: 44),
                            const SizedBox(height: 8.0),
                            Text(context.l.url_screen_title, style: const TextStyle(fontSize: 20.0)),
                            Text(context.l.url_screen_desc,
                                style: TextStyle(color: CupertinoColors.secondaryLabel.resolveFrom(context))),
                          ],
                        ),
                      ),
                      CupertinoListSection(
                        header: Text(context.l.url_screen_url),
                        backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                        children: [
                          CupertinoTextField(
                            maxLines: 3,
                            clearButtonMode: OverlayVisibilityMode.editing,
                            placeholder: context.l.url_screen_url_placeholder,
                            padding: const EdgeInsets.all(16),
                            controller: urlScreenProvider.urlFieldController,
                            decoration: BoxDecoration(color: CupertinoColors.systemGrey6.resolveFrom(context)),
                          ),
                        ],
                      ),
                      if (urlScreenProvider.errorMessage != null) // 顯示錯誤訊息
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            urlScreenProvider.errorMessage!,
                            style: TextStyle(color: CupertinoColors.systemRed.resolveFrom(context), fontSize: 14),
                          ),
                        ),
                      CupertinoListSection(
                        backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                        children: [
                          CupertinoListTile(
                              title: Center(
                                  child: CupertinoButton(
                            onPressed: () async {
                              final url = urlScreenProvider.urlFieldController.text;
                              final ok = await urlScreenProvider.pingUrl(url);
                              if (context.mounted && ok) {
                                if (nextRouteBuilder != null) {
                                  String nextRoute = await nextRouteBuilder!(url);
                                  if (context.mounted) {
                                    Navigator.of(context).pushReplacementNamed(nextRoute);
                                  }
                                } else {
                                  Navigator.of(context).pop(url);
                                }
                              }
                            },
                            child: Text(context.l.submit, style: TextStyle(color: CupertinoColors.activeBlue)),
                          ))),
                        ],
                      ),
                      if (initialUrl.isNotEmpty)
                        CupertinoListSection(
                          backgroundColor: pip.getCupertinoListSectionBackgroundColor(context),
                          children: [
                            CupertinoListTile(
                                title: Center(
                                    child: CupertinoButton(
                              onPressed: () async {
                                Navigator.of(context).pop(initialUrl);
                              },
                              child: Text(context.l.cancel,
                                  style: TextStyle(color: CupertinoColors.systemRed.resolveFrom(context))),
                            ))),
                          ],
                        ),
                      pip.PipFooter(),
                    ],
                  )),
            ),
          );
        },
      ),
    );
  }
}

/// provide url screen support
class UrlScreenProvider with ChangeNotifier {
  UrlScreenProvider(String url, pip.ScrollCallback onScroll) {
    urlFieldController.text = url;
    _scrollController.addListener(() => onScroll(_scrollController));
  }

  /// provide url field support
  final TextEditingController urlFieldController = TextEditingController();

  /// the http client
  final httpClient = HttpClient();

  /// the error message
  String? errorMessage;

  /// The scroll controller
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    urlFieldController.dispose();
    httpClient.close(force: true);
    super.dispose();
  }

  /// test if the url is valid
  Future<bool> pingUrl(String url) async {
    try {
      errorMessage = null;
      if (url.isEmpty) {
        errorMessage = 'URL is empty!';
        return false;
      }
      if (url.indexOf('http') != 0) {
        return true; // ping  can only test http/https
      }

      final request = await httpClient.getUrl(Uri.parse(url));
      final response = await request.close();
      if (response.statusCode == 200) {
        return true;
      }
      errorMessage = 'URL is not reachable!';
      return false;
    } catch (e, stackTrace) {
      log("Error occurred: $e", stackTrace: stackTrace);
      errorMessage = '$e';
      return false;
    } finally {
      notifyListeners();
    }
  }
}
