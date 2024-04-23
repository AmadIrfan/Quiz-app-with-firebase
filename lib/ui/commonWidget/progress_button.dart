import 'package:flutter/material.dart';
import 'package:flutter_logical_quiz/ui/commonWidget/icon_button.dart';

import '../../resizer/widget_utils.dart';

enum ButtonState { idle, loading, success }

class ProgressButton extends StatefulWidget {
  final Map<ButtonState, Widget> stateWidgets;
  final Map<ButtonState, Color> stateColors;
  final Function? onPressed;
  final Function? onAnimationEnd;
  final ButtonState? state;
  final double minWidth;
  final double maxWidth;
  final double radius;
  final double height;
  final ProgressIndicator? progressIndicator;
  final double progressIndicatorSize;
  final MainAxisAlignment progressIndicatorAlignment;
  final EdgeInsets padding;
  final List<ButtonState> minWidthStates;
  final Duration animationDuration;

  ProgressButton(
      {Key? key,
      required this.stateWidgets,
      required this.stateColors,
      this.state = ButtonState.idle,
      this.onPressed,
      this.onAnimationEnd,
      this.minWidth = 200.0,
      this.maxWidth = 600.0,
      this.radius = 16.0,
      this.height = 53.0,
      this.progressIndicatorSize = 35.0,
      this.progressIndicator,
      this.progressIndicatorAlignment = MainAxisAlignment.spaceBetween,
      this.padding = EdgeInsets.zero,
      this.minWidthStates = const <ButtonState>[ButtonState.loading],
      this.animationDuration = const Duration(milliseconds: 500)})
      : assert(
          stateWidgets.keys.toSet().containsAll(ButtonState.values.toSet()),
          'Must be non-null widgetds provided in map of stateWidgets. Missing keys => ${ButtonState.values.toSet().difference(stateWidgets.keys.toSet())}',
        ),
        assert(
          stateColors.keys.toSet().containsAll(ButtonState.values.toSet()),
          'Must be non-null widgetds provided in map of stateWidgets. Missing keys => ${ButtonState.values.toSet().difference(stateColors.keys.toSet())}',
        ),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProgressButtonState();
  }

  factory ProgressButton.icon({
    required Map<ButtonState, CustomIconButton> iconButtons,
    Function? onPressed,
    ButtonState? state = ButtonState.idle,
    Function? animationEnd,
    maxWidth = 600.0,
    minWidth = 100.0,
    height = 53.0,
    radius = 100.0,
    progressIndicatorSize = 35.0,
    double iconPadding = 4.0,
    TextStyle? textStyle,
    CircularProgressIndicator? progressIndicator,
    MainAxisAlignment? progressIndicatorAlignment,
    EdgeInsets padding = EdgeInsets.zero,
    List<ButtonState> minWidthStates = const <ButtonState>[ButtonState.loading],
  }) {
    assert(
      iconButtons.keys.toSet().containsAll(ButtonState.values.toSet()),
      'Must be non-null widgets provided in map of stateWidgets. Missing keys => ${ButtonState.values.toSet().difference(iconButtons.keys.toSet())}',
    );

    textStyle ??=
        const TextStyle(color: Colors.white, fontWeight: FontWeight.w500);

    Map<ButtonState, Widget> stateWidgets = {
      ButtonState.idle: buildChildWithIcon(
          iconButtons[ButtonState.idle]!, iconPadding, textStyle),
      ButtonState.loading: Column(),
      ButtonState.success: buildChildWithIcon(
          iconButtons[ButtonState.success]!, iconPadding, textStyle)
    };
    Map<ButtonState, Color> stateColors = {
      ButtonState.idle: iconButtons[ButtonState.idle]!.color,
      ButtonState.loading: iconButtons[ButtonState.loading]!.color,
      ButtonState.success: iconButtons[ButtonState.success]!.color,
    };

    return ProgressButton(
      stateWidgets: stateWidgets,
      stateColors: stateColors,
      state: state,
      onPressed: onPressed,
      onAnimationEnd: animationEnd,
      maxWidth: maxWidth,
      minWidth: minWidth,
      radius: radius,
      height: height,
      progressIndicatorSize: progressIndicatorSize,
      progressIndicatorAlignment: MainAxisAlignment.center,
      progressIndicator: progressIndicator,
      minWidthStates: minWidthStates,
    );
  }
}

class _ProgressButtonState extends State<ProgressButton>
    with TickerProviderStateMixin {
  AnimationController? colorAnimationController;
  Animation<Color?>? colorAnimation;
  double? width;
  Widget? progressIndicator;

  void startAnimations(ButtonState? oldState, ButtonState? newState) {
    Color? begin = widget.stateColors[oldState!];
    Color? end = widget.stateColors[newState!];
    if (widget.minWidthStates.contains(newState)) {
      width = widget.minWidth;
    } else {
      width = widget.maxWidth;
    }
    colorAnimation = ColorTween(begin: begin, end: end).animate(CurvedAnimation(
      parent: colorAnimationController!,
      curve: const Interval(
        0,
        1,
        curve: Curves.easeIn,
      ),
    ));
    colorAnimationController!.forward();
  }

  Color? get backgroundColor => colorAnimation == null
      ? widget.stateColors[widget.state!]
      : colorAnimation!.value ?? widget.stateColors[widget.state!];

  @override
  void initState() {
    super.initState();

    width = widget.maxWidth;

    colorAnimationController =
        AnimationController(duration: widget.animationDuration, vsync: this);
    colorAnimationController!.addStatusListener((status) {
      if (widget.onAnimationEnd != null) {
        widget.onAnimationEnd!(status, widget.state);
      }
    });

    progressIndicator = const CircularProgressIndicator(
      value: null,
      strokeWidth: 2,
      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
    );
    // CircularProgressIndicator(
    //     backgroundColor: widget.stateColors[widget.state!],
    //
    //
    //
    //     valueColor: AlwaysStoppedAnimation<Color>(Colors.white));
  }

  @override
  void dispose() {
    colorAnimationController!.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(ProgressButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.state != widget.state) {
      colorAnimationController?.reset();
      startAnimations(oldWidget.state, widget.state);
    }
  }

  Widget getButtonChild(bool visibility) {
    Widget? buttonChild = widget.stateWidgets[widget.state!];
    if (widget.state == ButtonState.loading) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(
            width: widget.progressIndicatorSize,
            height: widget.progressIndicatorSize,
            child: progressIndicator,
          ),
          buttonChild ?? Container(),
          Container()
        ],
      );
    }
    return AnimatedOpacity(
        opacity: visibility ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 250),
        child: Center(
          child: buttonChild,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: colorAnimationController!,
      builder: (context, child) {
        return AnimatedContainer(
            width: width,
            height: widget.height,
            duration: widget.animationDuration,
            child: MaterialButton(
              padding: widget.padding,
              elevation: 0,
              shape: const RoundedRectangleBorder(
                  // borderRadius: BorderRadius.circular(widget.radius),
                  side: BorderSide(color: Colors.transparent, width: 0)),

              // color: backgroundColor,
              onPressed: widget.onPressed as void Function()?,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: width! <= 180
                    ? BoxDecoration(
                        shape: BoxShape.circle, color: backgroundColor)
                    : getDefaultDecoration(
                        radius: widget.radius, bgColor: backgroundColor),
                child: getButtonChild(colorAnimation == null
                    ? true
                    : colorAnimation!.isCompleted),
              ),
            ));
      },
    );
  }
}
