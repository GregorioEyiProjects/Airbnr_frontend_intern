import 'package:airbnbr/database/object_box_model/entities/UserOBModel.dart';
import 'package:airbnbr/objectbox.g.dart';
import 'package:objectbox/objectbox.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class Objectboxdb {
  //Initialize the Store
  late Store store;

  //Static variable to hold the instance of the Objectboxdb
  static Objectboxdb? _instance;

  //Static method to get the instance of the Objectboxdb
  static Future<Objectboxdb> getInstance() async {
    //If the instance is null, create a new instance ( _instance ??= Objectboxdb() );
    if (_instance == null) {
      _instance = Objectboxdb();
      await _instance!.init(); //Initialize the instance
    }
    return _instance!;
  }

  //Initialize the Objectboxdb
  Future<void> init() async {
    //Get the directory path where the database will be stored
    var directory = await getApplicationDocumentsDirectory();

    //Create a folder in the directory path
    var folderLocation = p.join(directory.path, 'airbnbr_db');

    /* Both lines of code are essentially performing the same operation */
    //Directly accessing the store variable: (With line, i have to )
    store = await openStore(directory: folderLocation);
    //Accessing the store variable through the _instance variable
    //_instance!.store = await openStore(directory: folderLocation);
  }

  //Insert a user
  //Remove all users
  Future<void> removeAllUsers() async {
    //Get the box
    final userBox = Box<UserOB>(store);
    //Remove all users
    userBox.removeAll();
    print('All users have been removed from the database.');
  }
}
