import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/assets_path.dart';

class ScreenBackground extends StatelessWidget {
  const ScreenBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SvgPicture.asset(
            AssetsPath.backgroundSvg,
            fit: BoxFit.cover,
            height: size.height,
            width: size.width,
          ),
          SafeArea(child: child),
        ],
      ),
    );
  }
}
