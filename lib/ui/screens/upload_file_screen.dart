import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:liberate/model/entities/liberate_type.dart';
import 'package:liberate/services/storage_service.dart';
import 'package:provider/provider.dart';
import '../../constant/strings.dart';
import '../../services/database_service.dart';
import '../generic_widgets/loading_widget.dart';
import '../generic_widgets/type_chooser.dart';


class UploadFileScreen extends StatefulWidget {
  const UploadFileScreen({Key? key}) : super(key: key);

  @override
  State<UploadFileScreen> createState() => _UploadFileScreenState();
}

class _UploadFileScreenState extends State<UploadFileScreen> {
  final TextEditingController _fileNameController = TextEditingController();
  String? _fileName;
  String? selectedType;
  bool loading = false;
  Future<FilePickerResult?> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(withData: true);
    if (result != null) {
      setState(() {
        _fileName = result.files.single.name;
        _fileNameController.text = _fileName!;
      });
    }
    return result;
  }
  @override
  Widget build(BuildContext context) {
    final databaseService= Provider.of<DatabaseService>(context);
    final storageService= Provider.of<StorageService>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.close, color: Colors.red,),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child:  Row(
                  children: [

                    Expanded(
                      flex: 1,
                      child: Text(
                        "${Strings.fileTitle}:",
                        style: const TextStyle(fontSize: 18,color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),

                    Expanded(
                      flex: 3,
                      child: Text(
                        _fileName ?? Strings.chooseFile,
                        style: const TextStyle(fontSize: 16,color: Colors.black),
                      ),
                    ),

                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child:  Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        "${Strings.typeTitle}:",
                        style: const TextStyle(fontSize: 18,color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),


                    Expanded(
                        flex: 3,
                        child: TypeChooser(
                          selectedType: selectedType,
                          onChangedType: (type) {
                            setState(() {
                              selectedType = type!;
                            });
                          },
                        )
                    ),

                  ],
                ),
              ),

              SizedBox(
                width: 120,
                child:  ElevatedButton(
                  onPressed: ()async{
                    if(selectedType !=null){

                      setState(() {loading=true;});

                      try{
                        FilePickerResult? pickedFile = await _pickFile();
                        if(pickedFile!=null){
                          final file = File(pickedFile.files.single.path!);
                          String url = await storageService.uploadFile("/Archivos/$_fileName", file);
                          LiberateType type= LiberateType.newType(_fileName!, selectedType!, url);
                          await databaseService.addType(type);

                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.green,
                                content:  Text(
                                  Strings.completeUpload,
                                ),
                              )
                          );

                          Navigator.pop(context);
                          setState(() {loading=false;});

                        }else{
                          setState(() {loading=false;});
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red,
                                content:  Text(
                                  Strings.filePickError,
                                ),
                              )
                          );
                        }

                      }catch(e){
                        setState(() {loading=false;});
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content:  Text(
                                Strings.filePickError,
                              ),
                            )
                        );
                      }


                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content:  Text(
                              Strings.emptyTypeErrorTitle,
                            ),
                          )
                      );
                    }
                  },
                  child: const Icon(
                    Icons.upload,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),

          Positioned(
            child: loading
                ? LoadingWidget()
                : Container(),
          ),

        ],
      )
    );
  }
}
