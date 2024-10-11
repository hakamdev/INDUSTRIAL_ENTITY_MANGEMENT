enum XErrors<String> {
  noInternet("There is no internet!"),
  wrongCredentials("Wrong email or password!"),
  unauthorized("You are not logged in!"),
  invalidRequestData("Email or password are not valid!"),
  noCookie("You are not logged in!"),
  invalidResponseData("Invalid data was received from Server!"),
  alreadyLoading("Data is already loading, please wait!"),
  other("Something went wrong!");

  const XErrors(this.message);

  final String message;
}
