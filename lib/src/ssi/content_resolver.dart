import 'package:iop_sdk/ssi.dart';

class ContentResolver<T> {
  final Future<T> Function(ContentId contentId) _downloader;

  ContentResolver(this._downloader);

  Future<T> resolve(ContentId id) async {
    return await _downloader(id);
  }

  Future<Map<ContentId, T>> resolveByContentIds(List<ContentId> ids) async {
    final contentResolvers = ids.map((id) async => await resolve(id)).toList();
    final contents = await Future.wait(contentResolvers);

    final contentIdContentMap = <ContentId, T>{};
    for(var i=0;i<contents.length;i++) {
      contentIdContentMap[ids[i]] = contents[i];
    }

    return contentIdContentMap;
  }
}
