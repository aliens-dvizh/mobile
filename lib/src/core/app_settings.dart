class AppSettings {
  AppSettings({required bool useMocks}) : _useMocks = useMocks;

  final bool _useMocks;

  bool get useMocks => _useMocks;
}
