// import 'package:flutter/material.dart';
//
// class XDecorations {
//   /// Decorator for fields with no icons.
//   ///
//   static InputDecoration defaultInputDecorator(
//     BuildContext context, {
//     required String hint,
//     bool enabled = true,
//     bool alignLabelWithHint = true,
//     double? textSize,
//     double? smallTextSize,
//     double? borderWidth,
//     double? focusedBorderWidth,
//     double? radius,
//     FontWeight? textWeight,
//     FontWeight? hintWeight,
//     BorderRadius? borderRadius,
//     // Text Colors
//     Color? textColor,
//     Color? errorColor,
//     Color? disabledColor,
//     Color? hintColor,
//     Color? fillColor,
//     // Border Colors
//     Color? borderColor,
//     Color? errorBorderColor,
//     Color? disabledBorderColor,
//     EdgeInsetsGeometry? contentPadding,
//   }) {
//     double bRadius = radius ?? 12.0;
//
//     /// BIV NORMAL DECORATOR
//     return InputDecoration(
//       labelText: alignLabelWithHint ? hint : null,
//       hintText: alignLabelWithHint ? null : hint,
//       enabled: enabled,
//       alignLabelWithHint: alignLabelWithHint,
//       contentPadding: contentPadding ??
//           const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
//       fillColor: fillColor,
//       filled: fillColor != null,
//       counter: const SizedBox(),
//       // Text Styles
//       labelStyle: TextStyle(
//         color: hintColor ?? borderColor ?? textColor?.withAlpha(120),
//         fontSize: textSize ?? 13,
//         fontWeight: textWeight ?? FontWeight.w500,
//       ),
//       errorStyle: TextStyle(
//         color: errorColor ?? Colors.red,
//         fontSize: smallTextSize ?? 10.0,
//         fontWeight: textWeight ?? FontWeight.w500,
//       ),
//       hintStyle: TextStyle(
//         color: hintColor ?? borderColor ?? textColor?.withAlpha(120),
//         fontSize: textSize ?? 12.0,
//         fontWeight: hintWeight,
//       ),
//       counterStyle: TextStyle(
//         color: textColor,
//         fontSize: smallTextSize ?? 10.0,
//         fontWeight: textWeight ?? FontWeight.w500,
//       ),
//       // Border Styles
//       border: OutlineInputBorder(
//         borderRadius:
//             borderRadius ?? BorderRadius.all(Radius.circular(bRadius)),
//         borderSide: BorderSide(
//           color:
//               borderColor ?? textColor ?? Theme.of(context).colorScheme.primary,
//           width: borderWidth ?? 1,
//         ),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius:
//             borderRadius ?? BorderRadius.all(Radius.circular(bRadius)),
//         borderSide: BorderSide(
//           color:
//               borderColor ?? textColor ?? Theme.of(context).colorScheme.primary,
//           width: focusedBorderWidth ?? borderWidth ?? 1.5,
//         ),
//       ),
//       disabledBorder: OutlineInputBorder(
//         borderRadius:
//             borderRadius ?? BorderRadius.all(Radius.circular(bRadius)),
//         borderSide: BorderSide(
//           color: (borderColor ??
//                   textColor ??
//                   Theme.of(context).colorScheme.primary)
//               .withAlpha(120),
//           width: borderWidth ?? 1,
//         ),
//       ),
//       errorBorder: OutlineInputBorder(
//         borderRadius:
//             borderRadius ?? BorderRadius.all(Radius.circular(bRadius)),
//         borderSide: BorderSide(
//           color: errorBorderColor ??
//               errorColor ??
//               Theme.of(context).colorScheme.error,
//           width: borderWidth ?? 1,
//         ),
//       ),
//       focusedErrorBorder: OutlineInputBorder(
//         borderRadius:
//             borderRadius ?? BorderRadius.all(Radius.circular(bRadius)),
//         borderSide: BorderSide(
//           color: errorBorderColor ??
//               errorColor ??
//               Theme.of(context).colorScheme.error,
//           width: focusedBorderWidth ?? borderWidth ?? 1.5,
//         ),
//       ),
//     );
//   }

  // static InputDecoration trailingIconInputDecorator({
  //   required String hint,
  //   required IconData icon,
  //   bool enabled = true,
  //   bool alignLabelWithHint = true,
  //   double? textSize,
  //   double? smallTextSize,
  //   double? borderWidth,
  //   double? focusedBorderWidth,
  //   double? radius,
  //   FontWeight? textWeight,
  //   FontWeight? hintWeight,
  //   BorderRadius? borderRadius,
  //   // Icon Colors
  //   Color? iconColor,
  //   // Text Colors
  //   Color? textColor,
  //   Color? errorColor,
  //   Color? disabledColor,
  //   Color? hintColor,
  //   Color? fillColor,
  //   // Border Colors
  //   Color? borderColor,
  //   Color? errorBorderColor,
  //   Color? disabledBorderColor,
  //   EdgeInsetsGeometry? contentPadding,
  //   // Callbacks
  //   VoidCallback? onIconPressed,
  // }) {
  //   double bRadius = radius ?? 12.0;
  //
  //   /// BIV NORMAL DECORATOR
  //   return InputDecoration(
  //     labelText: alignLabelWithHint ? hint : null,
  //     hintText: alignLabelWithHint ? null : hint,
  //     enabled: enabled,
  //     alignLabelWithHint: alignLabelWithHint,
  //     contentPadding: contentPadding ??
  //         const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
  //     fillColor: fillColor,
  //     filled: fillColor != null,
  //     // Icon Styles
  //     suffixIcon: IconButton(
  //       onPressed: onIconPressed,
  //       icon: Icon(icon),
  //       color: iconColor,
  //     ),
  //
  //     // Text Styles
  //     labelStyle: XTheme.defaultFont(
  //       color: hintColor ??
  //           borderColor ??
  //           textColor?.withAlpha(120) ??
  //           XTheme.labelColor.withAlpha(120),
  //       fontSize: textSize ?? 13,
  //       fontWeight: textWeight ?? FontWeight.w500,
  //     ),
  //     errorStyle: XTheme.defaultFont(
  //       color: errorColor ?? Colors.red,
  //       fontSize: smallTextSize ?? 10.0,
  //       fontWeight: textWeight,
  //     ),
  //     hintStyle: XTheme.defaultFont(
  //       color: hintColor ??
  //           borderColor ??
  //           textColor?.withAlpha(120) ??
  //           XTheme.labelColor.withAlpha(120),
  //       fontSize: textSize ?? 12.0,
  //       fontWeight: hintWeight,
  //     ),
  //     counterStyle: XTheme.defaultFont(
  //       color: textColor ?? XTheme.labelColor,
  //       fontSize: smallTextSize ?? 10.0,
  //       fontWeight: textWeight,
  //     ),
  //     // Border Styles
  //     enabledBorder: OutlineInputBorder(
  //       borderRadius:
  //           borderRadius ?? BorderRadius.all(Radius.circular(bRadius)),
  //       borderSide: BorderSide(
  //         color: borderColor ?? textColor ?? XTheme.labelColor.withAlpha(150),
  //         width: borderWidth ?? 1,
  //       ),
  //     ),
  //     focusedBorder: OutlineInputBorder(
  //       borderRadius:
  //           borderRadius ?? BorderRadius.all(Radius.circular(bRadius)),
  //       borderSide: BorderSide(
  //         color: borderColor ?? textColor ?? XTheme.labelColor,
  //         width: focusedBorderWidth ?? borderWidth ?? 1.5,
  //       ),
  //     ),
  //     disabledBorder: OutlineInputBorder(
  //       borderRadius:
  //           borderRadius ?? BorderRadius.all(Radius.circular(bRadius)),
  //       borderSide: BorderSide(
  //         color: borderColor?.withAlpha(120) ??
  //             textColor?.withAlpha(120) ??
  //             XTheme.labelColor.withAlpha(120),
  //         width: borderWidth ?? 1,
  //       ),
  //     ),
  //     errorBorder: OutlineInputBorder(
  //       borderRadius:
  //           borderRadius ?? BorderRadius.all(Radius.circular(bRadius)),
  //       borderSide: BorderSide(
  //         color: errorBorderColor ?? errorColor ?? Colors.red,
  //         width: borderWidth ?? 1,
  //       ),
  //     ),
  //     focusedErrorBorder: OutlineInputBorder(
  //       borderRadius:
  //           borderRadius ?? BorderRadius.all(Radius.circular(bRadius)),
  //       borderSide: BorderSide(
  //         color: errorBorderColor ?? errorColor ?? Colors.red,
  //         width: focusedBorderWidth ?? borderWidth ?? 1.5,
  //       ),
  //     ),
  //   );
  // }
// }
