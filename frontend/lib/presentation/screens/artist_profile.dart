import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masinqo/application/artists/home_page/artist_home_bloc.dart';
import 'package:masinqo/application/artists/home_page/artist_home_event.dart';
import 'package:masinqo/application/artists/home_page/artist_home_state.dart';
import 'package:masinqo/infrastructure/core/url.dart';
import 'package:masinqo/presentation/core/theme/app_colors.dart';
import 'package:masinqo/presentation/widgets/profile_mgmt_section_title.dart';
import 'dart:io';
import '../widgets/artist_app_bar.dart';

class ArtistProfile extends StatefulWidget {
  final ArtistHomeBloc artistHomeBloc;
  const ArtistProfile({super.key, required this.artistHomeBloc});

  @override
  ArtistProfileState createState() => ArtistProfileState();
}

class ArtistProfileState extends State<ArtistProfile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _profileImagePath = 'assets/images/transparent.png';
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController =
        TextEditingController(text: widget.artistHomeBloc.state.name);
    emailController =
        TextEditingController(text: widget.artistHomeBloc.state.email);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.artistHomeBloc,
      child: BlocListener<ArtistHomeBloc, ArtistHomeState>(
        listener: (context, state) {
          if (state is ArtistHomeFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: const Color.fromARGB(255, 150, 53, 53),
              ),
            );
            widget.artistHomeBloc.add(CompletedEvent(errorState: state));
          } else if (state is ArtistHomeSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Successfully Updated Personal Information"),
                backgroundColor: AppColors.artist2,
              ),
            );
            widget.artistHomeBloc.add(CompletedEvent(errorState: state));
          }
        },
        child: Scaffold(
          key: _scaffoldKey,
          appBar: ArtistAppBar(scaffoldKey: _scaffoldKey),
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
                            border: Border.all(
                                color: const Color(0xFF39DCF3), width: 4),
                            image: DecorationImage(
                                image: NetworkImage(
                                    "${Domain.url}/${widget.artistHomeBloc.state.profilePicture}"))),
                        child: ClipOval(
                          child: profilePicture(),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: IconButton(
                          icon:
                              const Icon(Icons.edit, color: Color(0xFF39DCF3)),
                          onPressed: _pickProfileImage,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.artistHomeBloc.state.name,
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
                  RoundedInputField(
                    placeholder: "Enter new username",
                    controller: nameController,
                  ),
                  RoundedInputField(
                    placeholder: "Enter new Email",
                    controller: emailController,
                  ),
                  const SizedBox(height: 20),
                  const SectionTitle(title: 'Change Password'),
                  const SizedBox(height: 10),
                  RoundedInputField(
                    placeholder: "Enter new password",
                    controller: passwordController,
                  ),
                  RoundedInputField(
                    placeholder: "Confirm new Password",
                    controller: confirmPasswordController,
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      widget.artistHomeBloc.add(
                        UpdateArtistInformation(
                          name: nameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                          confirmPassword: confirmPasswordController.text,
                          profilePictureFilePath: _profileImagePath !=
                                  'assets/images/transparent.png'
                              ? _profileImagePath
                              : "",
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF39DCF3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 5),
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
    if (_profileImagePath.isEmpty) {
      return Image.asset(
        "assets/images/black.png",
        fit: BoxFit.cover,
      );
    }

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
  final TextEditingController controller;

  const RoundedInputField(
      {super.key, required this.placeholder, required this.controller});

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
        controller: controller,
        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: const TextStyle(color: Colors.grey),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
