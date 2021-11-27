import 'package:flutter/material.dart';

class SelectableCard extends StatefulWidget {
  const SelectableCard({
    Key? key,
    required this.backgroundColor,
    required this.selectionColor,
    required this.selected,
    required this.child,
    required this.onTap,
  }) : super(key: key);

  final Color backgroundColor;
  final Color selectionColor;
  final bool selected;
  final Widget child;
  final void Function()? onTap;

  @override
  _SelectableCardState createState() => _SelectableCardState();
}

class _SelectableCardState extends State<SelectableCard> with SingleTickerProviderStateMixin {
  late AnimationController? _controller;
  late Animation<double>? _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      value: widget.selected ? 1.0 : 0.0,
      duration: kThemeChangeDuration,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(CurvedAnimation(
      parent: _controller!,
      curve: Curves.ease,
    ));
  }

  @override
  void didUpdateWidget(SelectableCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selected != widget.selected) {
      if (widget.selected) {
        _controller!.forward();
      } else {
        _controller!.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation!,
      builder: (BuildContext context, Widget? child) {
        final Color? color = Color.lerp(widget.backgroundColor, widget.selectionColor, _controller!.value);
        return Transform.scale(
          scale: _scaleAnimation!.value,
          child: DecoratedBox(
            decoration: BoxDecoration(color: color),
            child: child,
          ),
        );
      },
      child: Card(
        semanticContainer: true,
        child: InkWell(
          onTap: widget.onTap,
          child: GridTile(child: widget.child),
        ),
        shape: const BeveledRectangleBorder(),
      ),
    );
  }
}