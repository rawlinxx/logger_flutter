part of logger_flutter;

class LogConsoleOnShake extends StatefulWidget {
  final Widget child;
  final bool dark;
  final bool debugOnly;
  static bool darkMode;

  LogConsoleOnShake({
    @required this.child,
    this.dark = true,
    this.debugOnly = true,
  }) {
    LogConsoleOnShake.darkMode = dark;
  }

  @override
  LogConsoleOnShakeState createState() => LogConsoleOnShakeState();
}

class LogConsoleOnShakeState extends State<LogConsoleOnShake> {
  static bool _open = false;

  @override
  void initState() {
    super.initState();

    if (widget.debugOnly) {
      assert(() {
        _init();
        return true;
      }());
    } else {
      _init();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  _init() {
    LogConsole.init();
  }

  static openLogConsole(BuildContext context) async {
    if (_open) return;

    _open = true;

    var logConsole = LogConsole(
      showCloseButton: true,
      dark: LogConsoleOnShake.darkMode ??
          Theme.of(context).brightness == Brightness.dark,
    );
    PageRoute route;
    if (Platform.isIOS) {
      route = CupertinoPageRoute(builder: (_) => logConsole);
    } else {
      route = MaterialPageRoute(builder: (_) => logConsole);
    }

    await Navigator.push(context, route);
    _open = false;
  }
}
