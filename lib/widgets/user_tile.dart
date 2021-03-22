import 'package:flutter/material.dart';
import 'package:flutter_crud/modelos/user.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:provider/provider.dart';

class UserTile extends StatelessWidget {
  final User user;
  UserTile(this.user);
  @override
  Widget build(BuildContext context) {
    final avatar = user.avatarUrl == null || user.avatarUrl.isEmpty
        ? CircleAvatar(child: Icon(Icons.person))
        : CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl));
    return ListTile(
      leading: avatar,
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              color: Colors.green,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.USER_FORMA,
                  arguments: user,
                );
              },
            ),
            IconButton(
                icon: Icon(Icons.delete),
                color: Colors.red,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Excluir Usuário'),
                      content: Text('Tem certeza?'),
                      actions: <Widget>[
                        FlatButton(
                            child: Text('Não'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            }),
                        FlatButton(
                            child: Text('Sim'),
                            onPressed: () {
                              Provider.of<Users>(context, listen: false)
                                  .remove(user);
                              Navigator.of(context).pop();
                            }),
                      ],
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
