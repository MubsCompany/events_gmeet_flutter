import 'package:events_gmeet_flutter/screens/dashboard_screen.dart';
import 'package:events_gmeet_flutter/secret.dart';
import 'package:events_gmeet_flutter/utils/calendar_client.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  var _clientID = new ClientId(Secret.getId(), "");
  const _scopes = const [cal.CalendarApi.CalendarScope];
  await clientViaUserConsent(_clientID, _scopes, prompt).then((AuthClient client) async {
    CalendarClient.calendar = cal.CalendarApi(client);
  });

  runApp(MyApp());
}

void prompt(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Events Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        appBarTheme: AppBarTheme(
          brightness: Brightness.light,
        ),
      ),
      home: DashboardScreen(),
    );
  }
}