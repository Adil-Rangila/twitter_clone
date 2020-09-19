# twitter_clone

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

##  Colud Function Code

const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.notifyNewNotification = functions.firestore
.document('notifications/{notificationId}')
.onCreate((snapshot,context)=>{
    
    const notData = snapshot.data();
    const senderEmail = notData['sendername'];
    const receiverId = notData['recevierDevices'];

    const payload = {
        notification: {
            title : senderEmail,
            body : 'Your Post Is Liked by' + senderEmail,
            sound : 'default' 
        },
        data : {
            'sendername': senderEmail,
            'message' : 'looking good'
        }
    };
    admin.messaging().sendToDevice(receiverId,payload);
});