import 'package:bookly_system/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

/// Use Case أساسي
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// Use Case بدون معاملات
class NoParams extends Equatable {
  const NoParams();
  
  @override
  List<Object> get props => [];
}
