import 'package:crud_sqlite_joes/model/User.dart';
import 'package:crud_sqlite_joes/services/userService.dart';
import 'package:flutter/material.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  var _plantNameController = TextEditingController();
  var _plantDiseaseController = TextEditingController();
  var _plantDescriptionController = TextEditingController();
  bool _validateName = false;
  bool _validateContact = false;
  bool _validateDescription = false;
  var _userService = UserService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 220, 229, 208),
      appBar: AppBar(
        title: const Text("Track of Plants"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add a Plant',
                style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 60, 111, 21),
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _plantNameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Plant Name',
                    labelText: 'Plant',
                    errorText:
                        _validateName ? 'Name Value Can\'t Be Empty' : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _plantDiseaseController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Found Disease',
                    labelText: 'Disease',
                    errorText: _validateContact
                        ? 'Contact Value Can\'t Be Empty'
                        : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _plantDescriptionController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Treatments Needed',
                    labelText: 'Treatments',
                    errorText: _validateDescription
                        ? 'Description Value Can\'t Be Empty'
                        : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Color.fromARGB(255, 52, 107, 11),
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: () async {
                        setState(() {
                          _plantNameController.text.isEmpty
                              ? _validateName = true
                              : _validateName = false;
                          _plantDiseaseController.text.isEmpty
                              ? _validateContact = true
                              : _validateContact = false;
                          _plantDescriptionController.text.isEmpty
                              ? _validateDescription = true
                              : _validateDescription = false;
                        });
                        if (_validateName == false &&
                            _validateContact == false &&
                            _validateDescription == false) {
                          // print("Good Data Can Save");
                          var _user = User();
                          _user.name = _plantNameController.text;
                          _user.contact = _plantDiseaseController.text;
                          _user.description = _plantDescriptionController.text;
                          var result = await _userService.SaveUser(_user);
                          Navigator.pop(context, result);
                        }
                      },
                      child: const Text('Noted')),
                  const SizedBox(
                    width: 10.0,
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Color.fromARGB(255, 112, 85, 8),
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: () {
                        _plantNameController.text = '';
                        _plantDiseaseController.text = '';
                        _plantDescriptionController.text = '';
                      },
                      child: const Text('Clear All ?'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
