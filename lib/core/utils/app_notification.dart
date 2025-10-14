import 'package:bookly_system/core/constants/app_colors.dart';
import 'package:bookly_system/core/constants/app_dimensions.dart';
import 'package:flutter/material.dart';

/// نظام الإشعارات داخل التطبيق
/// يستخدم بدلاً من SnackBar التقليدي
class AppNotification {
  AppNotification._();

  /// عرض إشعار نجاح
  static void showSuccess(BuildContext context, String message, {Duration duration = const Duration(seconds: 3)}) {
    _show(context, message: message, backgroundColor: AppColors.success, icon: Icons.check_circle, duration: duration);
  }

  /// عرض إشعار خطأ
  static void showError(BuildContext context, String message, {Duration duration = const Duration(seconds: 4)}) {
    _show(context, message: message, backgroundColor: AppColors.errorLight, icon: Icons.error, duration: duration);
  }

  /// عرض إشعار تحذير
  static void showWarning(BuildContext context, String message, {Duration duration = const Duration(seconds: 3)}) {
    _show(context, message: message, backgroundColor: AppColors.warning, icon: Icons.warning, duration: duration);
  }

  /// عرض إشعار معلومات
  static void showInfo(BuildContext context, String message, {Duration duration = const Duration(seconds: 3)}) {
    _show(context, message: message, backgroundColor: AppColors.info, icon: Icons.info, duration: duration);
  }

  /// عرض إشعار مخصص
  static void showCustom(
    BuildContext context, {
    required String message,
    required Color backgroundColor,
    required IconData icon,
    Duration duration = const Duration(seconds: 3),
  }) {
    _show(context, message: message, backgroundColor: backgroundColor, icon: icon, duration: duration);
  }

  /// الدالة الأساسية لعرض الإشعار
  static void _show(
    BuildContext context, {
    required String message,
    required Color backgroundColor,
    required IconData icon,
    required Duration duration,
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => _NotificationWidget(
        message: message,
        backgroundColor: backgroundColor,
        icon: icon,
        onDismiss: () => overlayEntry.remove(),
      ),
    );

    overlay.insert(overlayEntry);

    // إزالة الإشعار بعد المدة المحددة
    Future.delayed(duration, () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    });
  }
}

/// Widget الإشعار
class _NotificationWidget extends StatefulWidget {
  final String message;
  final Color backgroundColor;
  final IconData icon;
  final VoidCallback onDismiss;

  const _NotificationWidget({
    required this.message,
    required this.backgroundColor,
    required this.icon,
    required this.onDismiss,
  });

  @override
  State<_NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<_NotificationWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: AppDimensions.animationDurationMedium, vsync: this);

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _dismiss() {
    _controller.reverse().then((_) => widget.onDismiss());
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + AppDimensions.paddingMD,
      left: AppDimensions.paddingMD,
      right: AppDimensions.paddingMD,
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(AppDimensions.paddingMD),
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
                boxShadow: AppColors.mediumShadow,
              ),
              child: Row(
                children: [
                  Icon(widget.icon, color: Colors.white, size: AppDimensions.iconLG),
                  const SizedBox(width: AppDimensions.spaceMD),
                  Expanded(
                    child: Text(
                      widget.message,
                      style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white, size: AppDimensions.iconMD),
                    onPressed: _dismiss,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
