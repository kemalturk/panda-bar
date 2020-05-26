import 'package:flutter/material.dart';
import 'package:pandabar/fab-button.view.dart';
import 'package:pandabar/model.dart';
import 'package:pandabar/pandabar.dart';


class PandaBar extends StatefulWidget {

  final Color color;
  final List<PandaBarButtonData> buttonData;
  final Widget fabIcon;

  final Function(String selectedPage) onChange;
  final Function onFabButtonPressed;

  const PandaBar({
    Key key,
    this.onChange,
    this.onFabButtonPressed,
    @required this.buttonData,
    this.color,
    this.fabIcon,
  }) :
    assert(buttonData != null),
    super(key: key);

  @override
  _PandaBarState createState() => _PandaBarState();
}

class _PandaBarState extends State<PandaBar> {

  final double fabSize = 50;
  final Color unSelectedColor = Colors.grey;

  String selectedId = '';


  @override
  void initState() {

    selectedId = widget.buttonData.length > 0 ? widget.buttonData.first.id : '';
    widget.onChange(selectedId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var clipper = _PandaBarClipper(fabSize: fabSize);

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CustomPaint(
          painter: _ClipShadowPainter(
            shadow: Shadow(
              color: Colors.white.withOpacity(.1),
              blurRadius: 10,
              offset: Offset(0, -3)
            ),
            clipper: clipper,
          ),
          child: ClipPath(
            clipper: clipper,
            child: Container(
              height: 70,
              padding: EdgeInsets.symmetric(vertical: 10),
              color: widget.color ?? Color(0xFF222427),
              child: Builder(
                builder: (context) {

                  List<Widget> leadingChildren = [];
                  List<Widget> trailingChildren = [];

                  widget.buttonData.asMap().forEach((i, data) {
                    
                    Widget btn = PandaBarButton(
                      icon: data.icon,
                      title: data.title,
                      isSelected: data.id != null && selectedId == data.id,
                      onTap: () {
                        setState(() {
                          selectedId = data.id;
                        });
                        this.widget.onChange(data.id);
                      },
                    );

                    if(i < 2) {
                      leadingChildren.add(btn);
                    } else {
                      trailingChildren.add(btn);
                    }

                  });

                  return Row(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: leadingChildren,
                        ),
                      ),
                      Container(width: fabSize),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: trailingChildren,
                        ),
                      ),
                    ],
                  );
                }
              ),
            ),
          ),
        ),
        PandaBarFabButton(
          size: fabSize,
          icon: widget.fabIcon,
          onTap: widget.onFabButtonPressed,
        ),
      ],
    );
  }
}

class _PandaBarClipper extends CustomClipper<Path> {

  final double fabSize;
  final double padding = 50;
  final double centerRadius = 25;
  final double cornerRadius = 5;

  _PandaBarClipper({this.fabSize = 100});

  @override
  Path getClip(Size size) {

    final xCenter = (size.width / 2);

    final fabSizeWithPadding = fabSize + padding;

    final path = Path();
    path.lineTo((xCenter - (fabSizeWithPadding / 2) - cornerRadius) , 0);
    path.quadraticBezierTo(xCenter - (fabSizeWithPadding / 2), 0, (xCenter - (fabSizeWithPadding / 2)) + cornerRadius, cornerRadius);
    path.lineTo(xCenter - centerRadius, (fabSizeWithPadding / 2) - centerRadius);
    path.quadraticBezierTo(xCenter, (fabSizeWithPadding / 2), xCenter + centerRadius, (fabSizeWithPadding / 2) - centerRadius);
    path.lineTo((xCenter + (fabSizeWithPadding / 2) - cornerRadius), cornerRadius);
    path.quadraticBezierTo(xCenter + (fabSizeWithPadding / 2), 0, (xCenter + (fabSizeWithPadding / 2) + cornerRadius), 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    path.close();
    
    return path;
  }

  @override
  bool shouldReclip(oldClipper) => false;

}

class _ClipShadowPainter extends CustomPainter {
  final Shadow shadow;
  final CustomClipper<Path> clipper;

  _ClipShadowPainter({@required this.shadow, @required this.clipper});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = shadow.toPaint();
    var clipPath = clipper.getClip(size).shift(shadow.offset);
    canvas.drawPath(clipPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
