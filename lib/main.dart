import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/auth_cubit.dart';
import 'cubit/bottom_navbar_cubit.dart';
import 'cubit/empty_cubit.dart';
// import 'cubit/farm_data_cubit.dart';
// import 'cubit/server_connection_cubit.dart';
import 'cubit/password_cubit.dart';
import 'services/auth_service.dart';
import 'ui/pages/init_page.dart';
import 'ui/pages/main_page.dart';
import 'services/base/streamable_event_service.dart';
// import 'services/websocket_service.dart';
import 'ui/pages/profile/login_page.dart';
import 'use_case/auth_use_case.dart';
import 'use_case/farm_data_use_case.dart';
// import 'utils/server_utils.dart';

Future<void> _init() async {
  // String serverURL = await ServerUtils.getServerURL();
  // int port = await ServerUtils.getPort();

  // service = WebsocketService(serverURL, port);
  // useCase = FarmDataUseCase(service);

  // farmStatusUseCase = FarmDataUseCase(WebsocketService(serverURL, port));
  // farmSoilHumidityUseCase = FarmDataUseCase(WebsocketService(serverURL, port));
  // farmTemperatureUseCase = FarmDataUseCase(WebsocketService(serverURL, port));
  // farmAirHumidityUseCase = FarmDataUseCase(WebsocketService(serverURL, port));
  // farmSoilPHUseCase = FarmDataUseCase(WebsocketService(serverURL, port));
  // farmSprinklerUseCase = FarmDataUseCase(WebsocketService(serverURL, port));
  // farmLampUseCase = FarmDataUseCase(WebsocketService(serverURL, port));
}

late StreamableEventService service;
late FarmDataUseCase useCase;

// late FarmDataUseCase farmStatusUseCase;
// late FarmDataUseCase farmSoilHumidityUseCase;
// late FarmDataUseCase farmTemperatureUseCase;
// late FarmDataUseCase farmAirHumidityUseCase;
// late FarmDataUseCase farmSoilPHUseCase;
// late FarmDataUseCase farmSprinklerUseCase;
// late FarmDataUseCase farmLampUseCase;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, this.initService = false});
  final bool initService;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    if (widget.initService) {
      _init();
    }

    super.initState();
  }

  AuthUseCase authUseCase = AuthUseCase(AuthService());

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(authUseCase),
        ),
        BlocProvider(create: (context) => BottomNavbarCubit()),
        BlocProvider(create: (context) => PasswordCubit()),
        // BlocProvider(create: (context) => FarmStatusCubit(useCase)),
        // BlocProvider(create: (context) => FarmSoilHumidityCubit(useCase)),
        // BlocProvider(create: (context) => FarmTemperatureCubit(useCase)),
        // BlocProvider(create: (context) => FarmAirHumidityCubit(useCase)),
        // BlocProvider(create: (context) => FarmSoilPHCubit(useCase)),
        // BlocProvider(create: (context) => FarmSprinklerCubit(useCase)),
        // BlocProvider(create: (context) => FarmLampCubit(useCase)),
        // BlocProvider(create: (context) => ServerConnectionCubit(useCase)),
      ],
      child: MaterialApp(
        title: 'AgroSense',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Color(0xFFEEEEEE)),
          ).apply(),
        ),
        initialRoute: '/init',
        routes: {
          '/main': (context) => const MainPage(),
          '/init': (context) => const InitPage(),
          '/login': (context) => LoginPage(),
        },
      ),
    );
  }
}
