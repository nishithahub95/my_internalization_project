import 'package:flutter/material.dart';
import 'package:internalization/classes/language_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homePage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

     // locale: _locale,
      home: Home(),
    );
  }
}
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
  static void setLocale(BuildContext context,Locale newLocal){
    _HomeState? state=context.findAncestorStateOfType<_HomeState>();
    state?.setLocale(newLocal);
  }
}

class _HomeState extends State<Home> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }
  final userNameContraoller=TextEditingController();
  final passwordController=TextEditingController();
  SharedPreferences? loginData;
  bool? newuser;

  void isLogin() async {
    loginData = await SharedPreferences.getInstance();
    newuser = (loginData!.getBool('login') ?? true);
    print(newuser);
    if (newuser == false) {
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => homepage()));
    }
  }
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    userNameContraoller.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLogin();
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    getLocale().then((local) => setLocale(local));
    super.didChangeDependencies();

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      home: homepage(),
    );

  }


}
