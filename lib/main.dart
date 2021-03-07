import 'package:ChatUI/libs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'admin/bloc/admin_idea_state.dart';
import 'admin/bloc/admin_state_bloc.dart';
import 'admin/bloc/admin_users_.dart';
import 'ideas/screens/idea_rout.dart';

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
          create: (_) => OnlineFriends(UserRepository()),
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
        BlocProvider(
          create: (_) => InteractiveUser(
            UserRepository(),
            ChatRepository(),
          ),
        ),
        BlocProvider(create: (_) {
          return IdeaBloc(
            idearepository: Idearepository(),
          );
        }),
        BlocProvider(
          create: (_) {
            return AdminState(repo: AdminRepository());
          },
        ),
        BlocProvider(
          create: (_) => MyIdeaBloc(
            idearepository: Idearepository(),
          ),
        ) , 
        BlocProvider(
          create: (_)=> AdminUsersState(repo : AdminUserRepository()),
        ),
        BlocProvider(
          create: (_)=> AdminIdeaState(repo : AdminIdeaRepository()),
        )
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
            return HomeScreen.instance ;
          },
          ChatScreen.Route: (context) {
            return ChatScreen();
          },
          AuthScreen.Route: (context) {
            return AuthScreen();
          },
          ChangeProfile.RouteName: (context) {
            return ChangeProfile();
          },
          AdminLogin.Route: (context) {
            return AdminLogin();
          },
          AdminPage.RouteName: (context) {
            return AdminPage();
          }
        },
        // home: MyHomePage(title: 'Flutter Demo Home Page'),
        onGenerateRoute: CourseAppRoute.generateRoute,
      ),
    );
  }

  // caling the asynchrooniousto instantiate some datas methods so that they will be ready when we need them
  instantiateSome() {
    UserDataProvider.getInstance();
    MessagingDataProvider.getInstance();
    UpdateData.getInstance();
    AdminDataProvider.getInstance();
  }
}
