import 'package:flutter/material.dart';
import 'package:masinqo/presentation/widgets/admin_header.dart';
import '../widgets/delete_confirmation_modal.dart';
import '../../data/artist_data.dart'; 

class AdminArtistMGT extends StatefulWidget {
  const AdminArtistMGT({Key? key}) : super(key: key);

  @override
  _AdminArtistMGTState createState() => _AdminArtistMGTState();
}

class _AdminArtistMGTState extends State<AdminArtistMGT> {
  final Map<int, bool> _isBlocked = {};

  void _showDeleteConfirmationDialog(BuildContext context, String title, String content, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteConfirmationDialog(
          title: title,
          content: content,
          onConfirm: onConfirm,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AdminHeader(),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Text(
                'Artists',
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: artistData.length,
                itemBuilder: (context, index) {
                  final artist = artistData[index];
                  final isBlocked = _isBlocked[index] ?? false;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 50, 
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 48,
                                backgroundImage: AssetImage(artist.profilePicture),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    artist.name,
                                    style: const TextStyle(color: Colors.white, fontSize: 18),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    artist.email,
                                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Spacer(),
                                      TextButton.icon(
                                        style: TextButton.styleFrom(
                                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                                          minimumSize: Size(0, 0),
                                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        ),
                                        icon: Icon(
                                          isBlocked ? Icons.circle_outlined : Icons.block,
                                          color: isBlocked ? Color.fromARGB(211, 41, 251, 48) : Colors.yellow,
                                        ),
                                        label: Text(
                                          isBlocked ? 'Ban' : 'UnBan',
                                          style: const TextStyle(color: Colors.white, fontSize: 12),
                                        ),
                                        onPressed: () {
                                          String title = isBlocked ? 'Are you sure you want to ban this artist?' : 'Are you sure you want to unban this artist?';
                                          String content = isBlocked ? 'This action will restrict the artist from accessing the platform.' : 'This action will allow the artist to access the platform.';
                                          _showDeleteConfirmationDialog(
                                            context,
                                            title,
                                            content,
                                            () {
                                              setState(() {
                                                _isBlocked[index] = !isBlocked;
                                              });
                                            },
                                          );
                                        },
                                      ),
                                      const SizedBox(width: 8),
                                      TextButton.icon(
                                        style: TextButton.styleFrom(
                                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                                          minimumSize: Size(0, 0),
                                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        ),
                                        icon: const Icon(Icons.delete, color: Colors.red),
                                        label: const Text(
                                          'Delete',
                                          style: TextStyle(color: Colors.white, fontSize: 12),
                                        ),
                                        onPressed: () {
                                          _showDeleteConfirmationDialog(
                                            context,
                                            'Are you sure you want to delete this artist?',
                                            'This action will remove all of their information including their albums and songs.',
                                            () {
                                             
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Divider(color: Colors.grey),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
