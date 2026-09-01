/// Sign-in state for the account's cloud (Firebase) identity.
class CloudAccountState {
  const CloudAccountState({
    this.isSignedIn = false,
    this.email,
    this.uid,
    this.isLoading = false,
  });

  final bool isSignedIn;
  final String? email;
  final String? uid;
  final bool isLoading;

  CloudAccountState copyWith({bool? isLoading}) => CloudAccountState(
    isSignedIn: isSignedIn,
    email: email,
    uid: uid,
    isLoading: isLoading ?? this.isLoading,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CloudAccountState &&
          runtimeType == other.runtimeType &&
          isSignedIn == other.isSignedIn &&
          email == other.email &&
          uid == other.uid &&
          isLoading == other.isLoading;

  @override
  int get hashCode => Object.hash(isSignedIn, email, uid, isLoading);
}
