import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AdminDrawer extends StatelessWidget {
  const AdminDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const DrawerHeader(
              child: Center(
                child: Text('Shoply Admin', style: TextStyle(fontSize: 22)),
              ),
            ),

            ListTile(
                  leading: const Icon(Icons.settings_outlined),
                  title: const Text('Settings'),
                  onTap: () {
                    Navigator.pop(context);
                    // هنا بنضيف التنقل لصفحة Settings.
                  },
                )
                .animate()
                .fadeIn(duration: 350.ms)
                .slideX(begin: -0.12, end: 0, duration: 350.ms),
          ],
        ),
      ),
    );
  }
}
