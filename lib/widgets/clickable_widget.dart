import 'package:flutter/material.dart';
import '../services/sound_service.dart';

class ClickableWidget extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool enableSound;

  const ClickableWidget({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.enableSound = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (enableSound) {
          SoundService().playClickSound();
        }
        onTap?.call();
      },
      onLongPress: () {
        if (enableSound) {
          SoundService().playClickSound();
        }
        onLongPress?.call();
      },
      child: child,
    );
  }
}

class ClickableListTile extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool enableSound;
  final bool isDarkMode;

  const ClickableListTile({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.enableSound = true,
    this.isDarkMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      onTap: () {
        if (enableSound) {
          SoundService().playClickSound();
        }
        onTap?.call();
      },
    );
  }
}

class ClickableButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final bool enableSound;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;

  const ClickableButton({
    super.key,
    required this.child,
    this.onPressed,
    this.enableSound = true,
    this.backgroundColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed != null
          ? () {
              if (enableSound) {
                SoundService().playClickSound();
              }
              onPressed!.call();
            }
          : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: padding,
      ),
      child: child,
    );
  }
}
