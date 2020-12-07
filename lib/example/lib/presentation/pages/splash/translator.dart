import 'package:flutter/material.dart';
import 'package:BLOOM_BETA/example/lib/utils/localization_helper/app_localizations.dart';

/// Extension to translate [Strings] easily
extension StringTranslator on String {
  /// method can be called using any [String] value
  String tr() {
    return AppLocalizations.instance.translate(this);
  }
}

/// Extension to translate [Strings] easily
extension TextStringTranslator on Text {
  /// method can be called using any [Text] value
  Text tr() {
    return Text(
      data.tr(),
      key: key,
      style: style,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
    );
  }
}
