import 'package:ChatUI/libs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = ValuesObserver();
  runApp(MyApp(null));
}

class MyApp extends StatelessWidget {
  final Alie user;
  MyApp(@required this.user);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => UserCubit(),
        ), // FriendsBloc
        BlocProvider(
          create: (_) => TabIndex( ),
        ),
        BlocProvider(
          create: (_) => FriendsBloc(),
        ),
        BlocProvider(
          create: ( _ )=> OnlineFriends.instance,
        ),
      ],

/*












*/
      child: MaterialApp(
        title: 'Flutter Chat UI',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          accentColor: Color(0XFFeeeeee),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),

        initialRoute: AuthScreen.Route,
        // home: HomeScreen(),
        routes: {
          HomeScreen.Route: (context) {
            return HomeScreen();
          },
          ChatScreen.Route: (context) {
            return ChatScreen();
          },
          AuthScreen.Route: (context) {
            return AuthScreen();
          },
        },
        // home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
