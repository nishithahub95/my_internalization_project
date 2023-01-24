import 'package:internalization/classes/language.dart';
import 'package:internalization/classes/language_constant.dart';

import 'main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:internalization/classes/language.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  SharedPreferences? loginData;
  String? userName;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initial();
  }

  void initial() async {
    loginData = await SharedPreferences.getInstance();
    setState(() {
      userName = loginData!.getString('username');
    });
  }
  void _showSuccessDialog() {
    showTimePicker(context: context, initialTime: TimeOfDay.now());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade800,
     appBar: AppBar(
       backgroundColor:  Colors.green.shade800,
       actions: [
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: DropdownButton<Language>(
             underline: const SizedBox(),
             icon: const Icon(
               Icons.language,
               color: Colors.white,
             ),
             onChanged: (Language? language)async{
               if (language != null) {
                 Locale _locale = await setLocale(language.languageCode);
                 Home.setLocale(context, _locale);
               }

               // TODO: to call change language method
             },
             items: Language.languageList()
                 .map<DropdownMenuItem<Language>>(
                   (e) => DropdownMenuItem<Language>(
                 value: e,
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: <Widget>[
                     Text(
                       e.flag,
                       style: const TextStyle(fontSize: 30),
                     ),
                     Text(e.name)
                   ],
                 ),
               ),
             )
                 .toList(),
           ),
         ),
       ],
     ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(accountName:Text('Nishitha'),
              decoration: BoxDecoration(color: Colors.red),
              accountEmail: Text('adsds@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage('https://th.bing.com/th/id/R.e893d3f4d1ebea537db15134f269c05c?rik=DgFb98LW4fJFjA&riu=http%3a%2f%2fwww.hdwallpaperspulse.com%2fwp-content%2fuploads%2f2018%2f02%2f09%2fbaby-wallpaper-1.jpg&ehk=CMIOasg5wUtAJLAXeKgqzSLfEMDck2koBoACQmO18WA%3d&risl=&pid=ImgRaw&r=0'),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Profile",style: TextStyle(fontSize: 20),) ,
              onTap:(){},

            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings",style: TextStyle(fontSize: 20),) ,
              onTap:(){},

            ),

            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Signout",style: TextStyle(fontSize: 20),) ,
              onTap:(){
                loginData!.setBool('login', true);
                Navigator.pushReplacement(context,
                    new MaterialPageRoute(builder: (context) => Home()));
              },

            ),

          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // IconButton(
                //   icon: Icon(Icons.menu),
                //   color: Colors.white,
                //   onPressed: () {},
                // ),

                Container(
                    width: 125.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 35
                          , backgroundImage: NetworkImage('https://th.bing.com/th/id/R.5a480652b93233346d5940345fab9790?rik=hJ1CAPU2uLA2SA&riu=http%3a%2f%2f1.bp.blogspot.com%2f-FnFtfwmfNAM%2fVZgSzOagCgI%2fAAAAAAAAA5c%2fsmfXuf2jioY%2fs1600%2fCute-Baby-Girl-Wallpapers-36.jpg&ehk=nlT4%2fi8YzoUypQnexHXKL6DxwSKyY9sg2id%2b0lBYud8%3d&risl=&pid=ImgRaw&r=0'),
                        ),
                        // IconButton(
                        //   icon: Icon(Icons.logout_rounded),
                        //   color: Colors.white,
                        //   onPressed: () {
                        //
                        //     loginData!.setBool('login', true);
                        //     Navigator.pushReplacement(context,
                        //         new MaterialPageRoute(builder: (context) => Home()));
                        //   },
                        // )
                      ],
                    ))
              ],
            ),
          ),
          SizedBox(height: 25.0),
          Padding(
            padding: EdgeInsets.only(left: 40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                // Text('Hi   $userName',
                //     style: TextStyle(
                //         fontFamily: 'Montserrat',
                //         color: Colors.white,
                //         fontWeight: FontWeight.bold,
                //         fontSize: 25.0)),
                SizedBox(width: 10.0),
                Text('',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontSize: 25.0))
              ],
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            height: MediaQuery.of(context).size.height - 190.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
            ),
            child: ListView(
              primary: false,
              padding: EdgeInsets.only(left: 25.0, right: 20.0),
              children: <Widget>[
                SizedBox(height: 50,),
                Form(
                  key: _key,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height / 4,
                        child:  Center(
                          child: Text(translation(context).personalInformation
                            ,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      TextFormField(
                        validator: (val) {
                          if (val != null && val.isEmpty) {
                            return "Required Field";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: translation(context).name,
                          hintText: translation(context).nameHint,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (val) {
                          if (val != null && val.isEmpty) {
                            return "Required Field";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: translation(context).email,
                          hintText: translation(context).emailHint,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText:translation(context).dateOfBirth,
                        ),
                        onTap: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(DateTime.now().year),
                            lastDate: DateTime(DateTime.now().year + 20),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MaterialButton(
                        onPressed: () {
                          if (_key.currentState != null && _key.currentState!.validate()) {
                            _showSuccessDialog();
                          }
                        },
                        height: 50,
                        shape: const StadiumBorder(),
                        color: Colors.green.shade800,
                        child: Center(
                          child: Text(
                            translation(context).submitInfo,
                            style: const TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      )
                    ],
                  ),
                )



              ],
            ),
          )
        ],
      ),





    );
  }
}

