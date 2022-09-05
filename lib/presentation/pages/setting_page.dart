import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/state_enum.dart';
import '../provider/profile_notifier.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting Page'),
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
    );
  }
}
