import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jamt/constants/app_color.dart';
import 'package:jamt/feature/activities/view/activities_tab.dart';
import 'package:jamt/feature/bulletin/bulletin.dart';
import 'package:jamt/feature/qr/qr.dart';
import 'package:jamt/feature/semi_plenary/semi_plenary.dart';
import 'package:jamt/feature/tab_home/tab_home.dart';
import 'package:jamt/feature/home/home.dart';
import 'package:jamt/feature/guide/guide.dart';
import 'package:jamt/feature/schedule/schedule.dart';
import 'package:jamt/feature/map/map.dart';
import 'package:jamt/widget/widget.dart';
import 'package:jamt/feature/event/event.dart';
import 'package:jamt/feature/guests/guests.dart';

class TabHomeScreen extends StatefulWidget {
  const TabHomeScreen({super.key});

  @override
  State<TabHomeScreen> createState() => _HomeState();
}

class _HomeState extends State<TabHomeScreen> {
  late final List<GlobalKey<NavigatorState>> _navigatorKeys;
  final List<TabDestination> _tabHistory = [];
  int _backPressCounter = 0;
  Timer? _backPressTimer;

  @override
  void initState() {
    super.initState();
    final destinations = context.read<TabHomeBloc>().state.destinations;
    _navigatorKeys = List.generate(
      destinations.length,
      (_) => GlobalKey<NavigatorState>(),
    );
  }

  @override
  void dispose() {
    _navigatorKeys.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TabHomeBloc, TabHomeState>(
      listener: (context, state) {

        if(state is DestinationSelected){
          if(state.destination == TabDestination.sessions){
            print("state");
            context.read<SemiPlenaryBloc>().add(LoadSemiPlenary());
          }

        }
      },
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) return;

          final bloc = context.read<TabHomeBloc>();
          final index = bloc.state.destinations.indexOf(bloc.state.destination);
          final navigator = _navigatorKeys[index].currentState;

          if (navigator != null && await navigator.maybePop()) {
            return;
          }

          if (_tabHistory.isNotEmpty) {
            final previousIndex = _tabHistory.removeLast();
            bloc.add(DestinationSelected(previousIndex));
            return;
          }

          // Si NO estás en Guía, retrocede a Home antes de salir
          if (bloc.state.destination != TabDestination.home) {
            bloc.add(DestinationSelected(TabDestination.home));
            return;
          }

          _backPressCounter++;
          if (_backPressCounter == 1) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Presiona otra vez para salir')),
            );
            _backPressTimer = Timer(const Duration(seconds: 2), () {
              _backPressCounter = 0;
            });
          } else {
            _backPressTimer?.cancel();
            _backPressCounter = 0;
            Future.delayed(const Duration(milliseconds: 100), () {
              SystemNavigator.pop();
            });
          }
        },
        child: Scaffold(
          drawer: const HomeDrawer(),
          body: Stack(
            children: [
              _HomeIndexStack(navigatorKeys: _navigatorKeys),
              Positioned(
                left: 16,
                right: 16,
                bottom: 32,
                child: _HomeNavigationBar(
                  navigatorKeys: _navigatorKeys,
                  onTabSelected: (TabDestination destination) {
                    final bloc = context.read<TabHomeBloc>();
                    var destinations = bloc.state.destinations;

                    var currentIndex = destinations.indexOf(destination);

                    if (destination == TabDestination.menu) {
                      final scaffoldContext =
                          _navigatorKeys[currentIndex].currentContext;
                      if (scaffoldContext != null) {
                        Scaffold.of(scaffoldContext).openDrawer();
                      }
                      return;
                    }
                    // Elimina si ya existe antes en la pila
                    _tabHistory.remove(destination);

                    // Agrega el actual a la pila si no es duplicado del último
                    if (_tabHistory.isEmpty || _tabHistory.last != destination) {
                      _tabHistory.add(destination);
                    }

                    bloc.add(DestinationSelected(destination));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final destination = context.select(
      (TabHomeBloc bloc) => bloc.state.destination,
    );
    return HomeAppBar(color: destination.color1);
  }
}

class _HomeIndexStack extends StatelessWidget {
  const _HomeIndexStack({super.key, required this.navigatorKeys});

  final List<GlobalKey<NavigatorState>> navigatorKeys;

  @override
  Widget build(BuildContext context) {
    final selectDestination = context.select(
      (TabHomeBloc bloc) => bloc.state.destination,
    );
    final destinations = context.select(
      (TabHomeBloc bloc) => bloc.state.destinations,
    );

    return Stack(
      children: [
       Column(
          children: [
            Expanded(
              flex: 1,
                child: Container(
                  color: selectDestination.color1,
                )
            ),
            Expanded(
                flex: 2,
                child: Container(
                  color: selectDestination.color2,
                )
            )
          ],
        ),
        IndexedStack(
          index: destinations.indexOf(selectDestination),
          children: List.generate(
            destinations.length,
                (index) => Navigator(
              key: navigatorKeys[index],
              onGenerateRoute: (_) {
                return MaterialPageRoute(
                  builder:
                      (_) => Stack(
                        children: [
                          CustomScrollView(
                            slivers: [
                              _HomeAppBar(),
                              SliverToBoxAdapter(
                                child: _getScreenForDestination(destinations[index]),
                              ),
                            ],
                          )
                        ],
                      ),
                );
              },
            ),
          ),
        )
      ],
    );
  }

  Widget _getScreenForDestination(TabDestination destination) {
    switch (destination) {
      case TabDestination.guide:
        return const GuideTab();
      case TabDestination.schedule:
        return const ScheduleScreen();
      case TabDestination.home:
        return const HomeScreen();
      case TabDestination.map:
        return const MapTab();
      case TabDestination.menu:
        return EventScreen();
      case TabDestination.activities:
        return ActivitiesTab();
      case TabDestination.guests:
        return GuestsTab();
      case TabDestination.sessions:
        return SemiPlenaryTabs();
      case TabDestination.event:
        return EventScreen();
      case TabDestination.bulletin:
        return BulletinTab();
      default:
        return const MapTab();
    }
  }
}

class _HomeNavigationBar extends StatelessWidget {
  const _HomeNavigationBar({
    super.key,
    required this.navigatorKeys,
    required this.onTabSelected,
  });

  final List<GlobalKey<NavigatorState>> navigatorKeys;
  final Function(TabDestination destination) onTabSelected;

  List<double> _saturationMatrix(double saturation) {
    final double invSat = 1 - saturation;
    final double r = 0.213 * invSat;
    final double g = 0.715 * invSat;
    final double b = 0.072 * invSat;

    return [
      r + saturation, g, b, 0, 0,
      r, g + saturation, b, 0, 0,
      r, g, b + saturation, 0, 0,
      0, 0, 0, 1, 0,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final selectDestination = context.select(
      (TabHomeBloc bloc) => bloc.state.destination,
    );
    final destinations = List.from(
      context.select((TabHomeBloc bloc) => bloc.state.destinations),
    );
    destinations.removeWhere((element) => element.parent != null);
    var index = destinations.indexOf(selectDestination);
    if (selectDestination.parent != null) {
      index = destinations.indexOf(selectDestination.parent!);
    }

    return SafeArea(
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          child: BackdropFilter(
            filter: ImageFilter.compose(
              outer: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // blur(5px)
              inner: ColorFilter.matrix(_saturationMatrix(1.8)),  // saturate(180%)
            ),
            child: Container(
              color: Colors.white.withOpacity(0.3),
              child: Theme(
                data: Theme.of(context).copyWith(
                  splashFactory: NoSplash.splashFactory,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                ),
                child: NavigationBar(
                  height: 72,
                  backgroundColor: Colors.transparent,
                  elevation: 8,
                  labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
                  indicatorColor: Colors.transparent,
                  selectedIndex: index,
                  onDestinationSelected: (index) {
                    print("onDestinationSelected $index");
                    onTabSelected(destinations[index]);
                  },
                  destinations:
                  destinations.map((destination) {
                    return _buildNavItem(
                      destination.icon,
                      destination.label,
                      destinations[index] == destination,
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        )
    );
  }

  NavigationDestination _buildNavItem(
    IconData icon,
    String label,
    bool select,
  ) {
    return NavigationDestination(
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18,),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 4),
          Container(
            height: 3,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: select ? AppColor.colorMenuPrimary : Colors.transparent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
      label: '',
    );
  }
}
