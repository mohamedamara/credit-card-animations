import 'package:flutter/material.dart';

import '../../../../themes/custom_text_styles.dart';

class AnimatedCardHolderNameCharacter extends StatefulWidget {
  const AnimatedCardHolderNameCharacter({
    super.key,
    required this.value,
    required this.onAnimationControllerReady,
  });
  final String value;
  final ValueChanged<AnimationController> onAnimationControllerReady;

  @override
  State<AnimatedCardHolderNameCharacter> createState() =>
      _AnimatedCardHolderNameCharacterState();
}

class _AnimatedCardHolderNameCharacterState
    extends State<AnimatedCardHolderNameCharacter>
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
            begin: 0,
            end: 1,
          ).animate(
            CurvedAnimation(
              parent: _animationController,
              curve: Curves.easeInOut,
            ),
          ),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.4, 0.0),
              end: const Offset(0.0, 0.0),
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
        widget.value.toUpperCase(),
        overflow: TextOverflow.ellipsis,
        style: CustomTextStyles.paymentCardHolderNameAndExpirationDateTextStyle,
      ),
    );
  }
}
