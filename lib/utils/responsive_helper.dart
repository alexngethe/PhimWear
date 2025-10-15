class ResponsiveHelper {
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;
  static const double desktopBreakpoint = 1200;

  static int getGridColumns(double width) {
    if (width < mobileBreakpoint) {
      return 2;
    } else if (width < tabletBreakpoint) {
      return 3;
    } else if (width < desktopBreakpoint) {
      return 4;
    } else {
      return 5;
    }
  }

  static bool isMobile(double width) => width < mobileBreakpoint;
  static bool isTablet(double width) => width >= mobileBreakpoint && width < desktopBreakpoint;
  static bool isDesktop(double width) => width >= desktopBreakpoint;
}
