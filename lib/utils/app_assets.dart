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

  String get sortAlphabet => '$basePath/ic-alphabet.svg';
  String get sortDown => '$basePath/ic-sort-down.svg';
  String get sortUp => '$basePath/ic-sort-up.svg';
  //Sort Section Icons
}

class AppImages extends AssetsFolder {
  AppImages() : super('assets/images');
}
