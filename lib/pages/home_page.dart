import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iframe_poc/controllers/app_controller.dart';
import 'package:flutter_iframe_poc/pages/widgets/label_widget.dart';
import 'package:flutter_iframe_poc/pages/widgets/label_widget_iframe.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  onPressButton();
                },
                child: Container(
                  height: Get.height * 0.08,
                  width: Get.width * 0.3,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Colors.teal, borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    '${appController.buttonText.value}',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              LabelWidget(
                label: appController.label.value,
                msg: appController.msg.value,
                onTap: (val){
                  appController.buttonText.value = val;
                  appController.msg.value = val;
                },
              ),
              //LabelWidgetiFrame(),
            ],
          ),
        ),
      ),
    );
  }

  void onPressButton() {
    appController.label.value = '123';
  }
}
