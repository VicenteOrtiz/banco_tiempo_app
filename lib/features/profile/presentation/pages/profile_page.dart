import 'package:banco_tiempo_app/features/profile/presentation/widgets/attribute_list.dart';
import 'package:banco_tiempo_app/features/profile/presentation/widgets/comment_list.dart';

import '../../../../cross_features/public_profile/domain/public_profile.dart';
import '../../../../cross_features/widgets/appbar_widget.dart';
import '../../../../cross_features/widgets/drawer_widget.dart';
import '../bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/presentation/app_theme.dart';
import '../../../../secrets.dart';
import '../../domain/profile_entity.dart';
import '../widgets/rating_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPrimary.primaryColor,
        elevation: 0,
        actions: [
          InkWell(
            child: Icon(Icons.settings),
            onTap: () {
              print("Pasa algo");
            },
          ),
          horizontalSpace10
        ],
      ),
      //drawer: DrawerWidget(context),
      body: BlocProvider<ProfileBloc>(
        create: (context) => ProfileBloc()..add(GetProfile()),
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoaded) {
              return profileLayout(context, state.profile, state.publicProfile);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget profileLayout(
      BuildContext context, Profile profile, PublicProfile publicProfile) {
    return Container(
      //width: double.infinity,
      decoration: BoxDecoration(color: ColorPrimary.primaryColor),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                right: 8.0, left: 8.0, top: 10, bottom: 40),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 79,
                    backgroundImage:
                        NetworkImage("https://${baseUrl}${profile.imagenUrl}"),
                    backgroundColor: Colors.white,
                  ),
                ),
                verticalSpace20,
                Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${profile.name} ${profile.lastName}",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    /* Text(
                      profile.name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w100),
                    ), */
                  ],
                ),
                //Icon(Icons.person)
              ],
            ),
          ),
          Expanded(
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  color: Colors.white,
                ),
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  //padding: EdgeInsets.all(1),
                  child: Column(
                    children: [
                      verticalSpace20,
                      _auxInfo("Rut", profile.rut, context),
                      verticalSpace20,
                      _auxInfo(
                          "Fecha de Nacimiento", profile.birthday, context),
                      /* Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _auxInfo("Rut", profile.rut, context),
                          _auxInfo(
                              "Fecha de Nacimiento", profile.birthday, context),
                        ],
                      ), */
                      SizedBox(height: 15),
                      _auxInfo("Correo", profile.email, context, isLarge: true),
                      //Divider(),
                      _auxInfo("Dirección", profile.address, context,
                          isLarge: true),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Divider(
                          color: ColorPrimary.primaryColor,
                        ),
                      ),
                      AttributeList(publicProfile.cualidades),
                      RatingWidget(publicProfile.puntaje),
                      CommentList(publicProfile.comentarios),
                      verticalSpace40,
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }

  Widget _auxInfo(String title, String content, BuildContext context,
      {bool isLarge = false}) {
    return Container(
      /* width: isLarge
          ? MediaQuery.of(context).size.width * 0.6
          : MediaQuery.of(context).size.width * 0.4, */
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.,
          children: [
            Text(title,
                style: titleLable.copyWith(
                  color: ColorPrimary.primaryColor,
                  fontSize: 25,
                )),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                content,
                textAlign: TextAlign.center,
                style: labels.copyWith(
                  fontSize: 20,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
