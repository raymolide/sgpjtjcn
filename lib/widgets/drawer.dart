import 'package:flutter/material.dart';
import 'package:sgpjtjcn/screen/settings.dart';
import 'package:sgpjtjcn/util/constants.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        backgroundColor: secundaria,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFFc75b39),
                ),
                child: Center(
                  child: ListTile(
                    leading: Icon(Icons.person, size: 50, color: Colors.white),
                    title: Text(
                      'Raimundo Molide',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    subtitle: Text(
                      'Juiz',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                )),
            ListTile(
              title: const Text(
                'Pendentes',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              hoverColor: primary,
              onTap: () {
                Navigator.pushNamed(context, '/');
              },
            ),
            ListTile(
              title: const Text('Criar Processos',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              hoverColor: primary,
              onTap: () {
                Navigator.pushNamed(context, '/process');
              },
            ),
            ListTile(
              title: const Text('Relatário',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              hoverColor: primary,
              onTap: () {
                Navigator.pushNamed(context, '/report');
              },
            ),
            ListTile(
              title: const Text('Conta',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              hoverColor: primary,
              onTap: () => showDialog<String>(
                barrierColor: secundaria,
                context: context,
                builder: (BuildContext context) => AlertDialog(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Perfil'),
                        InkWell(
                          child: Icon(
                            Icons.close_rounded,
                            color: primary,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                    content: MySettings()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
