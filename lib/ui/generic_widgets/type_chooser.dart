import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant/strings.dart';
import '../../services/database_service.dart';
import 'loading_widget.dart';


class TypeChooser extends StatelessWidget {
  String? selectedType;
  Function(String?) onChangedType;
  TypeChooser({Key? key, required this.selectedType, required this.onChangedType}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final databaseService= Provider.of<DatabaseService>(context);


    return  Container(
        padding: const EdgeInsets.all(7),
        child:  StreamBuilder(
          stream: databaseService.getStreamTipos(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.hasError  || !snapshot.hasData){
              return LoadingWidget();
            }else{
              return Row(
                children: [
                  DropdownButton<String>(
                      hint:   Text(Strings.typeTitle, style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      )),
                      value: selectedType,
                      onChanged: onChangedType,
                      items: getTypesNames(snapshot).map((String typ) {
                        return DropdownMenuItem<String>(
                            value: typ,
                            child: Text(
                              typ,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black
                              ),
                            ));
                      }).toList()
                  ),
                ],
              );
            }
          },
        )
    );
  }


  List<String> getTypesNames(AsyncSnapshot snapshot){
    List<String> names =[];
    for (var doc in snapshot.data.docs) {
      names.add(doc["nombre"]);
    }
    return names;
  }

}


