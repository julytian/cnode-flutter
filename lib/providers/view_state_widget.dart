import 'package:cnode_flutter2/config/resource_manager.dart';
import 'package:cnode_flutter2/generated/l10n.dart';
import 'package:cnode_flutter2/providers/view_state.dart';
import 'package:flutter/material.dart';

/// 加载中 widget
class ViewStateBusyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

/// 基础状态 widget
class ViewStateWidget extends StatelessWidget {
  final String title;
  final String message;
  final Widget image;
  final Widget buttonText;
  final String buttonTextData;
  final VoidCallback onPressed;

  const ViewStateWidget({
    Key key,
    @required this.onPressed,
    this.title,
    this.message,
    this.image,
    this.buttonText,
    this.buttonTextData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var titleStyle =
        Theme.of(context).textTheme.subtitle2.copyWith(color: Colors.grey);
    var messageStyle = titleStyle.copyWith(
      color: titleStyle.color.withOpacity(0.7),
      fontSize: 14,
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        image ??
            Icon(
              IconFonts.pageError,
              size: 80,
              color: Colors.grey[500],
            ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 30,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                title ?? S.of(context).viewStateMessageError,
                style: titleStyle,
              ),
              SizedBox(
                height: 20,
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 200,
                  minHeight: 150,
                ),
                child: SingleChildScrollView(
                  child: Text(
                    message ?? '',
                    style: messageStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
        Center(
          child: ViewStateButton(
            child: buttonText,
            textData: buttonTextData,
            onPressed: onPressed,
          ),
        ),
      ],
    );
  }
}

/// 页面无数据 widget
class ViewStateEmptyWidget extends StatelessWidget {
  final String message;
  final Widget image;
  final Widget buttonText;
  final VoidCallback onPressed;

  const ViewStateEmptyWidget({
    Key key,
    @required this.onPressed,
    this.image,
    this.message,
    this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewStateWidget(
      onPressed: this.onPressed,
      image: image ??
          Icon(
            IconFonts.pageEmpty,
            size: 100,
            color: Colors.grey,
          ),
      title: message ?? S.of(context).viewStateMessageEmpty,
      buttonText: buttonText,
      buttonTextData: S.of(context).viewStateButtonRefresh,
    );
  }
}

/// 错误状态 widget
class ViewStateErrorWidget extends StatelessWidget {
  final ViewStateError error;
  final String title;
  final String message;
  final Widget image;
  final Widget buttonText;
  final String buttonTextData;
  final VoidCallback onPressed;

  const ViewStateErrorWidget({
    Key key,
    @required this.error,
    @required this.onPressed,
    this.image,
    this.title,
    this.message,
    this.buttonText,
    this.buttonTextData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var defaultImage;
    var defaultTitle;
    var errorMessage = error.message;
    String defaultTextData = S.of(context).viewStateButtonRetry;
    switch (error.errorType) {
      case ViewStateErrorType.networkTimeOutError:
        defaultImage = Transform.translate(
          offset: Offset(-50, 0),
          child: Icon(
            IconFonts.pageNetworkError,
            size: 100,
            color: Colors.grey,
          ),
        );
        defaultTitle = S.of(context).viewStateMessageNetworkError;
        break;
      case ViewStateErrorType.defaultError:
        defaultImage = Icon(
          IconFonts.pageError,
          size: 100,
          color: Colors.grey,
        );
        defaultTitle = S.of(context).viewStateMessageError;
        break;

      case ViewStateErrorType.unauthorizedError:
        return ViewStateUnAuthWidget(
          image: image,
          message: message,
          buttonText: buttonText,
          onPressed: onPressed,
        );
    }

    return ViewStateWidget(
      onPressed: this.onPressed,
      image: image ?? defaultImage,
      title: title ?? defaultTitle,
      message: message ?? errorMessage,
      buttonTextData: buttonTextData ?? defaultTextData,
      buttonText: buttonText,
    );
  }
}

/// 页面未授权
class ViewStateUnAuthWidget extends StatelessWidget {
  final String message;
  final Widget image;
  final Widget buttonText;
  final VoidCallback onPressed;
  final String heroTag;

  const ViewStateUnAuthWidget({
    Key key,
    @required this.onPressed,
    this.image,
    this.message,
    this.buttonText,
    this.heroTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewStateWidget(
      onPressed: this.onPressed,
      image: image ?? ViewStateUnAuthImage(heroTag),
      title: message ?? S.of(context).viewStateMessageUnAuth,
      buttonText: buttonText,
      buttonTextData: S.of(context).viewStateButtonLogin,
    );
  }
}

/// 未授权图片
class ViewStateUnAuthImage extends StatelessWidget {
  final String heroTag;
  ViewStateUnAuthImage(this.heroTag);
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroTag ?? 'loginLogo',
      child: Image.asset(
        ImageHelper.wrapAssets('login_logo.png'),
        width: 130,
        height: 100,
        fit: BoxFit.fitWidth,
        color: Theme.of(context).accentColor,
        colorBlendMode: BlendMode.srcIn,
      ),
    );
  }
}

/// 公共状态 Button
class ViewStateButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final String textData;

  const ViewStateButton({
    @required this.onPressed,
    this.child,
    this.textData,
  }) : assert(child == null || textData == null);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: child ??
          Text(
            textData ?? S.of(context).viewStateButtonRetry,
            style: TextStyle(wordSpacing: 5),
          ),
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Colors.grey),
      ),
    );
  }
}
