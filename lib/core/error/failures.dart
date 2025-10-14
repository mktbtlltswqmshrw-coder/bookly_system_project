import 'package:equatable/equatable.dart';

/// فشل أساسي - Base class لجميع أنواع الفشل
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

// ========== أنواع الفشل المختلفة ==========

/// فشل الخادم - Server Failure
class ServerFailure extends Failure {
  const ServerFailure([super.message = 'حدث خطأ في الخادم']);
}

/// فشل الشبكة - Network Failure
class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'خطأ في الاتصال بالشبكة']);
}

/// فشل التخزين المؤقت - Cache Failure
class CacheFailure extends Failure {
  const CacheFailure([super.message = 'خطأ في التخزين المؤقت']);
}

/// فشل المصادقة - Authentication Failure
class AuthFailure extends Failure {
  const AuthFailure([super.message = 'خطأ في المصادقة']);
}

/// فشل التحقق - Validation Failure
class ValidationFailure extends Failure {
  const ValidationFailure([super.message = 'بيانات غير صحيحة']);
}

/// فشل الصلاحيات - Permission Failure
class PermissionFailure extends Failure {
  const PermissionFailure([super.message = 'ليس لديك صلاحية لهذه العملية']);
}

/// فشل عام - General Failure
class GeneralFailure extends Failure {
  const GeneralFailure([super.message = 'حدث خطأ ما']);
}

/// لم يتم العثور على البيانات - Not Found Failure
class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message = 'البيانات غير موجودة']);
}

/// فشل قاعدة البيانات - Database Failure
class DatabaseFailure extends Failure {
  const DatabaseFailure([super.message = 'خطأ في قاعدة البيانات']);
}

/// فشل الملف - File Failure
class FileFailure extends Failure {
  const FileFailure([super.message = 'خطأ في التعامل مع الملف']);
}

/// انتهت المهلة - Timeout Failure
class TimeoutFailure extends Failure {
  const TimeoutFailure([super.message = 'انتهت مهلة الاتصال']);
}

/// تعارض البيانات - Conflict Failure
class ConflictFailure extends Failure {
  const ConflictFailure([super.message = 'البيانات موجودة مسبقاً']);
}
