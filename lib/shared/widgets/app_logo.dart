import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

/// The official LogiFlow brand mark widget.
///
/// Combines the 3D isometric logistics cargo parcel with the supersonic
/// 'Flow' dynamic trajectory arrow. Renders from the high-res branding asset
/// with an instant vector Canvas fallback for tests and offline rendering.
class AppLogo extends StatelessWidget {
  final double size;
  final bool showText;
  final bool isHorizontal;
  final bool withGlow;
  final Color? backgroundColor;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;

  const AppLogo({
    super.key,
    this.size = 76,
    this.showText = false,
    this.isHorizontal = false,
    this.withGlow = true,
    this.backgroundColor,
    this.titleStyle,
    this.subtitleStyle,
  });

  @override
  Widget build(BuildContext context) {
    Widget iconWidget = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size * 0.22),
        boxShadow: withGlow
            ? [
                BoxShadow(
                  color: AppColors.accent.withOpacity(0.28),
                  blurRadius: size * 0.25,
                  offset: Offset(0, size * 0.08),
                  spreadRadius: 1,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.35),
                  blurRadius: size * 0.15,
                  offset: Offset(0, size * 0.04),
                ),
              ]
            : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size * 0.22),
        child: Image.asset(
          'assets/branding/app_logo.png',
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            // High-fidelity vector Canvas fallback
            return CustomPaint(
              size: Size(size, size),
              painter: LogiFlowMarkPainter(
                bgColor: backgroundColor ?? AppColors.primary,
              ),
            );
          },
        ),
      ),
    );

    if (!showText) {
      return iconWidget;
    }

    final wordmark = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment:
          isHorizontal ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Logi',
              style: titleStyle ??
                  TextStyle(
                    fontSize: size * 0.38,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                    color: Colors.white,
                  ),
            ),
            Text(
              'Flow',
              style: titleStyle?.copyWith(color: AppColors.accent) ??
                  TextStyle(
                    fontSize: size * 0.38,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                    color: AppColors.accent,
                  ),
            ),
          ],
        ),
        Text(
          'INTELLIGENT 3PL PLATFORM',
          style: subtitleStyle ??
              TextStyle(
                fontSize: size * 0.13,
                fontWeight: FontWeight.w600,
                letterSpacing: 2.0,
                color: Colors.white70,
              ),
        ),
      ],
    );

    if (isHorizontal) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          iconWidget,
          SizedBox(width: size * 0.2),
          wordmark,
        ],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        iconWidget,
        SizedBox(height: size * 0.18),
        wordmark,
      ],
    );
  }
}

/// Standalone vector Canvas painter for the LogiFlow brand mark.
class LogiFlowMarkPainter extends CustomPainter {
  final Color bgColor;

  const LogiFlowMarkPainter({this.bgColor = const Color(0xFF0B192C)});

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final double cx = w / 2.0;
    final double cy = h / 2.0;

    // 1. Background Rounded Rectangle
    final rect = Rect.fromLTWH(0, 0, w, h);
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(w * 0.22));

    final bgPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF162840), Color(0xFF07101C)],
      ).createShader(rect);
    canvas.drawRRect(rrect, bgPaint);

    // Rim border
    final rimPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = math.max(1.0, w * 0.02)
      ..color = const Color(0x663B5D88);
    canvas.drawRRect(rrect, rimPaint);

    // 2. Ambient Orange Glow
    final glowPaint = Paint()
      ..color = const Color(0x33FF6500)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, w * 0.15);
    canvas.drawCircle(Offset(cx, cy), w * 0.25, glowPaint);

    // 3. Isometric Parcel
    final double boxR = w * 0.26;
    final double cos30 = math.cos(30 * math.pi / 180);
    final double sin30 = math.sin(30 * math.pi / 180);
    final double dx = boxR * cos30;
    final double dy = boxR * sin30;
    final double boxH = boxR * 1.12;

    final double bcx = cx - w * 0.02;
    final double bcy = cy + w * 0.04;

    final pCenter = Offset(bcx, bcy - boxH * 0.35);
    final pTop = Offset(bcx, pCenter.dy - 2 * dy);
    final pRight = Offset(bcx + dx, pCenter.dy - dy);
    final pLeft = Offset(bcx - dx, pCenter.dy - dy);
    final pBottom = Offset(bcx, pCenter.dy + boxH);
    final pLBottom = Offset(bcx - dx, pLeft.dy + boxH);
    final pRBottom = Offset(bcx + dx, pRight.dy + boxH);

    // Left face
    final leftFace = Path()
      ..moveTo(pLeft.dx, pLeft.dy)
      ..lineTo(pCenter.dx, pCenter.dy)
      ..lineTo(pBottom.dx, pBottom.dy)
      ..lineTo(pLBottom.dx, pLBottom.dy)
      ..close();
    canvas.drawPath(leftFace, Paint()..color = const Color(0xFFD94600));

    // Right face
    final rightFace = Path()
      ..moveTo(pRight.dx, pRight.dy)
      ..lineTo(pCenter.dx, pCenter.dy)
      ..lineTo(pBottom.dx, pBottom.dy)
      ..lineTo(pRBottom.dx, pRBottom.dy)
      ..close();
    canvas.drawPath(rightFace, Paint()..color = const Color(0xFFFF6500));

    // Top face
    final topFace = Path()
      ..moveTo(pTop.dx, pTop.dy)
      ..lineTo(pRight.dx, pRight.dy)
      ..lineTo(pCenter.dx, pCenter.dy)
      ..lineTo(pLeft.dx, pLeft.dy)
      ..close();
    canvas.drawPath(topFace, Paint()..color = const Color(0xFFFFA024));

    // Seam tape
    final double tapeW = boxR * 0.22;
    final double tdx = tapeW * cos30 * 0.5;
    final double tdy = tapeW * sin30 * 0.5;

    final topTape = Path()
      ..moveTo(pTop.dx - tdx, pTop.dy + tdy)
      ..lineTo(pTop.dx + tdx, pTop.dy - tdy)
      ..lineTo(pCenter.dx + tdx, pCenter.dy - tdy)
      ..lineTo(pCenter.dx - tdx, pCenter.dy + tdy)
      ..close();
    canvas.drawPath(topTape, Paint()..color = const Color(0xF2FFCD6E));

    final rightTape = Path()
      ..moveTo(pCenter.dx - tdx, pCenter.dy + tdy)
      ..lineTo(pCenter.dx + tdx, pCenter.dy - tdy)
      ..lineTo(pBottom.dx + tdx, pBottom.dy - tdy)
      ..lineTo(pBottom.dx - tdx, pBottom.dy + tdy)
      ..close();
    canvas.drawPath(rightTape, Paint()..color = const Color(0xE6EB5000));

    // Highlight edges
    final edgePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = math.max(1.0, w * 0.012)
      ..color = const Color(0x4DFFFFFF);

    canvas.drawLine(pTop, pRight, edgePaint);
    canvas.drawLine(pTop, pLeft, edgePaint);
    canvas.drawLine(pCenter, pRight, edgePaint);
    canvas.drawLine(pCenter, pLeft, edgePaint);
    canvas.drawLine(pCenter, pBottom, edgePaint);
    canvas.drawLine(pLeft, pLBottom, edgePaint);
    canvas.drawLine(pRight, pRBottom, edgePaint);
    canvas.drawLine(pLBottom, pBottom, edgePaint);
    canvas.drawLine(pRBottom, pBottom, edgePaint);

    // 4. Supersonic Flow Arc (Electric Cyan)
    final flowPath = Path()
      ..moveTo(cx - w * 0.40, cy + h * 0.18)
      ..lineTo(cx - w * 0.18, cy + h * 0.32)
      ..lineTo(cx + w * 0.14, cy + h * 0.28)
      ..lineTo(cx + w * 0.38, cy + h * 0.05)
      ..lineTo(cx + w * 0.34, cy - h * 0.02)
      ..lineTo(cx + w * 0.12, cy + h * 0.19)
      ..lineTo(cx - w * 0.16, cy + h * 0.23)
      ..lineTo(cx - w * 0.35, cy + h * 0.12)
      ..close();
    canvas.drawPath(flowPath, Paint()..color = const Color(0xF200D7FF));

    // Secondary White Pulse Trail
    final pulsePath = Path()
      ..moveTo(cx - w * 0.32, cy + h * 0.21)
      ..lineTo(cx - w * 0.14, cy + h * 0.34)
      ..lineTo(cx + w * 0.10, cy + h * 0.30)
      ..lineTo(cx + w * 0.28, cy + h * 0.16)
      ..lineTo(cx + w * 0.24, cy + h * 0.12)
      ..lineTo(cx + w * 0.08, cy + h * 0.24)
      ..lineTo(cx - w * 0.12, cy + h * 0.27)
      ..lineTo(cx - w * 0.28, cy + h * 0.17)
      ..close();
    canvas.drawPath(pulsePath, Paint()..color = Colors.white);

    // Forward Arrow Head
    final arrowHead = Path()
      ..moveTo(cx + w * 0.43, cy - h * 0.01)
      ..lineTo(cx + w * 0.30, cy - h * 0.12)
      ..lineTo(cx + w * 0.33, cy - h * 0.02)
      ..lineTo(cx + w * 0.28, cy + h * 0.07)
      ..close();
    canvas.drawPath(arrowHead, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
