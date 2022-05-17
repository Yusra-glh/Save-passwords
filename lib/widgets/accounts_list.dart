import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:save_password/config/size_config.dart';
import 'package:save_password/config/textStyle.dart';
import 'package:save_password/views/account_details.dart';
import '../models/account.dart';

class AccountList extends StatefulWidget {
  final Account account;
  const AccountList({Key? key, required this.account}) : super(key: key);

  @override
  State<AccountList> createState() => _AccountListState();
}

class _AccountListState extends State<AccountList> {
  bool hide = true;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var hm = SizeConfig.heightMultiplier;
    var wm = SizeConfig.widthMultiplier;
    var tm = SizeConfig.textMultiplier;
    controller.text = widget.account.password ?? "";
    return SizedBox(
      // height: hm*12,
      //width:  MediaQuery.of(context).size.width*0.8,
      child: ListTile(
        //tileColor: Colors.black.withOpacity(0.2),
        contentPadding:
            EdgeInsets.symmetric(horizontal: wm * 2, vertical: wm * 1.2),
        leading: Container(
          width: wm * 9,
          height: wm * 8,
          padding: EdgeInsets.only(right: wm * 2),
          decoration: const BoxDecoration(
              border:
                  Border(right: BorderSide(width: 1.0, color: Colors.black26))),
          child: Image.asset(
            widget.account.icon ?? "assets/icons/key.png",
          ),
        ),
        title: Text(
          widget.account.title ?? "",
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: wm * 30,
              child: TextFormField(
                  enabled: false,
                  obscureText: hide ? true : false,
                  controller: controller,
                  keyboardType: TextInputType.text,
                  style: tS(
                      'NunitoRegular', tm * 2, FontWeight.normal, Colors.black),
                  decoration: const InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      border: InputBorder.none)),
            ),
            Padding(
                padding: EdgeInsets.only(left: wm * 10),
                child: Row(
                  children: [
                    IconButton(
                      icon: hide
                          ? const Icon(Icons.remove_red_eye_outlined)
                          : const Icon(Icons.remove_red_eye),
                      color: Colors.black,
                      onPressed: () {
                        setState(() {
                          hide = !hide;
                        });
                      },
                    ),
                    SizedBox(
                      width: wm * 3,
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy),
                      color: Colors.black,
                      onPressed: () {
                        Clipboard.setData(
                                ClipboardData(text: widget.account.password))
                            .then((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("Password copied to clipboard")));
                        });
                      },
                    ),
                  ],
                )),
          ],
        ),

        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AccountDetails(account: widget.account)));
        },
      ),
    );
  }
}
