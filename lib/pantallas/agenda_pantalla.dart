import 'package:flutter/material.dart';
import 'package:flutter_agenda/database_helper.dart';

class AgendaPantalla extends StatefulWidget {
  const AgendaPantalla({super.key});

  @override
  State<AgendaPantalla> createState() => _AgendaPantallaState();
  }

class _AgendaPantallaState extends State<AgendaPantalla> {
  final textFecha = TextEditingController();
  final textTitulo = TextEditingController();
  final textdetalles = TextEditingController();





  Future<void> guardarActividad(BuildContext context) async{
    //ingresamos nuestro primer registro
    Map<String, dynamic> nuevaActividad = {
      'fecha' : textFecha.text,
      'titulo' : textTitulo.text,
      'detalle' : textdetalles.text,
    };

    try {
      // Llamamos al método que acabamos de crear en el Helper
      int idReg = await DatabaseHelper.instance.insertarActividad(nuevaActividad);

      if (idReg > 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Actividad #$idReg guardada en local!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al guardar Actividad: $e'),
          backgroundColor: Colors.red,
        ),
      );

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,     
        title: Text('Agenda', style: TextStyle(letterSpacing: 10),),
      ),


      body: Padding(
        padding: EdgeInsetsGeometry.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 60),
            Text('Nuevo Evento'),
        
            SizedBox(height: 20,),
          
            TextField(
              controller: textFecha,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Fecha'
              ),
              onTap: () async{
                DateTime? fecha = await showDatePicker(
                  context: context, 
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2024), 
                  lastDate: DateTime(2100)
                  );
                  if (fecha != null){
                    textFecha.text=
                    "${fecha.day}/${fecha.month}/${fecha.year}";  
                  }
              },
            ),
        
            SizedBox(height: 50),
        
            // ignore: avoid_unnecessary_containers
            
            TextField(
              controller: textTitulo,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Titulo'
              ),
            ),
        
           SizedBox(height: 50),
          
            TextField(
              controller: textdetalles,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Detalles'
              ),
            ),
        
            SizedBox(height: 40,),
        
           
                 ElevatedButton(
                onPressed: () async {
                  await guardarActividad(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white
                ), 
                child: Icon(Icons.save)),
          ],
        ),
      ),
    );
  }
}