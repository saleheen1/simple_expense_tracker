import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/core/themes/custom_theme.dart';

class LoaderWidget extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final double? radius;
  const LoaderWidget({
    super.key,
    required this.child,
    this.isLoading = false,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Positioned.fill(
            child: PopScope(
              canPop: !isLoading,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: CustomTheme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 15,
                  ),
                  child: const SizedBox(
                    width: 25,
                    height: 25,
                    child: CircularProgressIndicator(
                      color: Color(0xff34B700)
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
