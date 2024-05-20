import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:masinqo/presentation/widgets/profile_mgmt-section_title.dart';
import 'dart:io';
import '../widgets/artist_drawer.dart';
import '../widgets/artist_app_bar.dart';
import '../../../data/artist_data.dart';

class ArtistProfile extends StatefulWidget {
  const ArtistProfile({super.key});

  @override
  ArtistProfileState createState() => ArtistProfileState();
}

class ArtistProfileState extends State<ArtistProfile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _profileImagePath = 'assets/sample_profile_picture/weyes_blood.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: ArtistAppBar(scaffoldKey: _scaffoldKey),
      endDrawer: const ArtistDrawer(),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: const Color(0xFF39DCF3), width: 4),
                    ),
                    child: ClipOval(
                      child: profilePicture(),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: IconButton(
                      icon: const Icon(Icons.edit, color: Color(0xFF39DCF3)),
                      onPressed: _pickProfileImage,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                artistData.last.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFFC5F8FF),
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              const SizedBox(height: 20),
              const SectionTitle(title: 'Change Username'),
              const RoundedInputField(placeholder: "Enter new username"),
              const RoundedInputField(placeholder: "Enter new Email"),
              const SizedBox(height: 20),
              const SectionTitle(title: 'Change Password'),
              const SizedBox(height: 10),
              const RoundedInputField(placeholder: "Enter new password"),
              const RoundedInputField(placeholder: "Confirm new Password"),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF39DCF3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 75),
            ],
          ),
        ),
      ),
    );
  }

  void _pickProfileImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null) {
      setState(() {
        _profileImagePath = result.files.single.path!;
      });
    }
  }

  Widget profilePicture() {
    if (_profileImagePath.startsWith('assets/')) {
      return Image.asset(
        _profileImagePath,
        fit: BoxFit.cover,
      );
    } else {
      return Image.file(
        File(_profileImagePath),
        fit: BoxFit.cover,
      );
    }
  }
}

class RoundedInputField extends StatelessWidget {
  final String placeholder;

  const RoundedInputField({super.key, required this.placeholder});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: 300,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: const Color(0xFF39DCF3), width: 1),
      ),
      child: TextField(
        style: const TextStyle(color: Colors.grey),
        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: const TextStyle(color: Colors.grey),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
