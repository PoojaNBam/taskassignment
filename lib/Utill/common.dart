import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:taskassignment/Utill/colorr.dart';
import 'package:taskassignment/Utill/styles.dart';
import 'package:taskassignment/main.dart';

class Common {
  Common._();

  static customBottomSheet(
      {required BuildContext context,
      required Function(BuildContext context, StateSetter setState) builder,
      bool isDismissible = false}) {
    showModalBottomSheet(
        context: context,
        isDismissible: isDismissible,
        enableDrag: false,
        useSafeArea: true,
        isScrollControlled: true,
        backgroundColor: Colorr.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        builder: (context) {
          return Container(
            decoration: const BoxDecoration(
              color: Colorr.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: StatefulBuilder(
                    builder: (context, setState) => builder(context, setState)),
              ),
            ),
          );
        });
  }

  static showSnackBar(String message, {bool error = true}) {
    Future.delayed(Duration.zero, () {
      if (kScaffoldMessengerKey.currentState != null) {
        kScaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
            content:
                Text(message, style: Styles.txtRegular(color: Colorr.white)),
            backgroundColor: error ? Colorr.red50 : Colorr.green50,
            duration: const Duration(seconds: 2)));
      }
    });
  }

  static showToast(String message, {Color? color}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: color ?? Colorr.red50,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
