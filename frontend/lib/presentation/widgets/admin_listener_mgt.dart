import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masinqo/application/admin/admin_event.dart';
import 'package:masinqo/application/admin/admin_state.dart';
import 'package:masinqo/application/admin/admin_bloc.dart';
import 'package:masinqo/application/auth/admin_auth_bloc.dart';
import 'package:masinqo/domain/admin/admin_listeners/admin_listeners.dart';
import 'package:masinqo/presentation/widgets/admin_header.dart';
import 'delete_confirmation_modal.dart';

class AdminListenerMGT extends StatelessWidget {
  const AdminListenerMGT({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ListenerBloc>(context).add(GetListeners(
        token: BlocProvider.of<AdminAuthBloc>(context).state.token));
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
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
          BlocBuilder<ListenerBloc, AdminListenersState>(
            builder: (context, state) {
              if (state.listeners.isEmpty) {
                return Expanded(
                  child: Center(
                    child: Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage("assets/images/empty_list.png"))),
                      height: 400,
                      width: 400,
                    ),
                  ),
                );
              }

              return Expanded(
                  child: ListenerList(listenerData: state.listeners));
            },
          ),
        ],
      ),
    );
  }
}

class ListenerList extends StatelessWidget {
  final List<AdminListener> listenerData;
  const ListenerList({super.key, required this.listenerData});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listenerData.length,
      itemBuilder: (context, index) {
        final listener = listenerData[index];
        return ListTile(
          minLeadingWidth: 20,
          minVerticalPadding: 20,
          leading: const CircleAvatar(
            radius: 24,
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage('assets/images/u.png'),
          ),
          title: Text(listener.name),
          subtitle: Text(listener.email,
              style:
                  const TextStyle(color: Color.fromARGB(255, 193, 191, 191))),
          textColor: Colors.white,
          subtitleTextStyle: const TextStyle(color: Colors.white70),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  void emitDeleteEvent() {
                    BlocProvider.of<ListenerBloc>(context).add(
                      DeleteListener(
                          listenerId: listener.id,
                          token: BlocProvider.of<AdminAuthBloc>(context)
                              .state
                              .token),
                    );
                  }

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return DeleteConfirmationDialog(
                        title: 'Are you sure you want to delete this Listener?',
                        content: '',
                        onConfirm: () {
                          emitDeleteEvent();
                          Navigator.pop(context);
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
    );
  }
}
