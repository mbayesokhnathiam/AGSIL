import 'package:flutter/material.dart';

class BubbleIndicator extends Decoration {
  @override
  _CustomPainter createBoxPainter([VoidCallback? onChanged]) {
    return new _CustomPainter(this, onChanged!);
  }
}

class _CustomPainter extends BoxPainter {
  final BubbleIndicator decoration;

  _CustomPainter(this.decoration, VoidCallback onChanged)
      : assert(decoration != null),
        super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration != null);
    assert(configuration.size != null);

    //offset is the position from where the decoration should be drawn.
    //configuration.size tells us about the height and width of the tab.

    //In this, we will create a variable to hold [indicatorHeight] i.e 15.0
//Now, we will create a new offset to set the x-axis position of tab according to the TabIndicatorSize i.e label or tab start.
//And set the y-axis to tab height center position and subtracting the value of indicatorHeight center value.

    //final Rect rect = offset & configuration.size/2;
    final Rect rect = Offset(offset.dx + configuration.size!.width / 4,
            offset.dy + configuration.size!.height / 6) &
        Size(configuration.size!.width / 2, configuration.size!.height / 1.5);
    final Paint paint = Paint();
    paint.color = Colors.yellow[800]!;
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(
        RRect.fromRectAndRadius(rect, Radius.circular(60.0)), paint);
  }
}
