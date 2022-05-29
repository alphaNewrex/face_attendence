# Microsoft Engage'22
## Final Project - Face Attendance
## 🚩Problem Statement 
Develop a browser-based
application or a native mobile
application to demonstrate 
application of Face Recognition 
technology.

For this, I decided my Problem statement to be **Tracking Attendance**.
The problem of marking attendance in an offline or even online medium of school/college is very tiresome, wherein the teacher circulates a sheet and everyone has to sign or the teacher manually calls out names and this is very time taking and resource expensive.
To Automate and digitize this process I decided to come up with a solution that is both effective and easy to use by everyone.

Now, you can mark attendance of you class by just one click in the Face Attendance App, where it automatically detects the faces and sends it to Microsoft Cognitive Services and returns us with updated attendance on screen.

Cherry on the top is that you can mark attendance of more than one student at a time (10 students maximum in one image, i.e. this is the limit given to us by Microsoft Azure Face API - Identify).


P.S. This project was built entirely during the Microsoft Engage'22 Program Timeline.

## 🔗 Links for project:
 Video link : [Youtube Link]()  
 
 Drive Link for APK : [Drive Link]()
 
 Project Presentation : [Presentation Link]()

## 🚩 Features and UI: 
Features | UI
------------ | -------------

## App Flow

## WorkFlow - using Agile Methodology

| Week | Task |  Remarks |
|------|:----:|---------|
| 1    | **Design & Setup phase**: - Finalize the Problem Statement for my project. Build the design prototype using Figma and Also started working on the App Flow |   Successfully created a problem Statement for my self and Finalize the Design Prototype and Started working on some designs.            |
| 2    | **Build & Develop Phase**: - Decide upon the Tech Stack that I want to use and also decide the Cloud services that I will be using. Start the Base project and prepare the structure for it.| Finally Decided to use Dart and Flutter as Framework and build an Android Application to Mark Attendance. Android Application was choosen beacause of the effectiveness of the application and Flutter was chosen as it's very versatile and easy to scale Framework|
| 3    | **Develop & Test phase**: -Start building the Screens, Data Models, and Widgets for the Project. Set Up the Remote Database - Define the collections and Documents on Firebase Firestore.  | Successfully built the base of the application, defined the Data Models for Student and Class and also implemented Firebase FireStore for the Database. Completed the Collection and Documentation setup for Firestore |
| 4    | **Test & Deploy phase**: - Set up the Azure resource and Initiated the Face API. Implemented the Face Recognition and Identification. Further implemented some features - Export to CSV, etc.| Successfully Created the Azure Resource and Implemented the Face API calls in the application inorder to facilitate the Facial Attendance, Added Export to CSV feature along with Delete class and Student|

## 🚩 Getting Started

This project is a starting point for Face Attendance.

If you want to Download and run the Stable Release APK for the application. Click [here]().

#### OR 
If you want to run the debug application follow the given steps.

Make sure you have Flutter installed on your local machine. For more instructions on how to install flutter, look [here](https://flutter.io/docs/get-started/install).
```
git clone https://github.com/alphaNewrex/face_attendence.git
```
And Change the directory to your cloned directory.


Make sure you're on the stable channel with the most recent version of Flutter.

```
flutter channel stable
flutter upgrade
```

In order to build the application, make sure you are in the face_attendance directory and run these commands :
```
flutter pub get
flutter run
```


A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


## 🚩 Future  Scope

Scope | Reason
------------ | -------------
Implement in Classroom Apps like Google Classroom,etc| This Feature can actively be used in Google Classroom type Applications where they use the Mediums like Digital classrooms in Offline Medium.
Support for more than one Image per student | More Images means better accuracy, If we Increas the number of Faces per Person The Azure API will return personId more accurately.
