import 'dart:typed_data';
import 'package:dashboard_screen_task/util/ui/text.dart';
import 'package:flutter/material.dart';

enum AvatarTypes { imageAvatar, textAvatar, iconAvatar }

class UTILAvatar extends StatelessWidget {
  final AvatarTypes avtrType;
  final dynamic avtrImg;
  final String? avtrText;
  final double radius;
  final IconData? icon;
  final Color? iconColor;
  final Color? avtrBrdrColor;

  final Function()? onClickEvent;

  const UTILAvatar({
    super.key,
    required this.avtrType,
    this.avtrText,
    this.avtrImg,
    this.icon,
    this.iconColor,
    this.avtrBrdrColor,
    required this.radius,
    this.onClickEvent,
  });

  @override
  Widget build(BuildContext context) {
    if (avtrBrdrColor != null) {
      return avatarWithBorder(context);
    } else if (avtrType == AvatarTypes.imageAvatar) {
      return getAvatarImage(context);
    } else if (avtrType == AvatarTypes.textAvatar) {
      return getAvatarText(context);
    } else if (avtrType == AvatarTypes.iconAvatar) {
      return getAvatarIcon(context);
    } else {
      return avatarWithBorder(context);
    }
  }

  Widget getAvatarImage(BuildContext context) {
    return GestureDetector(
        onTap: () {
          onClickEvent!();
        },
        child: (avtrImg is Uint8List)
            ? CircleAvatar(
                radius: radius,
                backgroundColor: (Theme.of(context).brightness == Brightness.dark) ? Colors.white12 : Colors.white,
                backgroundImage: MemoryImage(avtrImg),
              )
            : CircleAvatar(
                radius: radius,
                backgroundColor: (Theme.of(context).brightness == Brightness.dark) ? Colors.white12 : Colors.white,
                backgroundImage: AssetImage(avtrImg),
              ));
  }

  Widget getAvatarText(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: (Theme.of(context).brightness == Brightness.dark) ? Colors.white12 : Theme.of(context).colorScheme.background,
      foregroundColor: (Theme.of(context).brightness == Brightness.dark) ? Colors.white : Colors.black,
      child: UTILText(avtrText ?? "DP"),
    );
  }

  Widget getAvatarIcon(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: (Theme.of(context).brightness == Brightness.dark) ? Colors.white12 : Theme.of(context).colorScheme.background,
      foregroundColor: (Theme.of(context).brightness == Brightness.dark) ? Colors.white : Colors.black,
      child: Icon(
        icon,
        color: iconColor,
        size: 30,
      ),
    );
  }

  Widget avatarWithBorder(BuildContext context) {
    Widget child;
    if (avtrType == AvatarTypes.imageAvatar) {
      child = getAvatarImage(context);
    } else if (avtrType == AvatarTypes.textAvatar) {
      child = getAvatarText(context);
    } else {
      child = getAvatarIcon(context);
    }
    return CircleAvatar(
      radius: radius + 5,
      backgroundColor: avtrBrdrColor,
      child: child,
    );
  }
}
