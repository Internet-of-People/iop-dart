import 'package:iop_sdk/ssi.dart';

class ContentResolver<T> {
  final Future<T> Function(ContentId contentId) _downloader;

  ContentResolver(this._downloader);

  Future<T> resolve(Content<T> content) async {
    if(content.content != null) {
      return content.content!;
    }

    return await _downloader(content.contentId!);
  }

  Future<Map<ContentId, T>> resolveContentIds(List<ContentId> ids) async {
    final resolverFuts = ids.map((id) async => await resolve(Content(null, id))).toList();
    final result = await Future.wait(resolverFuts, eagerError: true);
    final map = <ContentId, T>{};
    for(var i=0;i<ids.length;i++){
      map[ids[i]] = result[i];
    }

    return map;
  }

  Future<List<T>> resolveContents(List<Content<T>> contents) async {
    final resolverFuts = contents
      .map((content) async => resolve(content))
      .toList();

    return await Future.wait(resolverFuts, eagerError: true);
  }
}
