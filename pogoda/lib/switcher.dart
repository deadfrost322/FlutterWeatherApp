//lib/switcher.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSwitch extends StatefulWidget {
  final bool value;
  final String textFalse;
  final String textTrue;
  final ValueChanged<bool> onChanged;

  const CustomSwitch(
      {Key? key,
      required this.value,
      required this.onChanged,
      required this.textFalse,
      required this.textTrue})
      : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState(textFalse, textTrue);
}

class _CustomSwitchState extends State<CustomSwitch>
    with SingleTickerProviderStateMixin {
  late Animation _circleAnimation;
  late AnimationController _animationController;

  final String textFalse;
  final String textTrue;

  _CustomSwitchState(this.textFalse, this.textTrue);

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    _circleAnimation = AlignmentTween(
            begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
            end: widget.value ? Alignment.centerLeft : Alignment.centerRight)
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return GestureDetector(
            onTap: () {
              if (_circleAnimation.isCompleted) {
                _animationController.reverse();
              } else {
                _animationController.forward();
              }
              widget.value == false
                  ? widget.onChanged(true)
                  : widget.onChanged(false);
            },
            child: Container(
              width: 150,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  color: const Color.fromRGBO(226, 235, 255, 1),
                  boxShadow: const [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.1),
                        blurRadius: 10,
                        spreadRadius: 0,
                        offset: Offset(0, 4)),
                    BoxShadow(
                        color: Color.fromRGBO(255, 255, 255, 0.25),
                        blurRadius: 4,
                        spreadRadius: 0,
                        offset: Offset(0, -4))
                  ]),
              child: Container(
                alignment:
                    widget.value ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: 75,
                  height: 30,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Color.fromRGBO(75, 95, 136, 1),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.1),
                            blurRadius: 3,
                            spreadRadius: 0,
                            offset: Offset(4, 4)),
                        BoxShadow(
                            color: Color.fromRGBO(255, 255, 255, 0.15),
                            blurRadius: 3,
                            spreadRadius: 0,
                            offset: Offset(-2, -3))
                      ]),
                  child: widget.value
                      ? Center(
                        child: Text((textTrue),
                            style: GoogleFonts.manrope(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: const Color.fromRGBO(255, 255, 255, 1))),
                      )
                      : Center(
                        child: Text((textFalse),
                            style: GoogleFonts.manrope(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: const Color.fromRGBO(255, 255, 255, 1))),
                      ),
                ),
              ),
            ));
      },
    );
  }
}
