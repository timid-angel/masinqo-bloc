import 'package:masinqo/core.dart';

class AdminFailure implements Failure {
  @override
  final String message;

  AdminFailure({required this.message});
}
