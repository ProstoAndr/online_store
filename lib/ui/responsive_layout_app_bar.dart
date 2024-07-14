import 'package:flutter/material.dart';

class ResponsiveLayoutAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget  mobileAppBar;
  final Widget  desktopAppBar;
  final BuildContext context;

  const ResponsiveLayoutAppBar({
    super.key,
    required this.mobileAppBar,
    required this.desktopAppBar,
    required this.context,
  });

  @override
  Size get preferredSize {
    return Size.fromHeight(MediaQuery.of(context).size.width < 600 ? 100.0 : 60.0);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return mobileAppBar;
        } else {
          return desktopAppBar;
        }
      },
    );
  }
}


