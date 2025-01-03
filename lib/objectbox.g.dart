// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again
// with `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'
    as obx_int; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart' as obx;
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'database/object_box_model/entities/Location_O_Box.dart';
import 'database/object_box_model/entities/RoomOBModel.dart';
import 'database/object_box_model/entities/UserOBModel.dart';
import 'database/object_box_model/entities/userFavRooms.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <obx_int.ModelEntity>[
  obx_int.ModelEntity(
      id: const obx_int.IdUid(5, 7747724712943564244),
      name: 'RoomOB',
      lastPropertyId: const obx_int.IdUid(17, 8753780195802096363),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 6312709080681933660),
            name: 'id',
            type: 6,
            flags: 129),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 5726215036407961112),
            name: 'name',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 7881944165335453516),
            name: 'price',
            type: 8,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 8886024056402757912),
            name: 'rating',
            type: 8,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(5, 7569215754004512837),
            name: 'bedNumbers',
            type: 6,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(6, 178854923755931348),
            name: 'reviewNumbers',
            type: 6,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(7, 5335821829173199242),
            name: 'roomImages',
            type: 30,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(8, 1476037705861780652),
            name: 'vendorName',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(9, 1480324157585633065),
            name: 'yearsHosting',
            type: 6,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(10, 196250874447787332),
            name: 'vendorProfession',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(11, 4581666040113228268),
            name: 'authorImage',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(12, 3219077870239713468),
            name: 'locationName',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(13, 8142282418440620282),
            name: 'date',
            type: 10,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(14, 6230735350825289298),
            name: 'isActive',
            type: 1,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(15, 5846027037057264242),
            name: 'description',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(16, 5065577032819898192),
            name: 'localtionDataId',
            type: 11,
            flags: 520,
            indexId: const obx_int.IdUid(2, 2627266253664584719),
            relationTarget: 'LocationOB'),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(17, 8753780195802096363),
            name: 'mongoRoomId',
            type: 9,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[]),
  obx_int.ModelEntity(
      id: const obx_int.IdUid(7, 412722712270769109),
      name: 'UserFavoriteRooms',
      lastPropertyId: const obx_int.IdUid(4, 4637185327405087543),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 7463564137606913292),
            name: 'id',
            type: 6,
            flags: 129),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 2700283543472420694),
            name: 'userId',
            type: 6,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 7886854334430888876),
            name: 'roomId',
            type: 6,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 4637185327405087543),
            name: 'createdAt',
            type: 10,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[]),
  obx_int.ModelEntity(
      id: const obx_int.IdUid(8, 6177229634773767026),
      name: 'UserOB',
      lastPropertyId: const obx_int.IdUid(12, 3122944944695595943),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 4783680027168924317),
            name: 'id',
            type: 6,
            flags: 129),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 7649138873675959022),
            name: 'mongoUserId',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 6485311616914222468),
            name: 'firstName',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 5846641252534598822),
            name: 'lastName',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(5, 792473414221146360),
            name: 'dateOfBirth',
            type: 10,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(6, 2658738559138909992),
            name: 'email',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(7, 9150075211133225165),
            name: 'contact',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(8, 224933734359115854),
            name: 'password',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(9, 443880318862135751),
            name: 'profileImage',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(10, 7033399833034288469),
            name: 'role',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(11, 7618177450346852753),
            name: 'createdAt',
            type: 10,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(12, 3122944944695595943),
            name: 'updatedAt',
            type: 10,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[]),
  obx_int.ModelEntity(
      id: const obx_int.IdUid(9, 7875067583487514368),
      name: 'LocationOB',
      lastPropertyId: const obx_int.IdUid(4, 6131584352045644398),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 6190401330312554562),
            name: 'id',
            type: 6,
            flags: 129),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 7006921639940840456),
            name: 'mongoRoomId',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 4139100330091928160),
            name: 'latitude',
            type: 8,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 6131584352045644398),
            name: 'longitude',
            type: 8,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[])
];

/// Shortcut for [obx.Store.new] that passes [getObjectBoxModel] and for Flutter
/// apps by default a [directory] using `defaultStoreDirectory()` from the
/// ObjectBox Flutter library.
///
/// Note: for desktop apps it is recommended to specify a unique [directory].
///
/// See [obx.Store.new] for an explanation of all parameters.
///
/// For Flutter apps, also calls `loadObjectBoxLibraryAndroidCompat()` from
/// the ObjectBox Flutter library to fix loading the native ObjectBox library
/// on Android 6 and older.
Future<obx.Store> openStore(
    {String? directory,
    int? maxDBSizeInKB,
    int? maxDataSizeInKB,
    int? fileMode,
    int? maxReaders,
    bool queriesCaseSensitiveDefault = true,
    String? macosApplicationGroup}) async {
  await loadObjectBoxLibraryAndroidCompat();
  return obx.Store(getObjectBoxModel(),
      directory: directory ?? (await defaultStoreDirectory()).path,
      maxDBSizeInKB: maxDBSizeInKB,
      maxDataSizeInKB: maxDataSizeInKB,
      fileMode: fileMode,
      maxReaders: maxReaders,
      queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
      macosApplicationGroup: macosApplicationGroup);
}

/// Returns the ObjectBox model definition for this project for use with
/// [obx.Store.new].
obx_int.ModelDefinition getObjectBoxModel() {
  final model = obx_int.ModelInfo(
      entities: _entities,
      lastEntityId: const obx_int.IdUid(9, 7875067583487514368),
      lastIndexId: const obx_int.IdUid(2, 2627266253664584719),
      lastRelationId: const obx_int.IdUid(0, 0),
      lastSequenceId: const obx_int.IdUid(0, 0),
      retiredEntityUids: const [
        4917190004449752312,
        7202278025822394323,
        3463601388008821113,
        2663420647659323758,
        6981604499755645924
      ],
      retiredIndexUids: const [],
      retiredPropertyUids: const [
        7044988631595062363,
        5615752644791754396,
        3297483856214139559,
        767440936092554521,
        7677447083005777399,
        5399293204943354502,
        1344140945122154010,
        2395905018165832663,
        7079449029828322476,
        96225532624804367,
        2799830184709052808,
        7954617473884594720,
        6960225503853726624,
        4734534155192218878,
        1805272576112017943,
        7381280166104174349,
        565592845782306876,
        2414588863698305143,
        8610120808475242834,
        1226919929882962062,
        5099102198337960943,
        7177683697030470928,
        4292416621876169122,
        8947453078582537568,
        2404696663916090067,
        4701889871457702763,
        5373421823494201827,
        2888292606048140628,
        4469833754710526169,
        1594357782016536985,
        4549931753830407398,
        8688862140570745517,
        6753897230514193229,
        6048254140240039498,
        938537233958993765,
        3988095966554290416,
        2176672888366587291,
        2661787082434127166,
        2718634718033263908,
        8378270717232383680,
        2459728430314415023,
        315960035662465648,
        6314156896850207743,
        3099677569853995082,
        6300693485986529242,
        2196674909696025177
      ],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, obx_int.EntityDefinition>{
    RoomOB: obx_int.EntityDefinition<RoomOB>(
        model: _entities[0],
        toOneRelations: (RoomOB object) => [object.localtionData],
        toManyRelations: (RoomOB object) => {},
        getId: (RoomOB object) => object.id,
        setId: (RoomOB object, int id) {
          object.id = id;
        },
        objectToFB: (RoomOB object, fb.Builder fbb) {
          final nameOffset = fbb.writeString(object.name);
          final roomImagesOffset = fbb.writeList(
              object.roomImages.map(fbb.writeString).toList(growable: false));
          final vendorNameOffset = fbb.writeString(object.vendorName);
          final vendorProfessionOffset =
              fbb.writeString(object.vendorProfession);
          final authorImageOffset = fbb.writeString(object.authorImage);
          final locationNameOffset = fbb.writeString(object.locationName);
          final descriptionOffset = object.description == null
              ? null
              : fbb.writeString(object.description!);
          final mongoRoomIdOffset = fbb.writeString(object.mongoRoomId);
          fbb.startTable(18);
          fbb.addInt64(0, object.id ?? 0);
          fbb.addOffset(1, nameOffset);
          fbb.addFloat64(2, object.price);
          fbb.addFloat64(3, object.rating);
          fbb.addInt64(4, object.bedNumbers);
          fbb.addInt64(5, object.reviewNumbers);
          fbb.addOffset(6, roomImagesOffset);
          fbb.addOffset(7, vendorNameOffset);
          fbb.addInt64(8, object.yearsHosting);
          fbb.addOffset(9, vendorProfessionOffset);
          fbb.addOffset(10, authorImageOffset);
          fbb.addOffset(11, locationNameOffset);
          fbb.addInt64(12, object.date.millisecondsSinceEpoch);
          fbb.addBool(13, object.isActive);
          fbb.addOffset(14, descriptionOffset);
          fbb.addInt64(15, object.localtionData.targetId);
          fbb.addOffset(16, mongoRoomIdOffset);
          fbb.finish(fbb.endTable());
          return object.id ?? 0;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final idParam =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 4);
          final mongoRoomIdParam =
              const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 36, '');
          final nameParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 6, '');
          final priceParam =
              const fb.Float64Reader().vTableGet(buffer, rootOffset, 8, 0);
          final ratingParam = const fb.Float64Reader()
              .vTableGetNullable(buffer, rootOffset, 10);
          final bedNumbersParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 12, 0);
          final reviewNumbersParam =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 14);
          final roomImagesParam = const fb.ListReader<String>(
                  fb.StringReader(asciiOptimization: true),
                  lazy: false)
              .vTableGet(buffer, rootOffset, 16, []);
          final vendorNameParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 18, '');
          final yearsHostingParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 20, 0);
          final vendorProfessionParam =
              const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 22, '');
          final authorImageParam =
              const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 24, '');
          final locationNameParam =
              const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 26, '');
          final isActiveParam =
              const fb.BoolReader().vTableGet(buffer, rootOffset, 30, false);
          final descriptionParam =
              const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 32);
          final dateParam = DateTime.fromMillisecondsSinceEpoch(
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 28, 0));
          final object = RoomOB(
              id: idParam,
              mongoRoomId: mongoRoomIdParam,
              name: nameParam,
              price: priceParam,
              rating: ratingParam,
              bedNumbers: bedNumbersParam,
              reviewNumbers: reviewNumbersParam,
              roomImages: roomImagesParam,
              vendorName: vendorNameParam,
              yearsHosting: yearsHostingParam,
              vendorProfession: vendorProfessionParam,
              authorImage: authorImageParam,
              locationName: locationNameParam,
              isActive: isActiveParam,
              description: descriptionParam,
              date: dateParam);
          object.localtionData.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 34, 0);
          object.localtionData.attach(store);
          return object;
        }),
    UserFavoriteRooms: obx_int.EntityDefinition<UserFavoriteRooms>(
        model: _entities[1],
        toOneRelations: (UserFavoriteRooms object) => [],
        toManyRelations: (UserFavoriteRooms object) => {},
        getId: (UserFavoriteRooms object) => object.id,
        setId: (UserFavoriteRooms object, int id) {
          object.id = id;
        },
        objectToFB: (UserFavoriteRooms object, fb.Builder fbb) {
          fbb.startTable(5);
          fbb.addInt64(0, object.id ?? 0);
          fbb.addInt64(1, object.userId);
          fbb.addInt64(2, object.roomId);
          fbb.addInt64(3, object.createdAt.millisecondsSinceEpoch);
          fbb.finish(fbb.endTable());
          return object.id ?? 0;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final idParam =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 4);
          final userIdParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0);
          final roomIdParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 8, 0);
          final createdAtParam = DateTime.fromMillisecondsSinceEpoch(
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 10, 0));
          final object = UserFavoriteRooms(
              id: idParam,
              userId: userIdParam,
              roomId: roomIdParam,
              createdAt: createdAtParam);

          return object;
        }),
    UserOB: obx_int.EntityDefinition<UserOB>(
        model: _entities[2],
        toOneRelations: (UserOB object) => [],
        toManyRelations: (UserOB object) => {},
        getId: (UserOB object) => object.id,
        setId: (UserOB object, int id) {
          object.id = id;
        },
        objectToFB: (UserOB object, fb.Builder fbb) {
          final mongoUserIdOffset = fbb.writeString(object.mongoUserId);
          final firstNameOffset = fbb.writeString(object.firstName);
          final lastNameOffset = fbb.writeString(object.lastName);
          final emailOffset = fbb.writeString(object.email);
          final contactOffset = fbb.writeString(object.contact);
          final passwordOffset = fbb.writeString(object.password);
          final profileImageOffset = object.profileImage == null
              ? null
              : fbb.writeString(object.profileImage!);
          final roleOffset = fbb.writeString(object.role);
          fbb.startTable(13);
          fbb.addInt64(0, object.id ?? 0);
          fbb.addOffset(1, mongoUserIdOffset);
          fbb.addOffset(2, firstNameOffset);
          fbb.addOffset(3, lastNameOffset);
          fbb.addInt64(4, object.dateOfBirth.millisecondsSinceEpoch);
          fbb.addOffset(5, emailOffset);
          fbb.addOffset(6, contactOffset);
          fbb.addOffset(7, passwordOffset);
          fbb.addOffset(8, profileImageOffset);
          fbb.addOffset(9, roleOffset);
          fbb.addInt64(10, object.createdAt.millisecondsSinceEpoch);
          fbb.addInt64(11, object.updatedAt.millisecondsSinceEpoch);
          fbb.finish(fbb.endTable());
          return object.id ?? 0;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final idParam =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 4);
          final mongoUserIdParam =
              const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, '');
          final firstNameParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 8, '');
          final lastNameParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 10, '');
          final dateOfBirthParam = DateTime.fromMillisecondsSinceEpoch(
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 12, 0));
          final emailParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 14, '');
          final contactParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 16, '');
          final passwordParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 18, '');
          final profileImageParam =
              const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 20);
          final roleParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 22, '');
          final createdAtParam = DateTime.fromMillisecondsSinceEpoch(
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 24, 0));
          final updatedAtParam = DateTime.fromMillisecondsSinceEpoch(
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 26, 0));
          final object = UserOB(
              id: idParam,
              mongoUserId: mongoUserIdParam,
              firstName: firstNameParam,
              lastName: lastNameParam,
              dateOfBirth: dateOfBirthParam,
              email: emailParam,
              contact: contactParam,
              password: passwordParam,
              profileImage: profileImageParam,
              role: roleParam,
              createdAt: createdAtParam,
              updatedAt: updatedAtParam);

          return object;
        }),
    LocationOB: obx_int.EntityDefinition<LocationOB>(
        model: _entities[3],
        toOneRelations: (LocationOB object) => [],
        toManyRelations: (LocationOB object) => {},
        getId: (LocationOB object) => object.id,
        setId: (LocationOB object, int id) {
          object.id = id;
        },
        objectToFB: (LocationOB object, fb.Builder fbb) {
          final mongoRoomIdOffset = fbb.writeString(object.mongoRoomId);
          fbb.startTable(5);
          fbb.addInt64(0, object.id ?? 0);
          fbb.addOffset(1, mongoRoomIdOffset);
          fbb.addFloat64(2, object.latitude);
          fbb.addFloat64(3, object.longitude);
          fbb.finish(fbb.endTable());
          return object.id ?? 0;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final idParam =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 4);
          final mongoRoomIdParam =
              const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, '');
          final latitudeParam =
              const fb.Float64Reader().vTableGet(buffer, rootOffset, 8, 0);
          final longitudeParam =
              const fb.Float64Reader().vTableGet(buffer, rootOffset, 10, 0);
          final object = LocationOB(
              id: idParam,
              mongoRoomId: mongoRoomIdParam,
              latitude: latitudeParam,
              longitude: longitudeParam);

          return object;
        })
  };

  return obx_int.ModelDefinition(model, bindings);
}

/// [RoomOB] entity fields to define ObjectBox queries.
class RoomOB_ {
  /// See [RoomOB.id].
  static final id =
      obx.QueryIntegerProperty<RoomOB>(_entities[0].properties[0]);

  /// See [RoomOB.name].
  static final name =
      obx.QueryStringProperty<RoomOB>(_entities[0].properties[1]);

  /// See [RoomOB.price].
  static final price =
      obx.QueryDoubleProperty<RoomOB>(_entities[0].properties[2]);

  /// See [RoomOB.rating].
  static final rating =
      obx.QueryDoubleProperty<RoomOB>(_entities[0].properties[3]);

  /// See [RoomOB.bedNumbers].
  static final bedNumbers =
      obx.QueryIntegerProperty<RoomOB>(_entities[0].properties[4]);

  /// See [RoomOB.reviewNumbers].
  static final reviewNumbers =
      obx.QueryIntegerProperty<RoomOB>(_entities[0].properties[5]);

  /// See [RoomOB.roomImages].
  static final roomImages =
      obx.QueryStringVectorProperty<RoomOB>(_entities[0].properties[6]);

  /// See [RoomOB.vendorName].
  static final vendorName =
      obx.QueryStringProperty<RoomOB>(_entities[0].properties[7]);

  /// See [RoomOB.yearsHosting].
  static final yearsHosting =
      obx.QueryIntegerProperty<RoomOB>(_entities[0].properties[8]);

  /// See [RoomOB.vendorProfession].
  static final vendorProfession =
      obx.QueryStringProperty<RoomOB>(_entities[0].properties[9]);

  /// See [RoomOB.authorImage].
  static final authorImage =
      obx.QueryStringProperty<RoomOB>(_entities[0].properties[10]);

  /// See [RoomOB.locationName].
  static final locationName =
      obx.QueryStringProperty<RoomOB>(_entities[0].properties[11]);

  /// See [RoomOB.date].
  static final date =
      obx.QueryDateProperty<RoomOB>(_entities[0].properties[12]);

  /// See [RoomOB.isActive].
  static final isActive =
      obx.QueryBooleanProperty<RoomOB>(_entities[0].properties[13]);

  /// See [RoomOB.description].
  static final description =
      obx.QueryStringProperty<RoomOB>(_entities[0].properties[14]);

  /// See [RoomOB.localtionData].
  static final localtionData =
      obx.QueryRelationToOne<RoomOB, LocationOB>(_entities[0].properties[15]);

  /// See [RoomOB.mongoRoomId].
  static final mongoRoomId =
      obx.QueryStringProperty<RoomOB>(_entities[0].properties[16]);
}

/// [UserFavoriteRooms] entity fields to define ObjectBox queries.
class UserFavoriteRooms_ {
  /// See [UserFavoriteRooms.id].
  static final id =
      obx.QueryIntegerProperty<UserFavoriteRooms>(_entities[1].properties[0]);

  /// See [UserFavoriteRooms.userId].
  static final userId =
      obx.QueryIntegerProperty<UserFavoriteRooms>(_entities[1].properties[1]);

  /// See [UserFavoriteRooms.roomId].
  static final roomId =
      obx.QueryIntegerProperty<UserFavoriteRooms>(_entities[1].properties[2]);

  /// See [UserFavoriteRooms.createdAt].
  static final createdAt =
      obx.QueryDateProperty<UserFavoriteRooms>(_entities[1].properties[3]);
}

/// [UserOB] entity fields to define ObjectBox queries.
class UserOB_ {
  /// See [UserOB.id].
  static final id =
      obx.QueryIntegerProperty<UserOB>(_entities[2].properties[0]);

  /// See [UserOB.mongoUserId].
  static final mongoUserId =
      obx.QueryStringProperty<UserOB>(_entities[2].properties[1]);

  /// See [UserOB.firstName].
  static final firstName =
      obx.QueryStringProperty<UserOB>(_entities[2].properties[2]);

  /// See [UserOB.lastName].
  static final lastName =
      obx.QueryStringProperty<UserOB>(_entities[2].properties[3]);

  /// See [UserOB.dateOfBirth].
  static final dateOfBirth =
      obx.QueryDateProperty<UserOB>(_entities[2].properties[4]);

  /// See [UserOB.email].
  static final email =
      obx.QueryStringProperty<UserOB>(_entities[2].properties[5]);

  /// See [UserOB.contact].
  static final contact =
      obx.QueryStringProperty<UserOB>(_entities[2].properties[6]);

  /// See [UserOB.password].
  static final password =
      obx.QueryStringProperty<UserOB>(_entities[2].properties[7]);

  /// See [UserOB.profileImage].
  static final profileImage =
      obx.QueryStringProperty<UserOB>(_entities[2].properties[8]);

  /// See [UserOB.role].
  static final role =
      obx.QueryStringProperty<UserOB>(_entities[2].properties[9]);

  /// See [UserOB.createdAt].
  static final createdAt =
      obx.QueryDateProperty<UserOB>(_entities[2].properties[10]);

  /// See [UserOB.updatedAt].
  static final updatedAt =
      obx.QueryDateProperty<UserOB>(_entities[2].properties[11]);
}

/// [LocationOB] entity fields to define ObjectBox queries.
class LocationOB_ {
  /// See [LocationOB.id].
  static final id =
      obx.QueryIntegerProperty<LocationOB>(_entities[3].properties[0]);

  /// See [LocationOB.mongoRoomId].
  static final mongoRoomId =
      obx.QueryStringProperty<LocationOB>(_entities[3].properties[1]);

  /// See [LocationOB.latitude].
  static final latitude =
      obx.QueryDoubleProperty<LocationOB>(_entities[3].properties[2]);

  /// See [LocationOB.longitude].
  static final longitude =
      obx.QueryDoubleProperty<LocationOB>(_entities[3].properties[3]);
}
