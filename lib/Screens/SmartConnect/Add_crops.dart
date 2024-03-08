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

class AddCrops extends StatefulWidget {
  const AddCrops({super.key});

  @override
  State<AddCrops> createState() => _AddCropsState();
}

class _AddCropsState extends State<AddCrops> {
  /* String dropdownValue = "Tractors";
  var items = ['Tractors', 'Harvestors', 'Pesticides', 'Others']; */
  TextEditingController cropnameController = TextEditingController();
  TextEditingController mspController = TextEditingController();
  TextEditingController descrController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  File? pic;

  void saveUser() async {
    String cropname = cropnameController.text.trim();
    String msp = mspController.text.trim();
    String quantity = quantityController.text.trim();
    String descr = descrController.text.trim();
    String contact = contactController.text.trim();

    cropnameController.clear();
    mspController.clear();
    descrController.clear();
    quantityController.clear();
    contactController.clear();

    if (cropname != "" && msp != "" && quantity != "" && descr != "") {
      UploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child("pic")
          .child(Uuid().v1())
          .putFile(pic!);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadurl = await taskSnapshot.ref.getDownloadURL();

      Map<String, dynamic> cropData = {
        "cropname": cropname,
        "msp": msp,
        "quantity": quantity,
        "descr": descr,
        "pic": downloadurl,
        "contact": contact,
      };

      FirebaseFirestore.instance.collection("smartconnect").add(cropData);
      print("Crops Added");
    } else {
      print("Crops not added");
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
        title: const Text('Add Crops'),
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
            controller: cropnameController,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              border: OutlineInputBorder(),
              labelText: "Crop Name",
              hintText: "Crop Name",
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: mspController,
            /* onChanged: (value) {
              addRentToolsCtrl.rentToolsModel.toolPricePerDay = value;
            }, */
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                border: OutlineInputBorder(),
                labelText: "Minimum Support Price",
                hintText: "Minimum Support Price"),
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
            controller: quantityController,
            /* onChanged: (value) {
              addRentToolsCtrl.rentToolsModel.toolPricePerDay = value;
            }, */
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                border: OutlineInputBorder(),
                labelText: "Quantity",
                hintText: "Quantity in quintals"),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: descrController,
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
            controller: contactController,
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
