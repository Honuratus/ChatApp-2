import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import QtWebSockets

import "Components"


Window {

    // Prop

    id: mainWindow
    width: 640
    height: 480
    minimumWidth: width
    minimumHeight: height
    maximumWidth: minimumWidth
    maximumHeight: minimumHeight
    color: "transparent"

    flags: Qt.FramelessWindowHint | Qt.Window
    visible: true
    title: qsTr("Hello World")
    Rectangle{
       anchors.fill: parent
       color: "#050A30"
       radius: 20
       layer.enabled: true
       layer.effect: DropShadow {
            transparentBorder: true
            horizontalOffset: 0
            verticalOffset: 0
            samples: 17
            color: Qt.rgba(0,0,0,0.5)
            spread: 0.2
        }
    }

    WebSocket {
        id: socket
        url: "ws://127.0.0.1:5000"  // Assuming Flask WebSocket server is running on port 5000
        onTextMessageReceived: handleMessage(message)
        active: true
        onStatusChanged: {
            console.log("WebSocket status:", socket.status);
            // Handle other status changes if needed
        }
    }

    function handleMessage(message) {
        // Handle incoming messages, update UI, etc.
        console.log("Received message:", message)
        appendMessage(message)
    }

    function sendMessage(username, message) {
        var data = { "username": username, "message": message };
        socket.sendTextMessage(JSON.stringify(data));
    }



    // Left bar component
    LeftBar{
        id: leftBar
        leftBarWidth: 60
        leftBarHeight: mainWindow.height
        enableBorders: false

        profilePhotoWidth: 40
        profilePhotoHeight: 40

    }
    FlickableInput{
        id: flickableInput
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
    }
    Button {
        id: sendButton
        text: "Send"
        anchors.left: flickableInput.right
        anchors.leftMargin: 10
        anchors.bottom: flickableInput.bottom
        height: flickableInput.height
        onClicked: {
            var messageText = flickableInput.textValue;
            if (messageText !== "") {
                sendMessage("Honuratus",messageText);
                flickableInput.textValue = ""
            }
        }
    }

    Column{
        anchors.left: leftBar.right
        anchors.leftMargin: 20
        Repeater{
            id: repeater
            model: messageModel
            Text{
                text:modelData
                color: "white"
                font.pointSize: 20
            }
        }
    }
    // Define a ListModel to store the messages
    ListModel {
        id: messageModel
    }

    // Function to append a new message to the model
    function appendMessage(newMessage) {
        messageModel.append({ messageText: newMessage });
    }


}

