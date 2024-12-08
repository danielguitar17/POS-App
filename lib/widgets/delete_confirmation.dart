import 'package:fluent_ui/fluent_ui.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const DeleteConfirmationDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.onConfirm,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: Text(
        title,
        style: FluentTheme.of(context).typography.subtitle,
      ),
      content: Text(
        content,
        style: FluentTheme.of(context).typography.body,
      ),
      actions: [
        Button(
          child: const Text('Cancel'),
          onPressed: onCancel,
        ),
        FilledButton(
          child: const Text('Delete'),
          onPressed: onConfirm,
          style: ButtonStyle(
            backgroundColor: ButtonState.resolveWith((states) => Colors.red),
            foregroundColor: ButtonState.resolveWith((states) => Colors.white),
          ),
        ),
      ],
    );
  }
}
