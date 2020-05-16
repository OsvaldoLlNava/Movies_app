import 'package:flutter/material.dart';
import 'package:movies_app/common/MediaProvider.dart';
import 'package:movies_app/model/Media.dart';
import 'dart:ui' as ui;
import 'package:movies_app/cast_scroller.dart';


class MediaDetail extends StatelessWidget{

  final Media media;
  final MediaProvider provider;

  MediaDetail(this.media, this.provider);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.network(
            media.backdropPath != "" ? media.getBackdropUrl():"https://image.freepik.com/foto-gratis/representacion-3d-signo-interrogacion-blanco-aislado-fondo-negro_42071-126.jpg",
            fit: BoxFit.cover

          ),
          BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(color: Colors.black.withOpacity(0.5)),
          ),

          SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Container(
                      width: 390,
                      height: 390,
                      child: Image.network(media.getPosterUrl()),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(media.getPosterUrl())
                      ),
                      boxShadow: [BoxShadow(
                        color: Colors.black,
                        blurRadius: 20.0,
                        offset: Offset(0.0, 10.0))],
                    ),
                  ),

                  SizedBox(height: 20.0,),
                  
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5.0,),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            media.title, 
                            maxLines: 2, 
                            overflow: TextOverflow.fade, 
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontFamily: "Arvo"),),
                    ),
                    Text(
                      "${media.voteAverage.toString()}/10", 
                      style: TextStyle(
                        color:Colors.white, 
                        fontSize: 20, 
                        fontFamily: "Arvo"),)
                    ],
                    )
                  ),
                  Container(height: 10,),
                  Column(
                    children: <Widget>[
                      Text(
                        media.overview,
                        style: TextStyle(color: Colors.white, fontSize: 17, fontFamily: "Arvo"),
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,                      )
                    ],
                  ),
                  Container(height: 15,),
                  CastController(provider: provider, mediaId: media.id,)
                ],
              ),
              
            ),
          ),
        ],
      ),
    );
  }
}