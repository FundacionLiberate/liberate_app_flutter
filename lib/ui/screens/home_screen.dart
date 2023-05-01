import 'package:flutter/material.dart';
import 'package:liberate/themes/colors.dart';
import 'package:liberate/ui/screens/upload_file_screen.dart';
import 'package:provider/provider.dart';
import '../../constant/assetImages.dart';
import '../../constant/strings.dart';
import '../../provider/currentUser_provider.dart';
import '../generic_widgets/home_option.dart';
import 'dart:math' as math;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final currentUser= Provider.of<CurrentUserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 200,
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(Strings.homeTitle, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
                ),
              ),
              Expanded(
                flex: 1,
                child: Image.asset(AssetImages.logoPath),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              )
            ],
          ),
        )
      ),
      body:Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          alignment: Alignment.center,
          child: Stack(
            children: [
             GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,childAspectRatio: 0.8, crossAxisSpacing: 20, mainAxisSpacing: 20),
                children: [
                  HomeOption(title: Strings.informesTitle, imagePath: AssetImages.informeIconPath),
                  HomeOption(title: Strings.boletinesTitle, imagePath:AssetImages.boletinIconPath),
                  HomeOption(title: Strings.revistasTitle, imagePath:AssetImages.magazineIconPath),
                  HomeOption(title: Strings.capacitacionesTitle, imagePath:AssetImages.capacitacionesIconPath ),

                  HomeOption(title: Strings.historiasClinicasTitle, imagePath:AssetImages.historialClinioPath ),
                  HomeOption(title: Strings.programasTitle, imagePath:AssetImages.programasPath ),
                  HomeOption(title: Strings.proyectosTitle, imagePath:AssetImages.proyectosPath ),
                ],
              ),


            ],
          )
        ),
      ),
      floatingActionButton: Consumer<CurrentUserProvider>(
          builder: (context, data, child) {
            if(data.currentUser!=null && data.currentUser!.isAdmin){
              return  Container(
                margin: const EdgeInsets.only(
                    bottom: 50
                ),
                child: ExpandableFab(
                  distance: 100.0,
                  children: [
                    ActionButton(
                      onPressed: () {
                        addFile();
                      },
                      icon: const Icon(Icons.file_copy),
                    ),
                  ],
                ),
              );
            }else{
              return Container();
            }
          }
      )
    );
  }




  void addFile() async{
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          insetPadding: const EdgeInsets.all(10),
          contentPadding: const EdgeInsets.all(0),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))
          ),
          content: Builder(
            builder: (context) {
              return Container(
                padding: const EdgeInsets.all(
                  10
                ),
                width: 400,
                height: 320,
                child: const UploadFileScreen(),
              );
            },
          ),
        );
      },
    );
  }


}


@immutable
class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    super.key,
    this.initialOpen,
    required this.distance,
    required this.children,
  });

  final bool? initialOpen;
  final double distance;
  final List<Widget> children;

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  bool _open = false;

  @override
  void initState() {
    super.initState();
    _open = widget.initialOpen ?? false;
    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          _buildTapToCloseFab(),
          ..._buildExpandingActionButtons(),
          _buildTapToOpenFab(),
        ],
      ),
    );
  }

  Widget _buildTapToCloseFab() {
    return SizedBox(
      width: 56.0,
      height: 56.0,
      child: Center(
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          color: Colors.red, // set the color to red
          elevation: 4.0,
          child: InkWell(
            onTap: _toggle,
            child: const Padding(
              padding: EdgeInsets.all(14.0),
              child: Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.children.length;
    final step = 90.0 / (count - 1);
    for (var i = 0, angleInDegrees = 0.0;
    i < count;
    i++, angleInDegrees += step) {
      children.add(
        _ExpandingActionButton(
          directionInDegrees: angleInDegrees,
          maxDistance: widget.distance,
          progress: _expandAnimation,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }

  Widget _buildTapToOpenFab() {
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          _open ? 0.7 : 1.0,
          _open ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: _open ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: const Duration(milliseconds: 250),
          child: FloatingActionButton(
            backgroundColor: mainGreen,
            onPressed: _toggle,
            child: const Icon(Icons.add,size: 30,),
          ),
        ),
      ),
    );
  }
}

@immutable
class _ExpandingActionButton extends StatelessWidget {
  const _ExpandingActionButton({
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
  });

  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionInDegrees * (math.pi / 180.0),
          progress.value * maxDistance,
        );
        return Positioned(
          right: 4.0 + offset.dx,
          bottom: 4.0 + offset.dy,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * math.pi / 2,
            child: child!,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}

@immutable
class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    this.onPressed,
    required this.icon,
  });

  final VoidCallback? onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 60,
      height: 60,
      child: Material(
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        color: mainGreen,
        elevation: 4.0,
        child: IconButton(
          onPressed: onPressed,
          icon: icon,
          color: theme.colorScheme.onSecondary,
        ),
      ),
    );
  }
}

@immutable
class FakeItem extends StatelessWidget {
  const FakeItem({
    super.key,
    required this.isBig,
  });

  final bool isBig;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
      height: isBig ? 128.0 : 36.0,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        color: Colors.grey.shade300,
      ),
    );
  }
}

