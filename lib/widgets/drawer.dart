import 'package:flutter/material.dart';
import 'package:sgpjtjcn/screen/settings.dart';
import 'package:sgpjtjcn/util/constants.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({Key? key}) : super(key: key);

  bool isFuncionario = true;
  bool isAdvogado = false;

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
                      '',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                )),
            !isFuncionario
                ? ListTile(
                    title: const Text(
                      'Requerer',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    hoverColor: primary,
                    onTap: () {
                      Navigator.pushNamed(context, '/requerer');
                    },
                  )
                : Container(),
            isFuncionario
                ? ListTile(
                    title: const Text(
                      'Entradas',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    hoverColor: primary,
                    onTap: () {
                      Navigator.pushNamed(context, '/entradas');
                    },
                  )
                : Container(),
            !isFuncionario
                ? ListTile(
                    title: const Text(
                      'Meus Processos',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    hoverColor: primary,
                    onTap: () {
                      Navigator.pushNamed(context, '/pending');
                    },
                  )
                : ListTile(
                    title: const Text(
                      'Processos Pendentes',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    hoverColor: primary,
                    onTap: () {
                      Navigator.pushNamed(context, '/pending');
                    },
                  ),
            isFuncionario
                ? ListTile(
                    title: const Text('Criar Processos',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    hoverColor: primary,
                    onTap: () {
                      Navigator.pushNamed(context, '/process');
                    },
                  )
                : Container(),
            isFuncionario
                ? ListTile(
                    title: const Text('Relatário',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    hoverColor: primary,
                    onTap: () {
                      Navigator.pushNamed(context, '/report');
                    },
                  )
                : Container(),
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
