import 'package:flutter/material.dart';
import 'package:flutter_agenda/database_helper.dart';

class ListaCitasPantalla extends StatefulWidget {
  const ListaCitasPantalla({super.key});

  @override
  State<ListaCitasPantalla> createState() => _ListaCitasPantallaState();
}

class _ListaCitasPantallaState extends State<ListaCitasPantalla> {
 List<Map<String, dynamic>> citas = [];

  @override
  void initState() {
    super.initState();
    cargarCitas();
  }


    Future<void> cargarCitas() async {
    final datos = await DatabaseHelper.instance.obtenerActividad();
    
    setState(() {
      citas = datos;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Citas Registradas")),
      body: ListView.builder(
              itemCount: citas.length,
              itemBuilder: (context, index) {
                final cita = citas[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        cita['id'].toString(),
                      ),
                    ),
                    title: Text(cita['titulo']),
                    subtitle: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text("Fecha: ${cita['fecha']}"),
                        const SizedBox(height: 5),
                        Text(cita['detalle']),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text(
                                'Eliminar cita'),
                            content: const Text(
                                '¿Desea eliminar esta cita?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  
                                },
                                child: const Text('Cancelar'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                },
                                child: const Text('Eliminar'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}