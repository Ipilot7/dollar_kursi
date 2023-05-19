abstract class AppAssets {
  AppAssets._();

  static AppIcons get icons => AppIcons();

  static AppImages get images => AppImages();
}

abstract class AssetsFolder {
  final String basePath;

  AssetsFolder(this.basePath);
}

class AppIcons extends AssetsFolder {
  AppIcons() : super('assets/icons');

  String get search => '$basePath/ic-search.svg';
  String get drawer => '$basePath/ic-drawer.svg';
  String get back => '$basePath/ic-back.svg';
  String get more => '$basePath/ic-more.svg';
  // Top Bar Icons

  String get notifications => '$basePath/ic-notifications.svg';
  String get appereance => '$basePath/ic-appearance.svg';
  String get privacy => '$basePath/ic-privacy.svg';
  String get about => '$basePath/ic-about.svg';
  // Settings Section Icons

  String get settingsFilled => '$basePath/ic-settings-filled.svg';
  String get homeFilled => '$basePath/ic-home-filled.svg';
  String get settings => '$basePath/ic-settings.svg';
  String get home => '$basePath/ic-home.svg';
  // Navigation Bar Icons

  String get filter => '$basePath/ic-filter.svg';
  String get dollar => '$basePath/ic-dollar.svg';
  String get down => '$basePath/ic-down.svg';
  String get up => '$basePath/ic-up.svg';
  // Home Screen Icons

  String get circle => '$basePath/ic-circle.svg';
  // Drawer Icons
}

class AppImages extends AssetsFolder {
  AppImages() : super('assets/images');

  String get bank1 => '$basePath/bank-1.png';
  String get bank2 => '$basePath/bank-2.png';
  String get bank3 => '$basePath/bank-3.png';
  String get bank4 => '$basePath/bank-4.png';
  String get bank5 => '$basePath/bank-5.png';
  String get bank6 => '$basePath/bank-6.png';
  String get bank7 => '$basePath/bank-7.png';
  String get bank8 => '$basePath/bank-8.png';
  String get bank9 => '$basePath/bank-9.png';
  String get bank10 => '$basePath/bank-10.png';
  String get bank11 => '$basePath/bank-11.png';
  String get bank12 => '$basePath/bank-12.png';
  String get bank13 => '$basePath/bank-13.png';
  String get bank14 => '$basePath/bank-14.png';
  String get bank15 => '$basePath/bank-15.png';
  String get bank16 => '$basePath/bank-16.png';
  String get bank17 => '$basePath/bank-17.png';
  String get bank18 => '$basePath/bank-18.png';
  String get bank19 => '$basePath/bank-19.png';
  // Bank Photos
}
