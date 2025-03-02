import 'package:flutter/cupertino.dart';

class ResponsiveLayoutBody extends StatelessWidget {
  final Widget mobileBody;
  final Widget desktopBody;

  const ResponsiveLayoutBody({
        super.key,
        required this.mobileBody,
        required this.desktopBody
      });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return mobileBody;
          } else {
            return desktopBody;
          }
        }
    );
  }
}
