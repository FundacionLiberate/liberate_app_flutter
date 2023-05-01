import 'dart:io';
import 'package:flutter/material.dart';
import 'package:liberate/services/database_service.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constant/assetImages.dart';
import '../../constant/strings.dart';
import '../../services/storage_service.dart';
import '../generic_widgets/loading_widget.dart';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class CategoryTypeFilesScreen extends StatefulWidget {
  String category;
  CategoryTypeFilesScreen({Key? key, required this.category}) : super(key: key);

  @override
  State<CategoryTypeFilesScreen> createState() => _CategoryTypeFilesScreenState();
}

class _CategoryTypeFilesScreenState extends State<CategoryTypeFilesScreen> {

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final databaseService= Provider.of<DatabaseService>(context);
    final storageService= Provider.of<StorageService>(context);
    return Scaffold(
        appBar: AppBar(
            title: SizedBox(
              height: 200,
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(widget.category, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Image.asset(AssetImages.logoPath),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  )
                ],
              ),
            )
        ),
        body: Stack(
          children: [
            Padding(
                padding: const EdgeInsets.all(15),
                child: StreamBuilder(
                  stream: databaseService.getCategoryTypeFiles(widget.category),
                  builder: (BuildContext context, AsyncSnapshot snapshot){
                    if(!snapshot.hasData || snapshot.hasError){
                      return Container();
                    }else{
                      print(snapshot.data.docs.length);
                      return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Expanded(
                                flex: 10,
                                child:   Text(
                                  snapshot.data.docs[index]["nombre"],
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),


                              Expanded(
                                flex: 1,
                                child:  InkWell(
                                  child: const Icon(
                                    Icons.remove_red_eye,
                                    color: Colors.lightBlueAccent,
                                    size: 30,
                                  ),
                                  onTap: ()async{
                                    await launch('${snapshot.data.docs[index]["url"]}');
                                  },
                                )
                              ),
                              Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                      size: 30,
                                    ),
                                    onTap: ()async{
                                      try{
                                        setState(() {loading=true;});
                                        await databaseService.deleteType(snapshot.data.docs[index]["id"]);
                                        await storageService.deleteFile(snapshot.data.docs[index]["nombre"]);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              backgroundColor: Colors.green,
                                              content:  Text(
                                                Strings.completeDelete,
                                              ),
                                            )
                                        );
                                        setState(() {loading=false;});
                                      }catch(e){
                                        setState(() {loading=false;});
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              backgroundColor: Colors.red,
                                              content:  Text(
                                                Strings.errorTitle,
                                              ),
                                            )
                                        );
                                      }
                                    },
                                  )
                              )
                            ],
                          );
                        },
                      );
                    }
                  },
                )
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


  Future<void> downloadFile(String url, String fileName) async {
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;
    final directory =  await getDownloadsDirectory();
    final path = '${directory?.path}/$fileName';
    final file = File(path);
    await file.writeAsBytes(bytes);
    print('File downloaded at $path');
  }


}
