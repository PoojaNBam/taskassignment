import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_function/function/utils.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskassignment/Utill/assets.dart';
import 'package:taskassignment/Utill/colorr.dart';
import 'package:taskassignment/Utill/common.dart';
import 'package:taskassignment/Utill/custom_widgets.dart';
import 'package:taskassignment/Utill/strings.dart';
import 'package:taskassignment/Utill/styles.dart';
import 'package:taskassignment/db/firebase_services.dart';
import 'package:taskassignment/project/my_profile/userdetails.dart';
import 'package:validation_pro/validate.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final FireBaseServices _fireDb = FireBaseServices();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _mobileNumber = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  String _id = "";
  List<UsrDetails> _userDetail = [];
  bool _isFirst = false;
  bool isFirstTime = true;
  String _userName = "";

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() {
    checkFirstTime();
    setState(() {});
  }

  void checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
    String id = prefs.getString("Id") ?? "";

    if (!isFirstTime) {
      setState(() {
        _fetchUserDetail(id);
        this.isFirstTime = false;
      });
    } else {
      setState(() {
        _clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _mb();
  }

  _mb() {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: Colors.black,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    _buildAppBar(),
                    Positioned(
                      top: 80,
                      child: _profileImage(),
                    ),
                  ]),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const VSpace(
                    space: 35,
                  ),
                  Visibility(
                      visible: _isFirst,
                      replacement: Container(),
                      child: _customContainer()),
                  _buildInputText(),
                  CButton(
                    height: 40,
                    backColor: Colorr.blue50,
                    text: Strings.profileUpdate,
                    textStyle: Styles.txtRegular(color: Colorr.white),
                    onTap: () {
                      _addUser(_email.text, _mobileNumber.text, _name.text);
                    },
                    width: MediaQuery.of(context).size.width * 0.8,
                  ),
                  const VSpace(),
                ],
              ),
              const VSpace(),
              const CDivider()
            ],
          ),
        )));
  }

  _clear() {
    _name.clear();
    _email.clear();
    _mobileNumber.clear();
    setState(() {});
  }

  _buildInputText() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.personalDetails,
            style: Styles.txtRegular(fontSize: 15, color: Colors.black),
          ),
          const VSpace(),
          TextField(
            controller: _name,
            decoration: const InputDecoration(
              label: Text(Strings.name),
              hintText: Strings.enterName,
              border: OutlineInputBorder(),
            ),
            autocorrect: false,
            enableSuggestions: false,
            textCapitalization: TextCapitalization.none,
          ),
          const VSpace(),
          TextField(
            controller: _mobileNumber,
            keyboardType: TextInputType.number,
            inputFormatters: [
              Validate.intValueFormatter(),
              LengthLimitingTextInputFormatter(10)
            ],
            decoration: const InputDecoration(
              label: Text(Strings.mobileNumber),
              hintText: Strings.enterMobileNumber,
              border: OutlineInputBorder(),
            ),
          ),
          const VSpace(),
          TextField(
            controller: _email,
            decoration: const InputDecoration(
              label: Text(Strings.email),
              hintText: Strings.enterEmail,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  _buildAppBar() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            height: 150.0,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage(Assets.imgBack))),
            child: Padding(
              padding: const EdgeInsets.only(top: 30, left: 25),
              child: Text(
                Strings.myProfile,
                style: Styles.txtRegular(fontSize: 17, color: Colors.white),
              ),
            ),
          ),
        )
      ],
    );
  }

  _profileImage() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Stack(
        children: [
          ClipOval(
            child: SizedBox.fromSize(
                size: const Size.fromRadius(50), // Image radius
                child: Image.asset(Assets.imgProfile)),
          ),
          const Positioned(
            bottom: 15,
            right: 2,
            child: Align(
              alignment: Alignment.bottomRight,
              child: CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 12,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Icon(
                    Assets.icCamera,
                    size: 12.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _customContainer() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16, top: 10),
      child: Column(
        children: [
          Text(
            _userName,
            style: Styles.txtRegular(fontSize: 18, color: Colorr.black),
          ),
          const VSpace(),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Strings.agroShopCode,
                  style: Styles.txtRegular(color: Colorr.white),
                ),
                const VSpace(),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  width: 550,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colorr.yellow50),
                    color: Colorr.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    _id,
                    style: Styles.txtRegular(color: Colorr.white),
                  ),
                ),
                const VSpace(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _successScreenBottomSheet(BuildContext context) {
    return Common.customBottomSheet(
      context: context,
      builder: (context, setState) {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const VSpace(
                space: 15,
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CDivider(
                        width: 100,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15, right: 15),
                        child: Tap(
                          child: const Icon(Assets.icClear),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const VSpace(
                space: 15,
              ),
              Image.asset(Assets.imgSuccess),
              const VSpace(
                space: 25,
              ),
              Text(
                Strings.congratulations,
                style: Styles.txtRegular(color: Colorr.green50, fontSize: 20),
              ),
              const VSpace(),
              Text(
                "${Strings.successfully} $_id",
                textAlign: TextAlign.center,
                style: Styles.txtRegular(color: Colorr.grey50, fontSize: 15),
              ),
              const VSpace(
                space: 25,
              ),
              CButton(
                textStyle: Styles.txtRegular(color: Colorr.white),
                backColor: Colorr.blue50,
                text: Strings.done,
                onTap: () {
                  setState(() {
                    Navigator.pop(context);
                    _init();
                  });
                },
                height: 50,
                width: 250,
              ),
              const VSpace(
                space: 20,
              ),
            ],
          ),
        );
      },
    );
  }

  _fetchUserDetail(String id) async {
    _userDetail = await _fireDb.getDataForId(id);
    print(_userDetail.first.id);
    setState(() {
      if (_userDetail.isNotEmpty) {
        _id = _userDetail.first.id;
        _name.text = _userDetail.first.name;
        _email.text = _userDetail.first.userEmail;
        _mobileNumber.text = _userDetail.first.userNumber;
        _userName = _userDetail.first.name;
        _isFirst = true;
      }
    });
  }

  _addUser(String email, String number, String name) async {
    _id = randomAlphaNumeric(10);

    if (Utils.isNullOREmpty(name)) {
      Common.showToast(Strings.pleaseEnterName);
      return;
    }

    if (Utils.isNullOREmpty(number)) {
      Common.showToast(Strings.pleaseEnterNumber);
      return;
    }
    if (number.length != 10) {
      Common.showSnackBar(Strings.plzEnterValidMobileNumber);
      return;
    }

    if (Utils.isNullOREmpty(email)) {
      Common.showToast(Strings.pleaseEnterEmail);
      return;
    }
    if (!_emailRegex.hasMatch(email)) {
      Common.showToast(Strings.pleaseEnterEmail);
      return;
    }

    Map<String, dynamic> userDetail = {
      "id": _id,
      "name": name,
      "email": email,
      "contactNumber": number
    };

    _fireDb.addUserInfo(userDetail, _id);
    _successScreenBottomSheet(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false);
    await prefs.setString("Id", _id);
    isFirstTime = false;
    _clear();

    setState(() {});
  }
}
