import 'package:bookly_system/core/constants/app_dimensions.dart';
import 'package:flutter/material.dart';

/// زر مخصص قابل لإعادة الاستخدام
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutlined;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.width,
    this.height,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final buttonContent = _buildButtonContent();

    if (isOutlined) {
      return SizedBox(
        width: width,
        height: height ?? AppDimensions.buttonHeightMD,
        child: OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: foregroundColor != null
              ? OutlinedButton.styleFrom(
                  foregroundColor: foregroundColor,
                  side: BorderSide(color: foregroundColor!, width: 2),
                  padding: padding,
                )
              : (padding != null ? OutlinedButton.styleFrom(padding: padding) : null),
          child: buttonContent,
        ),
      );
    }

    return SizedBox(
      width: width,
      height: height ?? AppDimensions.buttonHeightMD,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: (backgroundColor != null || foregroundColor != null || padding != null)
            ? ElevatedButton.styleFrom(
                backgroundColor: backgroundColor,
                foregroundColor: foregroundColor,
                padding: padding,
              )
            : null,
        child: buttonContent,
      ),
    );
  }

  Widget _buildButtonContent() {
    if (isLoading) {
      return const SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: AppDimensions.iconMD),
          const SizedBox(width: AppDimensions.spaceSM),
          Text(text),
        ],
      );
    }

    return Text(text);
  }
}

/// زر أيقونة مخصص
class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? backgroundColor;
  final double? size;
  final String? tooltip;

  const CustomIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.color,
    this.backgroundColor,
    this.size,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    final button = IconButton(
      icon: Icon(icon, size: size ?? AppDimensions.iconMD),
      onPressed: onPressed,
      color: color,
      style: backgroundColor != null ? IconButton.styleFrom(backgroundColor: backgroundColor) : null,
    );

    if (tooltip != null) {
      return Tooltip(message: tooltip!, child: button);
    }

    return button;
  }
}
