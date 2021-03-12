enum ViewState {
  idle, // 空闲
  busy, // 加载中
  empty, // 无数据
  error, // 加载失败
}

enum ViewStateErrorType {
  defaultError,
  networkTimeOutError, // 网络异常
  unauthorizedError, // 未授权登录
}

/// view state error
class ViewStateError {
  ViewStateErrorType _errorType;
  String message;
  String errorMessage;
  ViewStateError(this._errorType, {this.message, this.errorMessage}) {
    _errorType ??= ViewStateErrorType.defaultError;
    message ??= errorMessage;
  }
  ViewStateErrorType get errorType => _errorType;

  /// 以下变量是为了代码书写方便,加入的get方法.严格意义上讲,并不严谨
  get isDefaultError => _errorType == ViewStateErrorType.defaultError;
  get isNetworkTimeOut => _errorType == ViewStateErrorType.networkTimeOutError;
  get isUnauthorized => _errorType == ViewStateErrorType.unauthorizedError;

  @override
  String toString() {
    return 'ViewStateError{errorType: $_errorType, message: $message, errorMessage: $errorMessage}';
  }
}
