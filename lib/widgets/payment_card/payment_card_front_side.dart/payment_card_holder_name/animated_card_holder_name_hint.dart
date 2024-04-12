import 'package:flutter/material.dart';

import '../../../../themes/custom_text_styles.dart';

class AnimatedCardHolderNameHint extends StatefulWidget {
  const AnimatedCardHolderNameHint({
    super.key,
    required this.isCardHolderNameEmpty,
    required this.onAnimationControllerReady,
  });

  final bool isCardHolderNameEmpty;
  final ValueChanged<AnimationController> onAnimationControllerReady;

  @override
  State<AnimatedCardHolderNameHint> createState() =>
      _AnimatedCardHolderNameHintState();
}

class _AnimatedCardHolderNameHintState extends State<AnimatedCardHolderNameHint>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    widget.onAnimationControllerReady(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: Tween<double>(
            begin: widget.isCardHolderNameEmpty ? 0 : 1,
            end: widget.isCardHolderNameEmpty ? 1 : 0,
          ).animate(
            CurvedAnimation(
              parent: _animationController,
              curve: Curves.easeInOut,
            ),
          ),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: widget.isCardHolderNameEmpty
                  ? const Offset(0.0, 0.6)
                  : const Offset(0.0, 0.0),
              end: widget.isCardHolderNameEmpty
                  ? const Offset(0.0, 0.0)
                  : const Offset(0.0, -0.6),
            ).animate(
              CurvedAnimation(
                parent: _animationController,
                curve: Curves.easeInOut,
              ),
            ),
            child: child,
          ),
        );
      },
      child: Text(
        'full name'.toUpperCase(),
        overflow: TextOverflow.ellipsis,
        style: CustomTextStyles.paymentCardHolderNameAndExpirationDateTextStyle,
      ),
    );
  }
}
