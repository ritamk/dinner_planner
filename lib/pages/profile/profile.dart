import 'package:dinner_planner/models/user.dart';
import 'package:dinner_planner/services/database.dart';
import 'package:dinner_planner/shared/constants.dart';
import 'package:dinner_planner/shared/loading.dart';
import 'package:dinner_planner/shared/not_logged_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final UserID? userID = Provider.of<UserID?>(context);
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final FocusNode _nameFocus = FocusNode();
    final FocusNode _phoneFocus = FocusNode();
    final FocusNode _landmarkFocus = FocusNode();
    final FocusNode _adLineFocus = FocusNode();
    final FocusNode _pinFocus = FocusNode();
    final FocusNode _cityFocus = FocusNode();
    final FocusNode _stateFocus = FocusNode();

    return userID != null
        ? StreamBuilder<ExtendedUserData?>(
            stream: DatabaseService(uid: userID.uid).extendedUserData,
            initialData: null,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                // 0 - pin, 1 - city, 2 - state, 3 - adLine, 4 - landmark
                List<dynamic> location = snapshot.data.address.entries
                    .map((e) => UserAddressData(
                        field: e.key.toString(), value: e.value.toString()))
                    .toList();

                String? _name = snapshot.data.name;
                String? _phone = snapshot.data.phone;
                String? _landmark = location[4].value;
                String? _adLine = location[3].value;
                String? _city = location[1].value;
                String? _state = location[2].value;
                String? _pin = location[0].value;
                return GestureDetector(
                  onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                  child: Scaffold(
                    appBar: AppBar(
                      leading: IconButton(
                        onPressed: () => Navigator.pop(context, "/"),
                        icon: const Icon(Icons.arrow_back_ios),
                      ),
                      title: const Text("Profile"),
                    ),
                    body: SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              style: const TextStyle(fontSize: 18.0),
                              focusNode: _nameFocus,
                              initialValue: snapshot.data.name,
                              decoration: profileInputDecoration()
                                  .copyWith(helperText: "Name"),
                              onChanged: (val) => _name = val,
                              validator: (val) => val!.isEmpty
                                  ? "Please enter your name"
                                  : null,
                            ),
                            const Divider(),
                            TextFormField(
                              style: const TextStyle(fontSize: 18.0),
                              focusNode: _phoneFocus,
                              initialValue: snapshot.data.phone,
                              decoration: profileInputDecoration().copyWith(
                                  prefixText: "+91 ", helperText: "Phone"),
                              onChanged: (val) => _phone = val,
                              validator: (val) => val!.length == 10 &&
                                      val.contains(RegExp("[0-9]"))
                                  ? null
                                  : "Please enter a valid phone number",
                            ),
                            const Divider(),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              child: Text("Address:"),
                            ),
                            TextFormField(
                              style: const TextStyle(fontSize: 18.0),
                              focusNode: _landmarkFocus,
                              initialValue: location[4].value,
                              decoration: profileInputDecoration()
                                  .copyWith(helperText: "Landmark"),
                              onChanged: (val) => _landmark = val,
                            ),
                            const Divider(),
                            TextFormField(
                              style: const TextStyle(fontSize: 18.0),
                              focusNode: _adLineFocus,
                              initialValue: location[3].value,
                              decoration: profileInputDecoration()
                                  .copyWith(helperText: "Post-office"),
                              onChanged: (val) => _adLine = val,
                              validator: (val) => val!.isEmpty
                                  ? "Please enter the name of your post-office/neighbourhood"
                                  : null,
                            ),
                            const Divider(),
                            TextFormField(
                              style: const TextStyle(fontSize: 18.0),
                              focusNode: _cityFocus,
                              initialValue: location[1].value,
                              decoration: profileInputDecoration()
                                  .copyWith(helperText: "City/District"),
                              onChanged: (val) => _city = val,
                              validator: (val) => val!.isEmpty
                                  ? "Please enter the name of your city/district"
                                  : null,
                            ),
                            const Divider(),
                            TextFormField(
                              style: const TextStyle(fontSize: 18.0),
                              focusNode: _stateFocus,
                              initialValue: location[2].value,
                              decoration: profileInputDecoration()
                                  .copyWith(helperText: "State"),
                              onChanged: (val) => _state = val,
                              validator: (val) => val!.isEmpty
                                  ? "Please enter the name of your state"
                                  : null,
                            ),
                            const Divider(),
                            TextFormField(
                              style: const TextStyle(fontSize: 18.0),
                              focusNode: _pinFocus,
                              initialValue: location[0].value,
                              decoration: profileInputDecoration()
                                  .copyWith(helperText: "Pin-no."),
                              onChanged: (val) => _pin = val,
                              validator: (val) => val!.length == 6 &&
                                      val.contains(RegExp("[0-9]"))
                                  ? null
                                  : "Please enter a valid pin number",
                            ),
                          ],
                        ),
                      ),
                    ),
                    floatingActionButton: FloatingActionButton(
                      child: const Icon(Icons.check),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          dynamic result =
                              await DatabaseService(uid: userID.uid)
                                  .updateUserData(ExtendedUserData(
                            name: _name,
                            phone: _phone,
                            landmark: _landmark,
                            adLine: _adLine,
                            city: _city,
                            state: _state,
                            pin: _pin,
                          ));

                          result != 1
                              ? ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                  content: const Text(
                                      "Profile updated successfully."),
                                ))
                              : ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                  content: const Text(
                                      "Failed to update profile.\nPlease check network connection and/or try again later."),
                                ));
                        }
                      },
                    ),
                  ),
                );
              } else {
                return const Loading();
              }
            })
        : const NotLoggedIn();
  }
}
