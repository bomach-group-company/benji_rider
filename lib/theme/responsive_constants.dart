const double laptopSize = 992;
const double tabletSize = 768;
const double mobileSize = 576;

const double laptopContainer = 50;
const double tabletContainer = 50;
const double mobileContainer = 25;

double breakPoint(double size, double mobile, double tablet, double laptop) {
  if (size <= mobileSize) {
    return mobile;
  } else if (size <= laptopSize) {
    return tablet;
  } else {
    return laptop;
  }
}

dynamic breakPointDynamic(
    dynamic size, dynamic mobile, dynamic tablet, dynamic laptop) {
  if (size <= mobileSize) {
    return mobile;
  } else if (size <= laptopSize) {
    return tablet;
  } else {
    return laptop;
  }
}

dynamic deviceType(dynamic size) {
  if (size <= mobileSize) {
    return 1;
  } else if (size <= laptopSize) {
    return 2;
  } else {
    return 3;
  }
}
