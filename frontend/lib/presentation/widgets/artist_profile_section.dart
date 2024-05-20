import 'package:flutter/material.dart';
import '../../data/artist_data.dart';

class ArtistProfileSection extends StatelessWidget {
  const ArtistProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    String artistName = artistData.last.name;

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
              image: const DecorationImage(
                image:
                    AssetImage('assets/sample_profile_picture/weyes_blood.jpg'),
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
