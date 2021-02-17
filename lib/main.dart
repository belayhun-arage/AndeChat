import 'package:ChatUI/data_store/shared_pref.dart';
import 'package:ChatUI/screens/auth_screen.dart';
import 'package:ChatUI/screens/chat_screen.dart';
import 'package:ChatUI/models/user_model.dart';
import 'package:ChatUI/screens/home_screen.dart';
import 'package:ChatUI/stateClasses/friends_bloc.dart';
import 'package:ChatUI/stateClasses/tab_index_state.dart';
import 'package:ChatUI/stateClasses/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';
import 'package:ChatUI/stateClasses/state_observer.dart';

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
