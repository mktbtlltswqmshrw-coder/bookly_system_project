/// استثناء أساسي - Base Exception
class AppException implements Exception {
  final String message;
  final dynamic error;

  const AppException(this.message, [this.error]);

  @override
  String toString() => 'AppException: $message${error != null ? ' ($error)' : ''}';
}

// ========== أنواع الاستثناءات المختلفة ==========

/// استثناء الخادم - Server Exception
class ServerException extends AppException {
  const ServerException([super.message = 'حدث خطأ في الخادم', super.error]);
}

/// استثناء الشبكة - Network Exception
class NetworkException extends AppException {
  const NetworkException([super.message = 'خطأ في الاتصال بالشبكة', super.error]);
}

/// استثناء التخزين المؤقت - Cache Exception
class CacheException extends AppException {
  const CacheException([super.message = 'خطأ في التخزين المؤقت', super.error]);
}

/// استثناء المصادقة - Authentication Exception
class AuthException extends AppException {
  const AuthException([super.message = 'خطأ في المصادقة', super.error]);
}

/// استثناء التحقق - Validation Exception
class ValidationException extends AppException {
  const ValidationException([super.message = 'بيانات غير صحيحة', super.error]);
}

/// استثناء الصلاحيات - Permission Exception
class PermissionException extends AppException {
  const PermissionException([super.message = 'ليس لديك صلاحية لهذه العملية', super.error]);
}

/// لم يتم العثور على البيانات - Not Found Exception
class NotFoundException extends AppException {
  const NotFoundException([super.message = 'البيانات غير موجودة', super.error]);
}

/// استثناء قاعدة البيانات - Database Exception
class DatabaseException extends AppException {
  const DatabaseException([super.message = 'خطأ في قاعدة البيانات', super.error]);
}

/// استثناء الملف - File Exception
class FileException extends AppException {
  const FileException([super.message = 'خطأ في التعامل مع الملف', super.error]);
}

/// انتهت المهلة - Timeout Exception
class TimeoutException extends AppException {
  const TimeoutException([super.message = 'انتهت مهلة الاتصال', super.error]);
}

/// تعارض البيانات - Conflict Exception
class ConflictException extends AppException {
  const ConflictException([super.message = 'البيانات موجودة مسبقاً', super.error]);
}

/// استثناء عام - General Exception
class GeneralException extends AppException {
  const GeneralException([super.message = 'حدث خطأ ما', super.error]);
}
