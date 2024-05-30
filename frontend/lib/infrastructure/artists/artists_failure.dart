import 'package:masinqo/core.dart';

abstract class ArtistsFailureImpl implements Failure {}

class ArtistFailure extends ArtistsFailureImpl {
  @override
  final String message;

  ArtistFailure({required this.message});
}
