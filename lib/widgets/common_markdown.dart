import 'package:cnode_flutter2/config/resource_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';

class CommonMarkdown extends StatelessWidget {
  final String content;

  CommonMarkdown(this.content, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      fitContent: false,
      selectable: true,
      onTapLink: (text, href, title) async {
        if (await canLaunch(href)) {
          await launch(href);
        }
      },
      imageBuilder: (Uri uri, String title, String alt) {
        var url = uri.toString();
        if (url.startsWith('//')) {
          url = 'https:' + url;
        }
        return GestureDetector(
          onTap: () async {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  backgroundColor: Colors.transparent,
                  child: Container(
                    child: PhotoView(
                      backgroundDecoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      tightMode: true,
                      imageProvider: NetworkImage(url),
                    ),
                  ),
                  elevation: 0,
                );
              },
            );
          },
          child: Container(
            margin: EdgeInsets.only(top: 5),
            alignment: Alignment.center,
            child: FadeInImage(
              placeholder: AssetImage(
                ImageHelper.wrapAssets('default_logo.png'),
              ),
              image: NetworkImage(url),
              imageErrorBuilder: (context, _, __) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Transform.translate(
                    offset: Offset(-50, 0),
                    child: const Icon(IconFonts.pageNetworkError,
                        size: 100, color: Colors.grey),
                  ),
                );
              },
            ),
          ),
        );
      },
      data: content,
      styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
        p: Theme.of(context).textTheme.bodyText2.copyWith(
              letterSpacing: 1.1,
            ),
        code: Theme.of(context).textTheme.bodyText2.copyWith(
              color: Theme.of(context).accentColor,
              letterSpacing: 1.1,
              wordSpacing: 1.2,
              fontSize: 14,
            ),
        blockquote: Theme.of(context).textTheme.bodyText2.copyWith(
              letterSpacing: 1.1,
              wordSpacing: 1.2,
              color: Theme.of(context).textTheme.caption.color,
              height: 1.5,
            ),
        blockquoteDecoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: Theme.of(context).accentColor,
              width: 2,
            ),
          ),
        ),
      ),
      syntaxHighlighter: Hightlight(context),
    );
  }
}

class Hightlight extends SyntaxHighlighter {
  final BuildContext context;

  Hightlight(this.context);
  @override
  TextSpan format(String source) {
    return TextSpan(
      style: TextStyle(
        height: 1.2,
        color: Theme.of(context).textTheme.caption.color,
      ),
      text: source,
    );
  }
}
