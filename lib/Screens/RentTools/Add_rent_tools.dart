import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

final _db = FirebaseFirestore.instance;

/* createUser(Rent addtools) async {
  await _db.collection("addtools").add(addtools.toJson());
} */

class AddTool extends StatefulWidget {
  const AddTool({super.key});

  @override
  State<AddTool> createState() => _AddToolState();
}

class _AddToolState extends State<AddTool> {
  String dropdownValue = "Tractors";
  var items = ['Tractors', 'Harvestors', 'Pesticides', 'Others'];
  TextEditingController nameController = TextEditingController();
  TextEditingController costController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController contactinfoController = TextEditingController();
  File? pic;

  void saveUser() async {
    String name = nameController.text.trim();
    String cost = costController.text.trim();
    String category = categoryController.text.trim();
    String desc = descController.text.trim();
    String contactinfo = contactinfoController.text.trim();

    nameController.clear();
    costController.clear();
    categoryController.clear();
    descController.clear();
    contactinfoController.clear();

    if (name != "" && cost != "" && category != "" && desc != "") {
      UploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child("pic")
          .child(Uuid().v1())
          .putFile(pic!);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadurl = await taskSnapshot.ref.getDownloadURL();

      Map<String, dynamic> toolData = {
        "name": name,
        "cost": cost,
        "category": category,
        "desc": desc,
        "pic": downloadurl,
        "contactinfo": contactinfo,
      };

      FirebaseFirestore.instance.collection("addtools").add(toolData);
      print("Tools Added");
    } else {
      print("Tools not added");
    }
    setState(() {
      pic = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green.shade300,
        title: const Text('Add Tools'),
        leading: const Icon(FontAwesomeIcons.tools),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      /* bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.folderOpen),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "",
          )
        ],
      ), */
      body: ListView(
        padding: const EdgeInsets.all(17),
        shrinkWrap: true,
        children: [
          SizedBox(
            height: 10,
          ),
          CupertinoButton(
            onPressed: () async {
              XFile? selectedImage =
                  await ImagePicker().pickImage(source: ImageSource.gallery);

              if (selectedImage != null) {
                File convertedFile = File(selectedImage.path);
                setState(() {
                  pic = convertedFile;
                });
                print("Image selected");
              } else {
                print("No image selected");
              }
            },
            padding: EdgeInsets.zero,
            child: CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 80,
              backgroundImage: (pic != null) ? FileImage(pic!) : null,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              border: OutlineInputBorder(),
              labelText: "Name",
              hintText: "Name",
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: costController,
            /* onChanged: (value) {
              addRentToolsCtrl.rentToolsModel.toolPricePerDay = value;
            }, */
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                border: OutlineInputBorder(),
                labelText: "Cost per Day",
                hintText: "eg : Rs xxx/day"),
          ),
          SizedBox(
            height: 10,
          ),
          /* TextFormField(
            controller: categoryController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              suffixIcon: PopupMenuButton<String>(
                
                icon: const Icon(Icons.arrow_drop_down),
                onSelected: (String value) {
                  categoryController.text = value;
                },
                itemBuilder: (BuildContext context) {
                  return items.map<PopupMenuItem<String>>((String value) {
                  
                    return new PopupMenuItem(
                        child: new Text(value), value: value);
                  }).toList();
                },
              ),
            ),
          ), */
          TextFormField(
            controller: categoryController,
            /* onChanged: (value) {
              addRentToolsCtrl.rentToolsModel.toolPricePerDay = value;
            }, */
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                border: OutlineInputBorder(),
                labelText: "Category",
                hintText: "eg: Tractors"),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: descController,
            onChanged: (value) {},
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                border: OutlineInputBorder(),
                labelText: "Description",
                hintText: "Description"),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: contactinfoController,
            onChanged: (value) {},
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                border: OutlineInputBorder(),
                labelText: "Contact Number",
                hintText: "Contact Number"),
          ),
          ElevatedButton(
              child: Text("Add"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade400),
              onPressed: () {
                saveUser();
              }),
        ],
      ),
    );
  }
}
