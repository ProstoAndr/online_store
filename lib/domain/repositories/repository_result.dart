import 'package:online_store/data/requests/base_request.dart';

sealed class RepositoryResult<T> {
  static RepositoryResult<T> fromApiResult<T, S>(
      T Function(S data) mapper,
      ApiResult<S> result, [
        RepositoryResult<T> Function()? onUnauthorized,
      ]) {
    switch (result) {
      case ApiResultSuccess(:var data):
        return RepositoryResultSuccess(mapper(data));
      case ApiResultFailure(:var errorCode):
        return RepositoryResultFailure(errorCode);
      case ApiResultNoInternet():
        return RepositoryResultFailure(521);
    }
  }
}

class RepositoryResultSuccess<T> implements RepositoryResult<T> {
  final T data;

  RepositoryResultSuccess(this.data);

  @override
  String toString() {
    return "RepositoryResultFailure<${T.runtimeType}>: $data";
  }
}

class RepositoryResultFailure<T> implements RepositoryResult<T> {
  final int errorCode;

  RepositoryResultFailure(this.errorCode);

  @override
  String toString() {
    return "RepositoryResultFailure<${T.runtimeType}>: $errorCode";
  }
}