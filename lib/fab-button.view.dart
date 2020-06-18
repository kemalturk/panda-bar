import 'package:flutter/material.dart';
import 'dart:math' as math;

class PandaBarFabButton extends StatefulWidget {
  final double size;
  final Function onTap;
  final List<Color> colors;
  final Widget icon;

  const PandaBarFabButton({
    Key key,
    @required this.size,
    @required this.onTap,
    this.colors,
    this.icon,
  }) : super(key: key);

  @override
  _PandaBarFabButtonState createState() => _PandaBarFabButtonState();
}

class _PandaBarFabButtonState extends State<PandaBarFabButton> {
  bool _touched = false;

  @override
  Widget build(BuildContext context) {
    final _colors = widget.colors ??
        [
          Color(0xFF0286EA),
          Color(0xFF27A1FE),
        ];

    return Padding(
      padding: EdgeInsets.only(bottom: 50),
      child: InkResponse(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: widget.onTap,
        onHighlightChanged: (touched) {
          setState(() {
            _touched = touched;
          });
        },
        child: Transform.rotate(
          angle: 45 * math.pi / 180,
          child: Container(
            width: _touched ? widget.size - 1 : widget.size,
            height: _touched ? widget.size - 1 : widget.size,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.size / 3),
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: _touched ? _colors : _colors.reversed.toList()),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black38,
                      blurRadius: 5,
                      offset: Offset(3, 3))
                ]),
            child: Center(
              child: Transform.rotate(
                  angle: -45 * math.pi / 180,
                  child: this.widget.icon ??
                      Icon(
                        Icons.add,
                        size: widget.size / 1.5,
                        color: Colors.white,
                      )),
            ),
          ),
        ),
      ),
    );
  }
}
