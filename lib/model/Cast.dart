import 'package:movies_app/common/MediaProvider.dart';
import 'package:movies_app/common/Util.dart';

class Cast{
  int id;
  String name;
  String profilePath;


  factory Cast(Map jsonMap, MediaType mediaType){
    try{
      return Cast.deserialize(jsonMap, mediaType);
    }catch(ex){
      throw ex;
    }

  }

  String getCastUrl() => getMediumPictureUrl(this.profilePath);

  Cast.deserialize(Map jsonMap, MediaType mediaType):
    id = jsonMap[mediaType == MediaType.movie ? "cast_id": "id"].toInt(),
    name = jsonMap["name"],
    profilePath = jsonMap["profile_path"];
}