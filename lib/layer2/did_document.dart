import 'package:json_annotation/json_annotation.dart';
import 'package:morpheus_sdk/crypto/authentication.dart';
import 'package:morpheus_sdk/crypto/core.dart';
import 'package:morpheus_sdk/crypto/io.dart';
import 'package:morpheus_sdk/ssi/io.dart';

part 'did_document.g.dart';

@JsonSerializable(explicitToJson: true)
class KeyData {
  final int index;
  final AuthenticationData auth;
  final int validFromHeight;
  final int validUntilHeight;
  final bool valid;

  KeyData(
    this.index,
    this.auth,
    this.validFromHeight,
    this.validUntilHeight,
    this.valid,
  );

  factory KeyData.fromJson(Map<String, dynamic> json) =>
      _$KeyDataFromJson(json);

  Map<String, dynamic> toJson() => _$KeyDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class KeyRightHistoryPoint {
  final int height;
  final bool valid;

  KeyRightHistoryPoint(this.height, this.valid);

  factory KeyRightHistoryPoint.fromJson(Map<String, dynamic> json) =>
      _$KeyRightHistoryPointFromJson(json);

  Map<String, dynamic> toJson() => _$KeyRightHistoryPointToJson(this);
}

@JsonSerializable(explicitToJson: true)
class KeyRightHistory {
  final KeyLink keyLink;
  final List<KeyRightHistoryPoint> history;
  final bool valid;

  KeyRightHistory(this.keyLink, this.history, this.valid);

  factory KeyRightHistory.fromJson(Map<String, dynamic> json) =>
      _$KeyRightHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$KeyRightHistoryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DidDocumentData {
  final DidData did;
  final List<KeyData> keys;
  final Map<String, List<KeyRightHistory>> rights;
  final bool tombstoned;
  final int tombstonedAtHeight;
  final int queriedAtHeight;

  DidDocumentData(
    this.did,
    this.keys,
    this.rights,
    this.tombstoned,
    this.tombstonedAtHeight,
    this.queriedAtHeight,
  );

  factory DidDocumentData.fromJson(Map<String, dynamic> json) =>
      _$DidDocumentDataFromJson(json);

  Map<String, dynamic> toJson() => _$DidDocumentDataToJson(this);
}

class DidDocument {
  DidDocumentData _data;
  List<Authentication> _keys = [];

  DidDocument(this._data) {
    fromData(_data);
  }

  int get height => _data.queriedAtHeight;

  DidData get did => _data.did;

  void fromData(DidDocumentData data) {
    _data = data;
    _keys = data.keys
        .map(
          (keyData) => authenticationFromData(keyData.auth),
        )
        .toList();
  }

  bool hasRightAt(Authentication auth, String right, int height) {
    _ensureHeightIsKnown(height);

    final rightHistories = _data.rights[right] ?? [];
    for (final rightHistory in rightHistories) {
      final idx = _getKeyIdx(rightHistory.keyLink);
      final keyData = _data.keys[idx];

      if (!_isKeyValidAt(keyData, height)) {
        continue;
      }

      if (!isSameAuthentication(_keys[idx], auth)) {
        continue;
      }

      return _isRightValidAt(rightHistory.history, height);
    }

    return false;
  }

  bool isTombstonedAt(int height) {
    _ensureHeightIsKnown(height);

    final tHeight = _data.tombstonedAtHeight ?? -1;

    if (height >= tHeight) {
      return true;
    }
    return false;
  }

  DidDocumentData toData() => _data;

  void _ensureHeightIsKnown(int height) {
    if (height > this.height) {
      throw Exception(
        'Cannot query at $height, latest block seen was ${this.height}',
      );
    }
  }

  int _getKeyIdx(KeyLink keyLink) {
    if (!keyLink.value.startsWith('#')) {
      throw Exception(
        'Only did-internal keyLinks are supported yet. Found $keyLink',
      );
    }

    return int.parse(keyLink.value.substring(1));
  }

  bool _isKeyValidAt(KeyData keyData, int height) {
    if (keyData.validFromHeight != null && height < keyData.validFromHeight) {
      return false;
    }

    if (keyData.validUntilHeight != null &&
        height >= keyData.validUntilHeight) {
      return false;
    }

    return true;
  }

  bool _isRightValidAt(List<KeyRightHistoryPoint> history, int height) {
    var validAtHeight = false;

    for (final point in history) {
      if (point.height != null && point.height > height) {
        break;
      }
      validAtHeight = point.valid;
    }

    return validAtHeight;
  }
}
