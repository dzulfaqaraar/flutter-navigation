import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/loading_indicator.dart';
import '../../common/state_enum.dart';
import '../provider/profile_notifier.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      Provider.of<ProfileNotifier>(context, listen: false).fetchUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text('Profile Page'),
          ),
          body: Center(
            child: Consumer<ProfileNotifier>(
              builder: (context, notifier, child) {
                if (notifier.state == RequestState.error) {
                  return Text(notifier.message);
                }
                return Text(notifier.userData?.name ?? '');
              },
            ),
          ),
        ),
        Consumer<ProfileNotifier>(builder: (context, notifier, child) {
          return LoadingIndicator(
            isLoading: notifier.state == RequestState.loading,
          );
        }),
      ],
    );
  }
}
