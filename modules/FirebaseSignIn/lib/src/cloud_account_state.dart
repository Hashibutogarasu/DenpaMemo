/// Sign-in state for the account's cloud (Firebase) identity. Whether this
/// state is still loading is conveyed by the surrounding `AsyncValue`
/// (see `firebaseSignInProvider`), not by a field here.
class CloudAccountState {
  const CloudAccountState({this.isSignedIn = false, this.email, this.uid});

  final bool isSignedIn;
  final String? email;
  final String? uid;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CloudAccountState &&
          runtimeType == other.runtimeType &&
          isSignedIn == other.isSignedIn &&
          email == other.email &&
          uid == other.uid;

  @override
  int get hashCode => Object.hash(isSignedIn, email, uid);
}
