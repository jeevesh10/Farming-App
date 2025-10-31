import 'package:flutter/material.dart';
import '../services/sound_service.dart';

class ClickableTabBar extends StatelessWidget implements PreferredSizeWidget {
  final TabController controller;
  final List<Widget> tabs;
  final bool isScrollable;
  final Color? labelColor;
  final Color? unselectedLabelColor;
  final Decoration? indicator;
  final Function(int)? onTap;

  const ClickableTabBar({
    super.key,
    required this.controller,
    required this.tabs,
    this.isScrollable = false,
    this.labelColor,
    this.unselectedLabelColor,
    this.indicator,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      tabs: tabs,
      isScrollable: isScrollable,
      labelColor: labelColor,
      unselectedLabelColor: unselectedLabelColor,
      indicator: indicator,
      onTap: (index) {
        SoundService().playClickSound();
        onTap?.call(index);
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class ClickableTab extends StatelessWidget {
  final Widget? child;
  final String? text;
  final Widget? icon;
  final VoidCallback? onTap;

  const ClickableTab({
    super.key,
    this.child,
    this.text,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        SoundService().playClickSound();
        onTap?.call();
      },
      child: Tab(
        child: child,
        text: text,
        icon: icon,
      ),
    );
  }
}
