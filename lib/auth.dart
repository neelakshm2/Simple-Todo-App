import 'package:appwrite/appwrite.dart';

Client client = Client()
    .setEndpoint(
        'https://8080-appwrite-integrationfor-c82ozed8wrc.ws-us94.gitpod.io/v1') // Your Appwrite Endpoint
    .setProject('6433c64b9d27f40e5604') // Your project ID
    .setSelfSigned(
        status: true); // For self signed certificates, only use for development

Account account = Account(client);

//Signing Up User

Future<String> createUser(String name, String userName, String password) async {
  try {
    final user = await account.create(
      userId: ID.unique(),
      email: userName,
      password: password,
      name: name,
    );

    return ("success");
  } on AppwriteException catch (e) {
    return (e.message.toString());
  }
}

//login User
Future<String> loginUser(String userName, String password) async {
  try {
    final user = await account.createEmailSession(
      email: userName,
      password: password,
    );
    return ("logged");
  } on AppwriteException catch (e) {
    return (e.message.toString());
  }
}

//logout User
Future logoutUser() async {
  try {
    await account.deleteSession(sessionId: 'current');
    print("User Logged Out");
  } catch (e) {
    print(e);
  }
}

//Checking if user has logged in
Future checkUserAuth() async {
  try {
    await account.getSession(sessionId: 'current');
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}
