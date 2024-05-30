import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:masinqo/application/artists/album/album_bloc.dart';
import 'package:masinqo/application/artists/album/album_state.dart';
import 'package:masinqo/application/artists/home_page/artist_home_bloc.dart';
import 'package:masinqo/infrastructure/core/url.dart';

class BlocTransferObject {
  final ArtistHomeBloc artistHomeBloc;
  final AlbumBloc albumBloc;

  BlocTransferObject({required this.artistHomeBloc, required this.albumBloc});
}

class AlbumCard extends StatelessWidget {
  const AlbumCard({
    super.key,
    required this.album,
    required this.token,
    required this.artistHomeBloc,
  });

  final AlbumState album;
  final String token;
  final ArtistHomeBloc artistHomeBloc;

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => AlbumBloc(token: token, album: album),
      child: BlocBuilder<AlbumBloc, AlbumState>(builder: (context, state) {
        return GestureDetector(
          onTap: () {
            context.pushNamed("artist_album",
                extra: BlocTransferObject(
                    albumBloc: BlocProvider.of<AlbumBloc>(context),
                    artistHomeBloc: artistHomeBloc));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Card(
              color: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(
                  color: Color(0xFF39DCF3),
                  width: 1,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: deviceWidth * 0.5,
                      height: deviceWidth * 0.5,
                      decoration: BoxDecoration(
                        image: album.albumArt.isNotEmpty
                            ? DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    "${Domain.url}/${state.albumArt}"))
                            : null,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildText('', _truncateText(state.title, 25),
                                fontSize: 20, fontWeight: FontWeight.bold),
                            const SizedBox(height: 5),
                            _buildText(
                                'Tracks:', state.songs.length.toString()),
                            const SizedBox(height: 5),
                            _buildText(
                                'Genre:', _truncateText(state.genre, 14)),
                            const SizedBox(height: 5),
                            _buildText('Release Date:',
                                "${DateFormat('MMMM').format(DateTime(0, state.date.month)).toString().substring(0, 3)}. ${state.date.day.toString()}, ${state.date.year.toString()}"),
                            const SizedBox(height: 5),
                            _buildDescriptionText('Description:',
                                _truncateText(state.description, 55)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  String _truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  Widget _buildText(String label, String value,
      {Color? color, double? fontSize, FontWeight? fontWeight}) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF39DCF3),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: SizedBox(
            width: double.infinity,
            child: Text(
              value,
              style: TextStyle(
                fontSize: fontSize ?? 14,
                color: color ?? Colors.white,
                fontWeight: fontWeight,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionText(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF39DCF3),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
