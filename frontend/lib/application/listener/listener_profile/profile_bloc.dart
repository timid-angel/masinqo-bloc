import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masinqo/application/listener/listener_profile/profile_events.dart';
import 'package:masinqo/application/listener/listener_profile/profile_state.dart';
import 'package:masinqo/domain/listener/listener_profile.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ListenerProfileCollection profileRepository;

  ProfileBloc({required this.profileRepository}) : super(EmptyProfile()) {
    on<FetchProfile>((event, emit) async {
      try {
        final profile = await profileRepository.getProfile(event.token);
        emit(LoadedProfile(profile));
      } catch (e) {
        emit(ErrorProfile(e.toString()));
      }
    });

    on<EditProfile>((event, emit) async {
      try {
        final profile = await profileRepository.editProfile(
            event.token, event.name, event.email, event.password);
        emit(LoadedProfile(profile));
      } catch (e) {
        emit(ErrorProfile(e.toString()));
      }
    });
  }
}
