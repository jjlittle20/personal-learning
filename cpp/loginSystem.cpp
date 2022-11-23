// This is one of the simplest projects to start with to learn about file
// systems in C++. The project involves a user registration process by asking
// username and password. Upon successful registration, a user file is created
// with the credentials. If the user does not exist, upon login, an error will
// be shown. You will also learn how to use Visual Studio to create a simple
// project.
#include <cctype>
#include <fstream>
#include <iostream>
#include <string>

using namespace std;

bool checkExistingUser();
void loginHandler();
void signupHandler();

int main(int argc, char const *argv[]) {
  system("clear");
  cout << "Login System\n";
  cout << "Created by: James Little 23/11/22";
  cout << "\n";

  bool isExistingUser = checkExistingUser();
  if (isExistingUser) {
    loginHandler();
  } else {
    signupHandler();
  }

  return 0;
}

bool checkExistingUser() {
  cout << "Are you and existing user? - y/n\n";
  char existingUser;
  cin >> existingUser;
  if (existingUser == 'y') {
    return true;
  } else if (existingUser == 'n') {
    return false;
  } else {
    cout << "Input not valid\n";
    return checkExistingUser();
  }
}

void loginHandler() {
  cout << "Please enter your user name\n";
  string userName;
  cin >> userName;
  int nameLength = userName.length();
  string formattedUserName;
  for (size_t i = 0; i < nameLength; i++) {

    char userNameLowerChar = tolower(userName[i]);
    formattedUserName = formattedUserName + userNameLowerChar;
  }

  ifstream userFile(formattedUserName + ".txt");
  if (userFile.good()) {
    cout << "Welcome back, " + userName + "\n";

    userFile.close();

  } else {
    cout << "User doens't exist\n";
    cout << "Would you like to sign up?- y/n\n";
    char signUpDecision;
    cin >> signUpDecision;
    if (signUpDecision == 'y') {

      signupHandler();

    } else {
      loginHandler();
    }
  }
}
void signupHandler() {
  cout << "To sign up please enter a user name\n";
  string userName;
  cin >> userName;

  if (userName == "") {
    cout << "This is not a valid user name\n";
    signupHandler();
  } else {
    string formattedUserName;
    int nameLength = userName.length();
    for (size_t i = 0; i < nameLength; i++) {

      char userNameLowerChar = tolower(userName[i]);
      formattedUserName = formattedUserName + userNameLowerChar;
    }
    ofstream userFile(formattedUserName + ".txt");
    userFile << formattedUserName + " signed up!";
    userFile.close();
    cout << "Thank you, " + userName + " for signing up!\n";
  }
}