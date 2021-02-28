import 'package:ChatUI/libs.dart';
import 'package:ChatUI/user/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  Bloc.observer = ValuesObserver();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    instantiateSome();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => OnlineFriends( UserRepository()),
        ),
        BlocProvider(
          create: (_) {
            return FriendsState.getInstance();
          },
        ),
        BlocProvider(
          create: (_) {
            return UserState(repo: UserRepository());
          },
        ), // FriendsBloc
        BlocProvider(
          create: (_) {
            return TabIndex();
          },
        ),
        
      ],

/*












*/
      child: MaterialApp(
        title: 'AndeChat',
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
          ChangeProfile.RouteName: (context) {
            return ChangeProfile();
          }
        },
        // home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }

  // caling the time taking methods so that they will be ready when we need them
  instantiateSome() {
    UserDataProvider.getInstance();
    MessagingDataProvider.getInstance();
    UpdateData.getInstance();
  }
}
