import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:sonic_mobile/core/core.dart';


class ReadMore extends StatefulWidget {
  const ReadMore({
    Key? key,
    required this.data,
    this.trimLines = 4,
    this.trimExpandedText = 'Read Less',
    this.trimCollapsedText = 'Read More',
    this.style,
  }) : super(key: key);

  final String data;
  final int trimLines;
  final String trimExpandedText;
  final String trimCollapsedText;
  final TextStyle? style;

  final TextAlign? textAlign = TextAlign.start;
  final String delimiter = '${Constants.kEllipsis} ';
  final double? textScaleFactor = 0.0;
  final Color? colorClickableText = Colors.blue;

  @override
  State<ReadMore> createState() => _ReadMoreState();
}

class _ReadMoreState extends State<ReadMore> {
  bool _readMore = true;

  void _onTapLink() {
    setState(() {
      _readMore = !_readMore;
    });
  }

  @override
  Widget build(BuildContext context) {
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    TextStyle? effectiveTextStyle = widget.style;
    if (widget.style?.inherit ?? false) {
      effectiveTextStyle = defaultTextStyle.style.merge(widget.style);
    }

    TextSpan toggleLink = TextSpan(
      text: _readMore ? widget.trimCollapsedText : widget.trimExpandedText,
      style: effectiveTextStyle?.copyWith(color: widget.colorClickableText),
      recognizer: TapGestureRecognizer()..onTap = _onTapLink,
    );

    TextSpan delimiter = TextSpan(
      text: _readMore ? widget.delimiter : '',
      style: effectiveTextStyle?.copyWith(color: widget.colorClickableText),
      recognizer: TapGestureRecognizer()..onTap = _onTapLink,
    );

    Widget result = LayoutBuilder(
        builder: (BuildContext context, BoxConstraints boxConstraints) {
          assert(boxConstraints.hasBoundedWidth);
          final double maxWidth = boxConstraints.maxWidth;

          final text = TextSpan(
            text: widget.data,
            style: effectiveTextStyle,
          );

          TextPainter textPainter = TextPainter(
              text: toggleLink,
              maxLines: widget.trimLines,
              textDirection: Directionality.of(context),
              ellipsis: widget.delimiter);

          textPainter.layout(minWidth: 0, maxWidth: maxWidth);
          final toggleLinkSize = textPainter.size;
          textPainter.text = delimiter;
          textPainter.layout(minWidth: 0, maxWidth: maxWidth);
          final delimiterSize = textPainter.size;
          textPainter.text = text;
          textPainter.layout(minWidth: boxConstraints.minWidth, maxWidth: maxWidth);
          final textSize = textPainter.size;

          bool toggleLinkLongerThanLine = false;
          int endIndex;

          if (toggleLinkSize.width < maxWidth) {
            final readMoreSize = toggleLinkSize.width + delimiterSize.width;
            final pos = textPainter.getPositionForOffset(Offset(
              Directionality.of(context) == TextDirection.rtl
                  ? readMoreSize
                  : textSize.width - readMoreSize,
              textSize.height,
            ));
            endIndex = textPainter.getOffsetBefore(pos.offset) ?? 0;
          } else {
            var pos = textPainter.getPositionForOffset(
              textSize.bottomLeft(Offset.zero),
            );
            endIndex = pos.offset;
            toggleLinkLongerThanLine = true;
          }

          TextSpan textSpan = (textPainter.didExceedMaxLines)
              ? TextSpan(
            style: effectiveTextStyle,
            text: _readMore
                ? widget.data.substring(0, endIndex) +
                (toggleLinkLongerThanLine ? Constants.kLineSeparator : '')
                : widget.data,
            children: <TextSpan>[delimiter, toggleLink],
          )
              : TextSpan(
            text: widget.data,
            style: effectiveTextStyle,
          );

          return Text.rich(
            textSpan,
            softWrap: true,
            overflow: TextOverflow.clip,
          );
        });

    return result;
  }
}