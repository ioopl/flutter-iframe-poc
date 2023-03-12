import 'package:flutter/material.dart';
import 'package:flutter_iframe_poc/controllers/app_controller.dart';
import 'package:get/get.dart';
import 'package:webviewx/webviewx.dart';
import 'dart:html' as html;

class LabelWidgetiFrame extends StatefulWidget {
  const LabelWidgetiFrame({Key? key}) : super(key: key);

  @override
  State<LabelWidgetiFrame> createState() => _LabelWidgetiFrameState();
}

class _LabelWidgetiFrameState extends State<LabelWidgetiFrame> {
  final appController = Get.find<AppController>();
  TextEditingController inputController = TextEditingController();
  late WebViewXController webviewController;
  //final initialContent = '<h4> Web Content <h4> <h2> Hello world! <h2>';
  final initialContent = 'http://localhost:61341/#/';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: _buildWebViewX(),
    );
  }

  Widget _buildWebViewX() {
    return WebViewX(
      key: const ValueKey('webviewx'),
      initialContent: initialContent,
      initialSourceType: SourceType.url,
      height: Get.height * 0.68,
      width: Get.width * 0.45,
      onWebViewCreated: (controller) => webviewController = controller,
      onPageStarted: (src) => debugPrint('A new page has started loading: $src\n'),
      onPageFinished: (src) => debugPrint('The page has finished loading: $src\n'),
      dartCallBacks: {
        DartCallback(
          name: 'TestDartCallback',
          callBack: (msg) {
            print('msg=========$msg');
          },
        )
      },
      webSpecificParams: const WebSpecificParams(
        printDebugInfo: true,
      ),
      mobileSpecificParams: const MobileSpecificParams(
        androidEnableHybridComposition: true,
      ),
      navigationDelegate: (navigation) {
        debugPrint(navigation.content.sourceType.toString());
        return NavigationDecision.navigate;
      },
    );
  }

  onTap() {
    webviewController.loadContent(
      'http://localhost:55335/#/',
      SourceType.url,
    );
    appController.buttonText.value = 'ABCD';
  }
}
