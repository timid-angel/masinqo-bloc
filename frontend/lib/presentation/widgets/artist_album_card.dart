import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:masinqo/models/albums.dart';
import '../../data/artist_data.dart';

class AlbumCard extends StatelessWidget {
  const AlbumCard({
    super.key,
    required this.album,
  });

  final Album album;

  @override
  Widget build(BuildContext context) {
    String artistName = artistData.last.name;
    double deviceWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          "/artist/album",
          arguments: album,
        );
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
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(album.albumArt),
                    ),
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
                  child: _buildDetailsColumn(artistName),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailsColumn(String artistName) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildText('', _truncateText(album.title, 25),
              fontSize: 20, fontWeight: FontWeight.bold),
          const SizedBox(height: 5),
          _buildText('Tracks:', album.songs.length.toString()),
          const SizedBox(height: 5),
          _buildText('Genre:', _truncateText(album.genre, 14)),
          const SizedBox(height: 5),
          _buildText('Release Date:',
              "${DateFormat('MMMM').format(DateTime(0, album.date.month)).toString().substring(0, 3)}. ${album.date.day.toString()}, ${album.date.year.toString()}"),
          const SizedBox(height: 5),
          _buildDescriptionText(
              'Description:', _truncateText(album.description, 55)),
        ],
      ),
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
