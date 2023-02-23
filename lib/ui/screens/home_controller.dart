import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liberate/ui/screens/profile_screen.dart';
import 'package:provider/provider.dart';
import '../../constant/strings.dart';
import '../../provider/currentUser_provider.dart';
import '../../services/database_service.dart';
import '../generic_widgets/loading_widget.dart';
import 'home_screen.dart';

class HomeController extends StatefulWidget {
  String userUid;
  HomeController({Key? key, required this.userUid}) : super(key: key);
  @override
  _HomeControllerState createState() => _HomeControllerState();
}

class _HomeControllerState extends State<HomeController> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [    const HomeScreen(),  const ProfileScreen() ];
  bool isDone = false;
  late CurrentUserProvider currentLitnineClientProvider;

  @override
  void initState() {
    currentLitnineClientProvider=Provider.of<CurrentUserProvider>(context, listen: false);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final database= Provider.of<DatabaseService>(context);
    var screenSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async=>false,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: StreamBuilder(
              stream: database.currentUser(widget.userUid),
              builder: (BuildContext context, AsyncSnapshot snapshot){
                if(!snapshot.hasData || snapshot.hasError){
                  return Container(color: Colors.white,child: LoadingWidget(),);
                }
                else{
                  setCurrentUserInfo(snapshot.data!.data());
                  return homeHandler();
                }
              },
            ),
          )
      ),
    );
  }


  Widget homeHandler(){
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


  void setCurrentUserInfo(Map<String, dynamic> json) {
    if (!isDone) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        currentLitnineClientProvider.setCurrentUserFromJSON(json);
        isDone = true;
      });
    }
  }


}
