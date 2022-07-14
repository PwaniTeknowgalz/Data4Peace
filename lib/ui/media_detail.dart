import 'dart:ui';

import 'package:data4peace/backend/controllers/auth_controller.dart';
import 'package:data4peace/backend/controllers/main_controller.dart';
import 'package:data4peace/utils/app_constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:path/path.dart';

import '../frontend/widgets/custom_button.dart';
import '../utils/app_utils.dart';

class MediaDetail extends StatefulWidget {
  const MediaDetail({Key? key}) : super(key: key);

  @override
  State<MediaDetail> createState() => _MediaDetailState();
}

class _MediaDetailState extends State<MediaDetail> {
  final _formKey = GlobalKey<FormBuilderState>();

   @override
  initState(){

    super.initState();
    Future.microtask(() async {
      await MainController.to.fetchSubmissionData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
        constraints:  const BoxConstraints.expand(),
        color: Colors.grey[100],
        child:  Stack(
          children: <Widget>[
            _getBackground(),
            _getGradient(),
            _getContent(),
            
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          color: AppConst.tealMainColor,
          child: Container(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                    onPressed: () {
                      _showEditDialog();
                    },
                    icon: const Icon(Icons.upload, color: Colors.white),
                    label: Text(
                      "Upload File".toUpperCase(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ))
              ],
            ),
          )),
    );
  }

  Container _getBackground() {
    return Container(
      constraints: const BoxConstraints.expand(height: 300.0),
      child: FadeInImage(height: 300,width: Get.width,fit: BoxFit.cover,image: NetworkImage((MainController.to.selectedCompetitions.value?.get("image") as ParseFile).url??""), placeholder: const NetworkImage('https://via.placeholder.com/600x853/000000/FFFFFF/?text=Data4Peace'),),
    );
  }

  Container _getGradient() {
    return Container(
      margin: const EdgeInsets.only(top: 190.0),
      height: 110.0,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[
            Color.fromARGB(0, 215, 215, 215),
            Color.fromARGB(255, 245, 245, 245)
          ],
          stops: [0.0, 0.9],
          begin: FractionalOffset(0.0, 0.0),
          end: FractionalOffset(0.0, 1.0),
        ),
      ),
    );
  }

  Widget _getContent() {
    return  ListView(
      padding:  const EdgeInsets.all(20),
      children: <Widget>[
        const SizedBox(
          height: 72,
        ),
        Stack(
          children: [
            Container(
              width: Get.width,
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: AppConst.tealMainColor,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: <BoxShadow>[
                   BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    offset: Offset(0.0, 10.0),
                  ),
                ],
              ),
              //Content
              child: Container(
                child: Obx(
                  ()=> Column(
                    children: [
                      Container(height: 4.0),
                      Text("${MainController.to.selectedCompetitions.value?.get("title")}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(
                        height: 12,
                      ),
                      Text("${MainController.to.selectedCompetitions.value?.get("subtitle")}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400)),
                
                      //Separator
                      Container(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          height: 2.0,
                          width: 18.0,
                          color: Colors.teal[100]),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          //icon and text
                          Row(
                            children: [
                              const Icon(
                                Icons.file_upload,
                                color: Colors.white70,
                                size: 16,
                              ),
                              const SizedBox(width: 5),
                              Text("${MainController.to.selectedCompetitions.value?.get("entries")} files submitted",
                                  style: const TextStyle(
                                      color: Colors.white70, fontSize: 12))
                            ],
                          ),
                          const SizedBox(width: 20),
                          //icon and text
                          Row(
                            children: [
                              const Icon(
                                Icons.download,
                                color: Colors.white70,
                                size: 16,
                              ),
                              const SizedBox(width: 5),
                               Text("${MainController.to.selectedCompetitions.value?.get("votes")??0} votes",
                                  style: const TextStyle(
                                      color: Colors.white70, fontSize: 12))
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        //content
        //title
        const Text("DETAILS",
            style: TextStyle(
                color: Colors.black87,
                fontSize: 16.0,
                fontWeight: FontWeight.w400)),
        //Separator
        Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            height: 2.0,
            width: 18.0,
            color: Colors.teal[100]),
        const SizedBox(
          height: 12,
        ),
        Text(
          "${MainController.to.selectedCompetitions.value?.get("description")}",
          style: TextStyle(
              color: Colors.grey[800], height: 1.2, letterSpacing: .5),
        ),
        Obx(() {
          return _showEntries();
        },)
      ],
    );
  }

void _showEditDialog() {
    
    MainController.to.uploadFile.value="";
    //MainController.to.selectedCompetitions.value = null;
    

    SmartDialog.show(builder: (context) {
      return SafeArea(
        child: Container(
          color: Colors.white,
          width: Get.width,
          height: Get.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(

                  color: const Color.fromRGBO(22, 29, 64, 1),
                  child:ListTile(
                      contentPadding: const EdgeInsets.only(left: 20,right:0,top: 5,bottom: 5),
                      tileColor: const Color.fromRGBO(22, 29, 64, 1),
                      trailing: IconButton(onPressed: (){
                        SmartDialog.dismiss();
                      }, icon: const Icon(Icons.close,color: Colors.white,)),
                      title:const Text("Upload Entry", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                      subtitle: const Text("Enter Details below", style: TextStyle(color: Colors.white),),
                    )
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: FormBuilder(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.disabled,
                      child: Column(
                        children: <Widget>[
                          const SizedBox(height: 30,),
                          FormBuilderTextField(
                              name: 'title',
                              decoration: InputDecoration(
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                labelText:
                                'Title',
                              ),
                             // onChanged: _onChanged,
                              // valueTransformer: (text) => num.tryParse(text),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                              ]),
                              keyboardType: TextInputType.text,
                            ),
                          const SizedBox(height: 20,),
                          Obx(() => InkWell(
                            onTap: () async {
                              FilePickerResult? result = await FilePicker.platform.pickFiles();

                              if(result!=null){
                                MainController.to.uploadFile.value=result.files.single.path!;
                                //print(MainController.to.image.value?.path);
                              }

                              
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black38),
                                  borderRadius: BorderRadius.circular(10)

                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  MainController.to.uploadFile.value==""? Text("No File Selected",style: TextStyle(color: Theme.of(context).hintColor),):Text(basename(MainController.to.uploadFile.value),style: TextStyle(color: Theme.of(context).hintColor)),
                                  const Icon(Icons.attach_file,color: AppConst.accentColor,)
                                ],
                              ),),
                          )),
                          const SizedBox(height: 40,),
                          CustomButton(
                            onPressed: () {
                              _saveResource(_formKey.currentState);
                            },
                            title: "Save Entry", style: AppConst.buttonStyle,
                          ),
                        ],
                      ),
                    ),
                ),
              ],
            ),
          ),
        ),
      );
    },);
  }
}

 _saveResource(FormBuilderState? currentState) async {
  //AppUtils.showLoading();
   if(currentState!=null){
     currentState.save();
     print(currentState.value);
   }
  if(currentState==null || !currentState.isValid){
    AppUtils.showModalMessage(message:"Entered data is invalid or fields are empty!",color: AppConst.error);
    return;
  }

  if(MainController.to.uploadFile.value==""){
    AppUtils.showModalMessage(message:"No File Selected!",color: AppConst.error);
    return;
  }

  var title = currentState.value["title"];
  var fileUrl = MainController.to.uploadFile.value;

  await MainController.to.saveEntryData(file: fileUrl,title: title);

  SmartDialog.dismiss();
await MainController.to.fetchSubmissionData();
}
_showEntries() {
  var entries = MainController.to.competitionEntries.value;
  print(entries);
  if (entries.isEmpty) {
    return Container();
  }
  var entriesKeys = (entries as Map).keys.toList().reversed.toList();
  return Column(
    children: entriesKeys.map((key) {
      var e = entries[key];
      return Container(
        width: Get.width,
        alignment: AlignmentDirectional.centerStart,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
            color: Color.fromRGBO(238, 238, 238, 1), borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${e.get("user").get("name")}",
                    style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("${e.get("title").trim()}", style: const TextStyle()),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Votes : ${e.get("votes")??0}",
                    style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                  // Text((e.get("submission") as ParseFile).name.trim(),
                  //     style: const TextStyle(
                  //       fontSize: 8,
                  //     )),
                  InkWell(
                    onTap: () async {
                      await MainController.to.saveVoteData(MainController.to.selectedCompetitions.value?.objectId, AuthController.to.parseUser.value?.objectId, e.objectId);
                      await MainController.to.fetchSubmissionData();
                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 10,bottom: 10),
                      child: const Text("VOTE",style: TextStyle(color: AppConst.tealMainColor,fontWeight: FontWeight.bold),),
                    ),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: (){
                MainController.to.openUrl((e.get("submission") as ParseFile).url);
              },
              child: Container(
                height: 60,
                width: 60,
                margin: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  color: AppConst.tealMainColor,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: const Icon(Icons.download_outlined,color: Colors.white,size: 35,),
              ),
            ),
             
          ],
        ),
      );
    }).toList(),
  );
}
