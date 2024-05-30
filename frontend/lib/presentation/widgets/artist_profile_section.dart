import 'package:flutter/material.dart';
import 'package:masinqo/infrastructure/core/url.dart';

class ArtistProfileSection extends StatelessWidget {
  final String artistName;
  final String profilePicture;
  const ArtistProfileSection(
      {super.key, required this.artistName, required this.profilePicture});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10),
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF39DCF3), width: 4),
              image: DecorationImage(
                image: NetworkImage('${Domain.url}/$profilePicture'),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            artistName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFFC5F8FF),
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          const Text(
            'Your Albums',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 27,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
