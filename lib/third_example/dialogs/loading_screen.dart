class LoadingScreen {
  // singleton pattern
  LoadingScreen._sharedInstance();
  static late final LoadingScreen _shared = LoadingScreen._sharedInstance();
  factory LoadingScreen.instance() => _shared;
}
