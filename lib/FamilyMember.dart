import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gri_client/ImageViewer.dart';
import 'package:gri_client/api/APIConstant.dart';
import 'package:gri_client/api/APIService.dart';
import 'package:gri_client/api/Environment.dart';
import 'package:gri_client/colors/MyColors.dart';
import 'package:gri_client/models/AccountResponse.dart';
import 'package:gri_client/models/RelationResponse.dart';
import 'package:gri_client/models/Response.dart';
import 'package:gri_client/size/MySize.dart';
import 'package:gri_client/strings/Strings.dart';
import 'package:gri_client/toast/Toast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FamilyMember extends StatefulWidget {
  final String id, act;
  const FamilyMember({Key? key, required this.id, required this.act}) : super(key: key);

  @override
  State<FamilyMember> createState() => _FamilyMemberState();
}

class _FamilyMemberState extends State<FamilyMember> {

  bool load = false;
  late SharedPreferences sharedPreferences;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  Account account = Account();

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();

  DateTime? dob;
  DateTime? anniversary;

  List<Relation> relations = [];
  List<String> relationsString = [];
  String? relation;
  String? proof1;
  String? proof2;

  final ImagePicker picker = ImagePicker();
  XFile? filei;
  XFile? filep1;
  XFile? filep2;

  @override
  void initState() {
    start();
    super.initState();
  }

  Future<void> start() async {
    sharedPreferences = await SharedPreferences.getInstance();
    getRelations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: MyColors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
            "FAMILY MEMBER",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: MyColors.colorPrimary
            )
        ),
      ),
      body: load ? Padding(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: MySize.size3(context)),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    filei = await picker.pickImage(source: ImageSource.gallery,imageQuality:40);
                    setState(() {

                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      backgroundColor: MyColors.colorPrimary,
                      radius: 71,
                      child: CircleAvatar(
                        foregroundColor: Colors.transparent,
                        radius: 70,
                        child: ClipOval(
                            child: filei==null ?
                            CachedNetworkImage(
                              imageUrl: Environment.accountUrl + (account.image??""),
                              errorWidget: (context, url, error) {
                                return ClipOval(
                                  child: Icon(
                                    Icons.account_circle,
                                    size: 120,
                                  ),
                                );
                              },
                            )
                            : Image.file(
                              File(
                                filei?.path??""
                              )
                            )
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                getGeneralDetails(),
                SizedBox(
                  height: 20,
                ),
                getSpecialDates(),
                SizedBox(
                  height: 20,
                ),
                getProofs(),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    if (formkey.currentState!.validate()) {
                      if(filei==null && widget.act==APIConstant.add)
                        Toast.sendToast(context, "Upload Member Profile");
                      else
                        addFamilyMember();
                    }
                  },
                  child: Container(
                      width: MySize.size100(context),
                      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: MyColors.colorPrimary,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: getLabel(widget.act==APIConstant.add ? "Add" : "Update")
                  ),
                )
              ],
            ),
          ),
        ),
      )
      : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  getCardLabel(String label) {
    return Container(
        width: MySize.size100(context),
        padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 10.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: MyColors.colorPrimary,
        ),
        child: getLabel(label)
    );
  }

  getLabel(String label) {
    return Text(
      label,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: MyColors.white,
          fontSize: 15,
          fontWeight: FontWeight.w600
      ),
    );
  }

  getRelationDropdown() {
    return Flexible(
      flex: 3,
      fit: FlexFit.tight,
      child: DropdownSearch<String>(
        popupProps: PopupProps.menu(
          showSelectedItems: true,
          //disabledItemFn: (String s) => s.startsWith('A'),
          showSearchBox: true,
        ),
        items: relationsString,
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            labelText: "Select",
          ),
        ),
        validator: (value) {
          String message = "";
          if (value==null) {
            return "* Required";
          }  else {
            return null;
          }

        },
        onChanged: (value) {
          relation = value;
          setState(() {});
        },
        selectedItem: relation,
      ),
    );
  }

  getProof1Dropdown() {
    return Flexible(
      flex: 3,
      fit: FlexFit.tight,
      child: DropdownSearch<String>(
        popupProps: PopupProps.menu(
          showSelectedItems: true,
          showSearchBox: true,
        ),
        items: Strings.proofs,
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            labelText: "Select",
          ),
        ),
        validator: (value) {
          if (value==null) {
            return "* Required Proof Type";
          }
          else if (filep1==null && widget.act==APIConstant.add) {
            return "* Required Proof Image";
          }  else {
            return null;
          }
        },
        onChanged: (value) {
          proof1 = value;
          setState(() {});
        },
        selectedItem: proof1,
      ),
    );
  }

  getProof2Dropdown() {
    return Flexible(
      flex: 3,
      fit: FlexFit.tight,
      child: DropdownSearch<String>(
        popupProps: PopupProps.menu(
          showSelectedItems: true,
          showSearchBox: true,
        ),
        items: Strings.proofs,
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            labelText: "Select",
          ),
        ),
        validator: (value) {
          if (value==null) {
            return null;
          }
          else {
            if (filep2==null && widget.act==APIConstant.add) {
              return "* Required Proof Image";
            }
            else {
              return null;
            }
          }
        },
        onChanged: (value) {
          proof2 = value;
          setState(() {});
        },
        selectedItem: proof2,
      ),
    );
  }

  getInfoDropdown(String title) {
    return Row(
      children: [
        getTitle(title),
        getRelationDropdown()
      ],
    );
  }

  getInfoController(String title, TextEditingController controller) {
    return Row(
      children: [
        getTitle(title),
        getController(title, controller)
      ],
    );
  }

  getInfoDate(String title, String info) {
    return Row(
      children: [
        getTitle(title),
        title=="Date of Birth" ? getBirthDate(info) : getAnniversaryDate(info)
      ],
    );
  }

  getBirthDate(String info) {
    return Flexible(
      flex: 3,
      fit: FlexFit.tight,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(DateTime.now().year-100),
                lastDate: DateTime.now(),
              ).then((value) {
                if(value!=null) {
                  dob = value;
                  setState(() {

                  });
                }
              });
            },
            child: Image.asset(
              "assets/claim/calendar.png",
              height: 30,
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                info,
                style: TextStyle(
                    color: MyColors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  getAnniversaryDate(String info) {
    return Flexible(
      flex: 3,
      fit: FlexFit.tight,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(DateTime.now().year-100),
                lastDate: DateTime.now(),
              ).then((value) {
                if(value!=null) {
                  anniversary = value;
                  setState(() {

                  });
                }
              });
            },
            child: Image.asset(
              "assets/claim/calendar.png",
              height: 30,
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                info,
                style: TextStyle(
                    color: MyColors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  getInfoImageDesign(String title, String info) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getTitle(title),
        getInfoImage(title, info)
      ],
    );
  }

  getInfoImage(String title, String info) {
    print(Environment.proofUrl+info);
    return Flexible(
      flex: 3,
      fit: FlexFit.tight,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (BuildContext context) => ImageViewer(url: Environment.proofUrl+info,)));
        },
        child: Text(
          "View "+title,
          textAlign: TextAlign.start,
          style: TextStyle(
              color: MyColors.colorDarkPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline
          ),
        ),
      ),
    );
  }


  getTitle(String title) {
    return Flexible(
      flex: 2,
      fit: FlexFit.tight,
      child: Text(
        title,
        textAlign: TextAlign.start,
        style: TextStyle(
            color: MyColors.black,
            fontSize: 13,
            fontWeight: FontWeight.w600
        ),
      ),
    );
  }

  getController(String title, TextEditingController controller) {
    print(title);
    return Flexible(
      flex: 3,
      fit: FlexFit.tight,
      child: TextFormField(
        controller: controller,
        maxLength: title=="Phone" ? 13 : null,
        keyboardType: title=="Phone" ? TextInputType.phone : title=="Phone" ?  TextInputType.emailAddress : TextInputType.text,
        inputFormatters: [
          if(title=="Phone")
            FilteringTextInputFormatter.digitsOnly
        ],
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: MyColors.colorPrimary
                )
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 10)
        ),
        validator: (value) {
          String message = "";
          if (value!.isEmpty) {
            return "* Required";
          }
          else if (value.length<10 && title=="Phone") {
            return "* Wrong Number";
          }  else {
            return null;
          }

        },
      ),
    );
  }

  getGeneralDetails() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: MyColors.colorPrimary.withOpacity(0.3),
          borderRadius: BorderRadius.circular(5)
      ),
      child: Column(
        children: [
          getCardLabel("General Details"),
          SizedBox(
            height: 10,
          ),
          getInfoDropdown("Relation"),
          SizedBox(
            height: 15,
          ),
          getInfoController("Name", name),
          SizedBox(
            height: 15,
          ),
          getInfoController("Email", email),
          SizedBox(
            height: 15,
          ),
          getInfoController("Phone", phone),
        ],
      ),
    );
  }

  getSpecialDates() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: MyColors.colorPrimary.withOpacity(0.3),
          borderRadius: BorderRadius.circular(5)
      ),
      child: Column(
        children: [
          getCardLabel("Special Dates"),
          SizedBox(
            height: 10,
          ),
          getInfoDate("Date of Birth", dob!=null ? DateFormat("dd-MMM-yyyy").format(dob??DateTime.now()) : "No Date"),
          SizedBox(
            height: 15,
          ),
          getInfoDate("Anniversary Date", anniversary!=null ? DateFormat("dd-MMM-yyyy").format(anniversary??DateTime.now()) : "No Date"),
        ],
      ),
    );
  }

  getProofs() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: MyColors.colorPrimary.withOpacity(0.3),
          borderRadius: BorderRadius.circular(5)
      ),
      child: Column(
        children: [
          getCardLabel("Proofs"),
          SizedBox(
            height: 10,
          ),
          getProofDesign1(),
          SizedBox(
            height: 20,
          ),
          getProofDesign2()
          // getInfoImageDesign(account.proofType1??"", account.proofId1??""),
          // if(account.proofId2!=null)
          //   SizedBox(
          //     height: 15,
          //   ),
          // if(account.proofId2!=null)
          //   getInfoImageDesign(account.proofType2??"", account.proofId2??""),
        ],
      ),
    );
  }

  getProofDesign1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            getTitle("Proof 1"),
            getProof1Dropdown()
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Align(
                alignment: Alignment.centerLeft,
                child: filep1==null ?
                widget.act==APIConstant.update && (account.proofId1??"").isNotEmpty ?
                CachedNetworkImage(
                  imageUrl: Environment.proofUrl + (account.proofId1??""),
                  errorWidget: (context, url, error) {
                    return Icon(
                        Icons.error,
                        size: 50,
                    );
                  },
                )
                : Icon(
                  Icons.broken_image_outlined,
                  size: 35,
                )
                : Image.file(
                  File(
                    filep1?.path??""
                  ),
                ),
              )
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      filep1 = await picker.pickImage(source: ImageSource.gallery,imageQuality:40);
                      setState(() {

                      });
                    },
                    child: Text(
                      "Select Proof",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: MyColors.colorDarkPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      filep1 = null;
                      setState(() {

                      });
                    },
                    child: Text(
                      "Remove Proof",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: MyColors.colorDarkPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        )
      ],
    );
  }

  getProofDesign2() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            getTitle("Proof 2"),
            getProof2Dropdown()
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Align(
                alignment: Alignment.centerLeft,
                child: filep2==null ?
                widget.act==APIConstant.update && (account.proofId2??"").isNotEmpty?
                CachedNetworkImage(
                  imageUrl: Environment.proofUrl + (account.proofId2??""),
                  errorWidget: (context, url, error) {
                    return Icon(
                      Icons.error,
                      size: 50,
                    );
                  },
                )
                : Icon(
                  Icons.broken_image_outlined,
                  size: 35,
                )
                : Image.file(
                  File(
                    filep2?.path??""
                  ),
                ),
              )
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      filep2 = await picker.pickImage(source: ImageSource.gallery,imageQuality:40);
                      setState(() {

                      });
                    },
                    child: Text(
                      "Select Proof",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: MyColors.colorDarkPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      filep2 = null;
                      setState(() {

                      });
                    },
                    child: Text(
                      "Remove Proof",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: MyColors.colorDarkPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        )
      ],
    );
  }

  getRelations() async {
    RelationResponse relationResponse = await APIService().getRelations();
    relations = relationResponse.relation ?? [];

    relations.forEach((element) {
      relationsString.add(element.relation!);
    });

    if(widget.act==APIConstant.update)
      getMemberDetails();
    else {
      load = true;
      setState(() {

      });
    }

  }

  Future<void> addFamilyMember() async {
    Map<String,String> queryParameters = {
      APIConstant.act : widget.act,
      "acc_id" : sharedPreferences.getString("id")??"",
      "r_id" : relations[relationsString.indexOf(relation!)].id??"",
      "type" : "FAMILY",
      "name" : name.text,
      "email" : email.text,
      "phone" : phone.text,
      "dob" : (dob??"No Date").toString(),
      "anniversary" : (anniversary??"No Date").toString(),
      "image" : filei?.path??"",
      "proof_type_1" : proof1??"",
      "proof_id_1" : filep1?.path??"",
      "proof_type_2" : proof2??"",
      "proof_id_2" : filep2?.path??"",
      "status" : "1",
    };

    if(widget.act==APIConstant.update) {
      queryParameters.addAll(
        {
          "id" : account.id??"",
          "image_path" : account.image??"",
          "image_pt1" : account.proofId1??"",
          "image_pt2" : account.proofId2??""
        }
      );
    }

    print(queryParameters);

    Response response = await APIService().addFamilyMember(queryParameters);


    if(response.message=="Family Member Added" || response.message=="Family Member Updated" ) {
      Navigator.pop(context);
    }
    Toast.sendToast(context, response.message??"");

  }

  getMemberDetails() async {
    Map<String,String> queryParameters = {
      APIConstant.act : APIConstant.getByID,
      "id" : widget.id,
    };
    print(queryParameters);

    AccountResponse accountResponse = await APIService().getProfile(queryParameters);
    print(accountResponse.toJson());

    account = accountResponse.account ?? Account();

    setState(() {

    });

    setData();

  }

  void setData() {

    name.text = account.name??"";
    email.text = account.email??"";
    phone.text = account.phone??"";
    dob = account.dob!=null ? DateTime.parse(account.dob??"") : null;
    anniversary = account.anniversary!=null ? DateTime.parse(account.anniversary??"") : null;
    relations.forEach((element) {
      if(element.id==account.rId) {
        relation = element.relation;
      }
    });

    Strings.proofs.forEach((element) {
      if(element==account.proofType1)
        proof1 = element;
      if(element==account.proofType2)
        proof2 = element;
    });


    load = true;

  }
}
