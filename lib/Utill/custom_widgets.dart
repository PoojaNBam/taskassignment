import 'package:flutter/material.dart';
import 'package:taskassignment/Utill/colorr.dart';
import 'package:taskassignment/Utill/styles.dart';

AppBar customAppBar() {
  return AppBar(
    clipBehavior: Clip.none,
    backgroundColor: Colors.black,
    title: Container(
      child: Padding(
        padding: EdgeInsets.only(top: 15, left: 15),
        child: Text(
          'My Profile',
          style: Styles.txtRegular(
            fontSize: 17,
            color: Colors.white,
          ),
        ),
      ),
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(30),
      ),
    ),
    bottom: PreferredSize(
        preferredSize: const Size.fromHeight(80.0), child: Container()),
  );
}

class CDivider extends StatelessWidget {
  final double? width;
  final double? height;

  const CDivider({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 150,
      height: height ?? 3,
      color: Colors.black,
    );
  }
}

class VSpace extends StatelessWidget {
  final double space;

  const VSpace({super.key, this.space = 10});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: space);
  }
}

class HSpace extends StatelessWidget {
  final double space;

  const HSpace({super.key, this.space = 10});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: space);
  }
}

class CButton extends StatelessWidget {
  final String text;
  final Function() onTap;
  final double? width;
  final double? height;
  final Color? backColor;
  final Color? textColor;
  final double? fontSize;
  final Color? borderColor;
  final bool loading;
  final Color? loaderColor;
  final double? radius;
  final IconData? prefixIcon;
  final TextStyle? textStyle;

  const CButton(
      {super.key,
      required this.text,
      required this.onTap,
      this.width,
      this.height,
      this.backColor,
      this.textColor,
      this.fontSize,
      this.borderColor,
      this.loading = false,
      this.loaderColor,
      this.radius,
      this.prefixIcon,
      this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !loading,
      replacement: Progress(color: loaderColor),
      child: Tap(
        onTap: () {
          onTap();
        },
        child: Container(
          width: width ?? MediaQuery.of(context).size.width,
          height: height ?? 40,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: backColor ?? Colorr.transparent,
              border: (borderColor != null)
                  ? Border.all(color: borderColor ?? Colorr.primary)
                  : null,
              borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                    visible: (prefixIcon != null),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(prefixIcon,
                            size: 20, color: textColor ?? Colorr.primary),
                        const HSpace(space: 2),
                      ],
                    )),
                Flexible(
                  child: Text(text,
                      overflow: TextOverflow.ellipsis,
                      style:
                          textStyle /*??
                        Styles.txtRegular(
                            color: (textColor != null)
                                ? textColor
                                : (backColor == Colorr.primary)
                                    ? Colorr.white
                                    : Colorr.primary,
                            fontSize: fontSize),*/
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Progress extends StatelessWidget {
  final Color? color;

  const Progress({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: CircularProgressIndicator(color: color ?? Colorr.primary));
  }
}

class Tap extends StatelessWidget {
  final GestureTapCallback? onTap;
  final Widget? child;
  final Color? splashColor;
  final Color? overlayColor;

  const Tap(
      {super.key, this.onTap, this.child, this.splashColor, this.overlayColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: splashColor ?? Colorr.transparent,
      hoverColor: Colorr.transparent,
      overlayColor:
          MaterialStateProperty.all(overlayColor ?? Colorr.transparent),
      onTap: onTap,
      child: child,
    );
  }
}
