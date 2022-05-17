import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_password/config/size_config.dart';
import 'package:save_password/config/textStyle.dart';
import 'package:save_password/models/account.dart';
import 'package:save_password/providers/account_provider.dart';
import 'package:save_password/widgets/primary_button.dart';
import 'package:save_password/widgets/rounded_text_field.dart';

import '../widgets/level_indicator.dart';

class AccountDetails extends StatefulWidget {
  final Account account;
  const AccountDetails({Key? key, required this.account}) : super(key: key);

  @override
  State<AccountDetails> createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    passwordController = TextEditingController(text: widget.account.password);
    emailController = TextEditingController(text: widget.account.email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var hm = SizeConfig.heightMultiplier;
    var wm = SizeConfig.widthMultiplier;
    var tm = SizeConfig.textMultiplier;
    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: hm * 10),
        SizedBox(
            height: hm * 6,
            width: wm * 11,
            child: Image.asset(
              widget.account.icon ?? "assets/icons/key.png",
              fit: BoxFit.fill,
            )),
        const SizedBox(
          width: 90.0,
          child: Divider(color: Colors.green),
        ),
        const SizedBox(height: 10.0),
        Text(
          widget.account.title ?? "",
          style: const TextStyle(color: Colors.white, fontSize: 45.0),
        ),
        const SizedBox(height: 30.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
                flex: 3,
                child: LevelIndicator(
                  length: widget.account.strength ?? 0.2,
                )),
            Expanded(
                flex: 6,
                child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      widget.account.strengthValue ?? "",
                      style: const TextStyle(color: Colors.white),
                    ))),
          ],
        ),
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 10.0),
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/icons/account_bg.jpg"),
              fit: BoxFit.cover,
              // colorFilter:  ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: const EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration:
              const BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    );

    final bottomContentText = Column(children: [
      roundedTextField(context, wm, hm, tm, emailController, "Email"),
      SizedBox(
        height: hm * 2,
      ),
      roundedTextField(context, wm, hm, tm, passwordController, "Password"),
    ]);
    final readButton = Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: wm * 4),
          child: primaryButton(
              height: hm * 5.5,
              borderRadius: BorderRadius.circular(wm * 4),
              width: double.maxFinite,
              widget: Center(
                child: Text(
                  'Save',
                  style: tS(
                      'NunitoRegular', tm * 2.2, FontWeight.bold, Colors.white),
                ),
              ),
              function: () async {
                Account model = Account(
                  email: emailController.text.trim(),
                  password: passwordController.text.trim(),
                );
                if (widget.account.id != null &&
                    await context
                        .read<AccountProvider>()
                        .editAccount(widget.account.id!, model)) {
                  Navigator.pop(context);
                }
              }),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: wm * 4, vertical: hm * 2),
          child: primaryButton(
              height: hm * 5.5,
              borderRadius: BorderRadius.circular(wm * 4),
              width: double.maxFinite,
              color: Colors.red,
              widget: Center(
                child: Text(
                  'Delete',
                  style: tS(
                      'NunitoRegular', tm * 2.2, FontWeight.bold, Colors.white),
                ),
              ),
              function: () async {
                if (widget.account.id != null) {
                  if (await context.read<AccountProvider>().deleteAccount(widget.account.id!)) {
                    Navigator.pop(context);
                  }
                }
              }),
        )
      ],
    );
    final bottomContent = Container(
      // height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      // color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: hm * 4,
            ),
            bottomContentText,
            SizedBox(
              height: hm * 8,
            ),
            readButton
          ],
        ),
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[topContent, bottomContent],
      )),
    );
  }
}
