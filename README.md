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
Sign In Screen Powered by Firebase Authentication | ![Screenshot 2022-05-29 155317](https://user-images.githubusercontent.com/77982973/170863297-5445373b-ea66-461c-a086-7cb6d394210d.png)
Register New User on the Firebase Authetication | ![Screenshot 2022-05-29 155437](https://user-images.githubusercontent.com/77982973/170863361-44da1c90-1455-4759-ae9b-340b4d4b7e9d.png)
Incase You Forget you password We have Forget Password feature as well | ![image](https://user-images.githubusercontent.com/77982973/170863411-b5dc14d0-60a8-4354-93bf-d32efd16f71b.png)
Class Home Page where you can View all the classes associated with that Account | ![image](https://user-images.githubusercontent.com/77982973/170863565-a0072247-f3eb-4d1e-b6e0-bfa9be47955c.png)
Once you click the Add Class Floating action button you will be taken to add calss screen where you can add details for your class and once everything is finished. Click on Add Class, This feature will create a `Class document` on Firestore and a `LargePersonGroup` on Azure Face. The valid name for class are all small letters with numbers, no spaces.|![image](https://user-images.githubusercontent.com/77982973/170863695-4a4341fc-401b-4ec4-a9fd-75755fcc4c23.png)
Once you click on a Class card, you will be taken to a Course Page just like the one in Image where you will get a list of all students in class along with buttons to Add Student, Take Attendance and Export Attendance | ![image](https://user-images.githubusercontent.com/77982973/170863989-b15b70b0-2856-4baa-a827-a14989cc90cd.png)
Export Button, Exports the chats to a CSV file format which can be used further in different applications like ERP, etc. Once file is generated it will chow a snackbar click on `Open` to open the file | ![image](https://user-images.githubusercontent.com/77982973/170864066-2483c8ff-878e-43dd-8468-5ec5755f0966.png)
On clicking Add Student it will take up to Add student Page where you have to select a photo first. Once the Image is selected then it will show The remaining form fields. You can select the image from Gallery or Click a fresh new Image and use that.| ![image](https://user-images.githubusercontent.com/77982973/170864212-3a94524c-c0e5-41ed-9f9a-0ad9e4a8fded.png)
If you click on take attendance on the Class Page, It will take you to a screen where you can select a photo from gallery or take one from the camera and use that for marking attendance. This uses Azure Face API's `Detect` and `Identify` calls and updates accordingy in our database.| ![image](https://user-images.githubusercontent.com/77982973/170864266-2fa7329f-5a96-4dc4-9585-eada62dc6772.png)
Suppose the Face detector does not detect a Face, or incase you entered the wrong registration number.Well, You can edit it by click on the respective student container and `Update the details` required.If you want you can `delete the selected student` as well. This asction will delete it from the database and the Azure LargePersonGroup. |![image](https://user-images.githubusercontent.com/77982973/170864507-ff458304-7650-46f2-a4ef-3866f79ab17c.png)


## The Confidence Report for the Images Detected in the above feature demonstration.
![image](https://user-images.githubusercontent.com/77982973/170864381-c29a55e5-80e7-421c-b43c-49dd9adfc78e.png)
## Exported CSV file genetrated 
![image](https://user-images.githubusercontent.com/77982973/170864429-878de31a-df78-4ffc-929d-60d2359ced8c.png)



## 🚩 App Flow

## 🚩 WorkFlow - using Agile Methodology

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
