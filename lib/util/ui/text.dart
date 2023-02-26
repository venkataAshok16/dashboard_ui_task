import 'package:flutter/material.dart';

enum TextTypes { text, richText }

class UTILText extends StatelessWidget {
  final String text;
  final TextTypes textType;
  final TextAlign? textAlign;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final TextDirection? textDirection;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final int? maxLines;
  final double? wordSpacing;
  final double? letterSpacing;
  final List<InlineSpan>? children;
  final TextStyle? style;
  final String? linkTxt;
  final TextDecoration? decoration;

  final Function? regOnTap;
  final Function(String)? textClickEvent;

  const UTILText(this.text,
      {Key? key,
      this.textType = TextTypes.text,
      this.textAlign,
      this.color,
      this.fontSize,
      this.fontWeight,
      this.fontStyle,
      this.textDirection,
      this.softWrap,
      this.overflow,
      this.textScaleFactor,
      this.maxLines,
      this.wordSpacing,
      this.letterSpacing,
      this.style,
      this.linkTxt,
      this.decoration,
      this.regOnTap,
      this.textClickEvent,
      this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (textType) {
      case TextTypes.text:
        return getText();

      case TextTypes.richText:
        return richText(context);

      default:
        return getText();
    }
  }

  Widget getText() {
    return Text(
      text,
      textAlign: textAlign,
      textScaleFactor: textScaleFactor,
      maxLines: maxLines,
      softWrap: softWrap,
      textDirection: textDirection,
      overflow: overflow,
      style: getTextStyle(),
    );
  }

  Widget richText(BuildContext context) {
    return RichText(
      text: TextSpan(
          style: Theme.of(context).textTheme.headline5?.copyWith(fontSize: fontSize),
          children: (children == null) ? ([TextSpan(text: text)]) : [TextSpan(text: text)]
            ..addAll(children ?? [])),
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.clip,
      textDirection: textDirection,
      textScaleFactor: textScaleFactor ?? 1.0,
      softWrap: softWrap ?? true,
    );
  }

  TextStyle? getTextStyle() {
    if (style != null) {
      return style;
    } else {
      return TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        wordSpacing: wordSpacing,
        letterSpacing: letterSpacing,
        decoration: decoration,
        // shadows: (decoration != null) ? const [Shadow(offset: Offset(0, -20), color: Colors.black)] : null,
      );
    }
  }
}
