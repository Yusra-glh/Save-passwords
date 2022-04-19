import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_password/config/size_config.dart';
import 'package:save_password/config/style.dart';
import 'package:save_password/providers/account_provider.dart';
import 'package:save_password/views/add_account.dart';
import 'package:save_password/widgets/accounts_list.dart';

import '../models/account.dart';
import '../models/accounts_list.dart';
import '../providers/auth_provider.dart';
import '../widgets/primary_button.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var hm=SizeConfig.heightMultiplier;
    var wm=SizeConfig.widthMultiplier;
    var tm=SizeConfig.textMultiplier;
    var provider=context.read<AccountProvider>();
    var Dprovider=context.watch<AccountProvider>();
    return
      FutureBuilder(
        future: provider.getAccounts(),
        builder: (BuildContext context, AsyncSnapshot<List<Account>> snapshot) {
          return Scaffold(
              floatingActionButton: FloatingActionButton(onPressed: () {
                Navigator.push(context,  MaterialPageRoute(builder: (BuildContext context) =>  NewAccount()));
              },
                child: const Icon(Icons.add),
                backgroundColor: AppStyle.primary,
                splashColor: AppStyle.secondary,
                highlightElevation: 0.9,
              ),
              // backgroundColor: Colors.grey,
              body:
           SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount:snapshot.hasData? snapshot.data!.length:0,
                    itemBuilder:(context, i)
                    { return
                      Card(
                        elevation: 8.0,
                        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                        child: Container(
                          decoration: const BoxDecoration(color:  Color.fromRGBO(153, 153, 255, .4)),
                          child: AccountList(account: snapshot.data![i],),
                        ),
                      );

                      }),

                Center(
                    child:
                   primaryButton(height: hm*5.5, borderRadius: BorderRadius.circular(wm*4),width: double.maxFinite, widget:Text("Logout"),function: () async {
                    await context.read<AuthProvider>().googleLogout();
     })),
              ],
            ),
          ));
        }
      );
  }
}
