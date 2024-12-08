import 'package:fluent_ui/fluent_ui.dart';

Future<void> displayError(BuildContext context, String title, String msg) {
  return displayInfoBar(context, builder: (context, close) {
    return InfoBar(
      title: Text(title),
      content: Text(msg),
      action: IconButton(
        icon: const Icon(FluentIcons.clear),
        onPressed: close,
      ),
      severity: InfoBarSeverity.warning,
    );
  });
}

Future<void> displaySucces(BuildContext context, String message) {
  return displayInfoBar(context, builder: (context, close) {
    return InfoBar(
      title: const Text('Completado :D'),
      content: Text(message),
      action: IconButton(
        icon: const Icon(FluentIcons.clear),
        onPressed: close,
      ),
      severity: InfoBarSeverity.success,
    );
  });
}
