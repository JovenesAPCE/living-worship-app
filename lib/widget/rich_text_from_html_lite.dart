import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jamt/constants/constants.dart';

class RichTextFromHtmlLite extends StatelessWidget {
  final String html;
  final TextStyle? currentStyle;
  final void Function(String href)? onTapLink;

  const RichTextFromHtmlLite(this.html, {super.key, this.currentStyle, this.onTapLink,});

  @override
  Widget build(BuildContext context) {
    final RegExp tagExp = RegExp(r"<(\/?)(a|b|p|li|ul)([^>]*)>");
    final List<InlineSpan> spans = [];
    final buffer = StringBuffer();
    TextStyle? currentStyle = this.currentStyle;
    currentStyle ??= TextStyle(
          color: AppColor.textGrey,
          fontSize: 13,
          height: 1.8,
          fontFamily: AppFont.font,
          fontWeight: FontWeight.w500,
      );

    String? currentHref;
    bool bold = false;
    bool isInListItem = false;

    void flushBuffer() {
      if (buffer.isEmpty) return;

      final text = buffer.toString();
      TextStyle effectiveStyle = currentStyle!.copyWith(
        fontWeight: bold ? FontWeight.bold : null,
        color: currentHref != null ? AppColor.blueLight : currentStyle!.color,
      );


      if (isInListItem) {
        // Aplicamos sangría al li
        effectiveStyle = effectiveStyle.copyWith(
          height: 1.6,
        );
        spans.add(
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "• ",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                Expanded(
                  child: Text(
                    text,
                    style: effectiveStyle,
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        final href = currentHref;
        spans.add(TextSpan(
          text: text,
          style: effectiveStyle,
          recognizer: href != null
              ? (TapGestureRecognizer()
            ..onTap = () {
              if (onTapLink != null) {
                onTapLink!(href);
              }
            })
              : null,
        ));
      }

      buffer.clear();
    }

    final tagMatches = tagExp.allMatches(html);
    int lastIndex = 0;

    for (final match in tagMatches) {
      final textSegment = html.substring(lastIndex, match.start);
      buffer.write(textSegment);
      flushBuffer();

      final isClosing = match.group(1) == "/";
      final tag = match.group(2);
      final attributes = match.group(3);

      if (tag == "a") {
        if (isClosing) {
          currentHref = null;
        } else {
          final hrefMatch = RegExp(r"href='([^']+)'").firstMatch(attributes ?? "");
          if (hrefMatch != null) {
            currentHref = hrefMatch.group(1);
          }
        }
      } else if (tag == "b") {
        bold = !isClosing;
      } else if (tag == "p") {
        if (!isClosing) {
          buffer.write("");
        } else {
          buffer.write("\n");
        }
      } else if (tag == "li") {
        if (!isClosing) {
          isInListItem = true;
        } else {
          isInListItem = false;
          buffer.write("\n");
        }
      }else if (tag == "ul") {
        if (!isClosing) {
          buffer.write("");
        } else {
          buffer.write("");
        }
      }

      lastIndex = match.end;
    }

    buffer.write(html.substring(lastIndex));
    flushBuffer();

    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(children: spans),
    );
  }

}
