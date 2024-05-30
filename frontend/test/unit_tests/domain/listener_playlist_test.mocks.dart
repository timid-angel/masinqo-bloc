// Mocks generated by Mockito 5.4.4 from annotations
// in masinqo/test/unit_tests/domain/listener_playlist_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:masinqo/domain/entities/playlist.dart' as _i5;
import 'package:masinqo/infrastructure/listener/listener_playlist/listener_playlist_repository.dart'
    as _i6;
import 'package:masinqo/infrastructure/listener/listener_playlist/listener_playlist_service.dart'
    as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeListenerPlaylistService_0 extends _i1.SmartFake
    implements _i2.ListenerPlaylistService {
  _FakeListenerPlaylistService_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ListenerPlaylistService].
///
/// See the documentation for Mockito's code generation for more information.
class MockListenerPlaylistService extends _i1.Mock
    implements _i2.ListenerPlaylistService {
  MockListenerPlaylistService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get baseUrl => (super.noSuchMethod(
        Invocation.getter(#baseUrl),
        returnValue: _i3.dummyValue<String>(
          this,
          Invocation.getter(#baseUrl),
        ),
      ) as String);

  @override
  _i4.Future<List<_i5.Playlist>> getPlaylists(String? token) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPlaylists,
          [token],
        ),
        returnValue: _i4.Future<List<_i5.Playlist>>.value(<_i5.Playlist>[]),
      ) as _i4.Future<List<_i5.Playlist>>);

  @override
  _i4.Future<void> addPlaylist(
    String? playlistName,
    String? token,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #addPlaylist,
          [
            playlistName,
            token,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> editPlaylist(
    String? id,
    String? name,
    String? token,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #editPlaylist,
          [
            id,
            name,
            token,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}

/// A class which mocks [ListenerPlaylistRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockListenerPlaylistRepository extends _i1.Mock
    implements _i6.ListenerPlaylistRepository {
  MockListenerPlaylistRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.ListenerPlaylistService get listenerPlaylistService =>
      (super.noSuchMethod(
        Invocation.getter(#listenerPlaylistService),
        returnValue: _FakeListenerPlaylistService_0(
          this,
          Invocation.getter(#listenerPlaylistService),
        ),
      ) as _i2.ListenerPlaylistService);

  @override
  _i4.Future<List<_i5.Playlist>> getPlaylists(String? token) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPlaylists,
          [token],
        ),
        returnValue: _i4.Future<List<_i5.Playlist>>.value(<_i5.Playlist>[]),
      ) as _i4.Future<List<_i5.Playlist>>);

  @override
  _i4.Future<void> addPlaylist(
    String? playlistName,
    String? token,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #addPlaylist,
          [
            playlistName,
            token,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> editPlaylist(
    String? id,
    String? name,
    String? token,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #editPlaylist,
          [
            id,
            name,
            token,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}