import 'package:flutter/material.dart';
import 'package:masinqo/presentation/widgets/admin_header.dart';
import 'delete_confirmation_modal.dart';
import '../../data/listener_data.dart';

class AdminListenerMGT extends StatelessWidget {
  const AdminListenerMGT({super.key});

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
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Text(
                'Listeners',
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: listenerData.length,
                itemBuilder: (context, index) {
                  final listener = listenerData[index];

                  return ListTile(
                    minLeadingWidth: 20,
                    minVerticalPadding: 20,
                    leading: CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage('assets/images/u.png'),
                    ),
                    title: Text(listener.name),
                    subtitle: Text(listener.email, style: TextStyle(color: const Color.fromARGB(255, 193, 191, 191))),
                    textColor: Colors.white,
                    subtitleTextStyle: TextStyle(color: Colors.white70),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return DeleteConfirmationDialog(
                                  title: 'Are you sure you want to delete this Listener?',
                                  content: '',
                                  onConfirm: () {
                                    Navigator.of(context).pop();
                                  },
                                );
                              },
                            );
                          },
                          tooltip: 'Delete',
                          color: Colors.red,
                        ),
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
