import 'package:fpdart/fpdart.dart';

import 'package:mobile_app_skeleton/core/failures.dart';

/// Type alias for Result type representing either a Failure or a Success value.
///
/// This is a convenient alias for fpdart's Either type, where:
/// - Left represents a Failure
/// - Right represents a Success value
///
/// Usage:
/// ```dart
/// Result<User> fetchUser() async {
///   try {
///     final user = await api.getUser();
///     return Right(user);
///   } catch (e) {
///     return Left(ServerFailure());
///   }
/// }
///
/// // Using the result
/// final result = await fetchUser();
/// result.fold(
///   (failure) => print('Error: $failure'),
///   (user) => print('Success: ${user.name}'),
/// );
/// ```
typedef Result<T> = Either<Failure, T>;

/// Extension methods for Result type to provide convenient operations.
extension ResultX<T> on Result<T> {
  /// Returns true if this Result is a success (Right).
  bool get isSuccess => isRight();

  /// Returns true if this Result is a failure (Left).
  bool get isFailure => isLeft();

  /// Get the success value or null if this is a failure.
  T? get valueOrNull => getOrElse(() => null as T);

  /// Get the failure or null if this is a success.
  Failure? get failureOrNull => swap().getOrElse(() => null as Failure);
}

/// Helper functions to create Result instances.
class Results {
  /// Creates a successful Result with the given value.
  static Result<T> success<T>(T value) => Right(value);

  /// Creates a failed Result with the given failure.
  static Result<T> failure<T>(Failure failure) => Left(failure);

  /// Wraps a function call in a try-catch and returns a Result.
  ///
  /// If the function executes successfully, returns Right with the value.
  /// If an exception is thrown, converts it to a Failure and returns Left.
  static Result<T> tryCatch<T>(
    T Function() fn, {
    Failure Function(Object error, StackTrace stackTrace)? onError,
  }) {
    try {
      return Right(fn());
    } catch (e, stack) {
      final failure =
          onError?.call(e, stack) ?? GeneralFailure();
      return Left(failure);
    }
  }

  /// Async version of tryCatch.
  static Future<Result<T>> tryCatchAsync<T>(
    Future<T> Function() fn, {
    Failure Function(Object error, StackTrace stackTrace)? onError,
  }) async {
    try {
      final value = await fn();
      return Right(value);
    } catch (e, stack) {
      final failure =
          onError?.call(e, stack) ?? GeneralFailure();
      return Left(failure);
    }
  }
}
