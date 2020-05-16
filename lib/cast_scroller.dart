import 'package:flutter/material.dart';
import 'package:movies_app/common/MediaProvider.dart';
import 'package:movies_app/model/Cast.dart';

class CastController extends StatefulWidget{
  final int mediaId;
  final MediaProvider provider;

  CastController({this.provider, this.mediaId});


  @override
  _CastControllerState createState() => _CastControllerState();
}

class _CastControllerState extends State<CastController>{
  
  final List<Cast> _cast = List<Cast>();

  @override
  void initState(){
    super.initState();
    loadCasts();
  }

  void loadCasts() async {
    var results = await widget.provider.fetchCast(widget.mediaId);

    setState(() {
      _cast.addAll(results);
    });
  }

  Widget _builderCasts(BuildContext context, int index){
    var cast = _cast[index];
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(cast.profilePath != null ? cast.getCastUrl(): "https://definicion.de/wp-content/uploads/2019/06/perfildeusuario.jpg"),
            radius: 35,
          ),
          Padding(padding: EdgeInsets.only(top:8.0), child: Text(cast.name))
        ],
      ),);
  }

  @override
  Widget build(BuildContext context){
    return Column(
      children: <Widget>[
        SizedBox.fromSize(
          size: const Size.fromHeight(180.0),
          child: ListView.builder(
            itemCount: _cast.length,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(top: 12.0, left: 20.0),
            itemBuilder: _builderCasts
          ),
        ),
      ],

    );
    
  }
}