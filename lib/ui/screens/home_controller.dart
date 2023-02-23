import 'package:flutter/cupertino.dart';
import 'package:liberate/ui/screens/profile_screen.dart';
import '../../constant/strings.dart';
import 'home_screen.dart';

class HomeController extends StatefulWidget {
  @override
  _HomeControllerState createState() => _HomeControllerState();
}

class _HomeControllerState extends State<HomeController> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [    const HomeScreen(),  const ProfileScreen() ];

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.home),
            label:  Strings.homeTitle,
          ),
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.person),
            label: Strings.profileTitle,
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (BuildContext context) => _screens[index],
        );
      },
    );
  }
}
