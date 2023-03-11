import 'package:flutter/material.dart';
import 'package:flutter_iframe_poc/controllers/app_controller.dart';
import 'package:get/get.dart';

class LabelWidget extends StatefulWidget {
  final String label;
  String? msg;
  final Function(String)? onTap;

  LabelWidget({Key? ke, this.label = '',this.msg, this.onTap});

  @override
  State<LabelWidget> createState() => _LabelWidgetState();
}

class _LabelWidgetState extends State<LabelWidget> {


  @override
  Widget build(BuildContext context) {
    return Container(
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
            height: Get.height * 0.18,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(),
            ),
            child: Text('${widget.msg}'),
          ),
          Text(
            'Label: ${widget.label}',
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
    );
  }

  onTapSend() {
    setState(() {
      widget.msg = 'ABC';
    });
    widget.onTap!.call(widget.msg!);
  }
}
