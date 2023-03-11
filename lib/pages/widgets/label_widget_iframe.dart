import 'package:flutter/material.dart';
import 'package:flutter_iframe_poc/controllers/app_controller.dart';
import 'package:get/get.dart';
import 'package:webviewx/webviewx.dart';

class LabelWidgetiFrame extends StatefulWidget {
  const LabelWidgetiFrame({Key? key}) : super(key: key);

  @override
  State<LabelWidgetiFrame> createState() => _LabelWidgetiFrameState();
}

class _LabelWidgetiFrameState extends State<LabelWidgetiFrame> {
  final appController = Get.find<AppController>();
  TextEditingController inputController = TextEditingController();
  late WebViewXController webviewController;
  final initialContent = '<h4> This is some hardcoded HTML code embedded inside the webview <h4> <h2> Hello world! <h2>';

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        height: Get.height * 0.45,
        width: Get.width * 0.45,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.teal),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'A Flutter Widget that receive string from web',
              style: TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: _buildWebViewX(),
            ),
            Text(
              'Label: ${appController.label.value}',
              style: TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  onTapSend();
                },
                child: Container(
                  height: Get.height * 0.06,
                  width: Get.width * 0.2,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Send',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWebViewX() {
    return WebViewX(
      key: const ValueKey('webviewx'),
      initialContent: initialContent,
      initialSourceType: SourceType.html,
      height: Get.height * 0.15,
      width: Get.width * 0.44,
      onWebViewCreated: (controller) => webviewController = controller,
      onPageStarted: (src) => debugPrint('A new page has started loading: $src\n'),
      onPageFinished: (src) => debugPrint('The page has finished loading: $src\n'),
      jsContent: const {
        EmbeddedJsContent(
          js: "function testPlatformIndependentMethod() { console.log('Hi from JS') }",
        ),
        EmbeddedJsContent(
          webJs: "function testPlatformSpecificMethod(msg) { TestDartCallback('Web callback says: ' + msg) }",
          mobileJs: "function testPlatformSpecificMethod(msg) { TestDartCallback.postMessage('Mobile callback says: ' + msg) }",
        ),
      },
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

  onTapSend() {
    webviewController.loadContent(
      '<h4> ABCD <h4>',
      SourceType.html,
    );
    appController.buttonText.value = 'ABCD';
  }
}
