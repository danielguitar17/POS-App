import 'package:fluent_ui/fluent_ui.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

FluentThemeData darkTheme = FluentThemeData.dark().copyWith(
    accentColor: primaryblue,
    typography: Typography.raw(
        title: GoogleFonts.montserrat(fontSize: 28),
        display: GoogleFonts.roboto()),
    dialogTheme: ContentDialogThemeData(
        actionsDecoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10)),
            color: bgColor),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: secondaryColor)),
    scaffoldBackgroundColor: bgColor,
    navigationPaneTheme:
        const NavigationPaneThemeData(backgroundColor: secondaryColor));

FluentThemeData ligthTheme = FluentThemeData.light().copyWith(
    scaffoldBackgroundColor: bgColorL,
    navigationPaneTheme: NavigationPaneThemeData(
        tileColor: ButtonState.resolveWith((states) {
          if (states.isDisabled) {
            return Colors.blue;
          } else if (states.isHovering) {
            return amberColor;
          } else if (states.isFocused) {
            return amberColor;
          } else if (states.isPressing) {
            return amberColor;
          }
          return Colors.white;
        }),
        highlightColor: amberColor,
        backgroundColor: secondaryColorL));
