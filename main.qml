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
        url: "ws://104.248.17.164:5000"
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
        MouseArea{
            anchors.fill: parent
            property variant clickPos: "1,1"

            onPressed: {
                clickPos  = Qt.point(mouse.x,mouse.y)
            }

            onPositionChanged: {
                var delta = Qt.point(mouse.x-clickPos.x, mouse.y-clickPos.y)
                mainWindow.x += delta.x;
                mainWindow.y += delta.y;
            }
            z:-1
        }

    }
    FlickableInput{
        id: flickableInput
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        focus: true

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
                sendMessage("StrancKralı",messageText);
                flickableInput.textValue = ""
            }
        }
    }
    Button {
        id: clearButton
        text: "Clear"
        anchors.left: sendButton.right
        anchors.leftMargin: 10
        anchors.bottom: flickableInput.bottom
        height: flickableInput.height
        onClicked: {
           listView.model.clear()
        }
    }
    ListModel {
        id: messageModel
    }
    ListView {
        id: listView
        anchors.left: leftBar.right
        anchors.leftMargin: 10
        width: 570
        height: 400
        model: messageModel
        spacing: 10 // Adjust spacing as needed

        delegate: Item {
            width: 570
            height: childrenRect.height

            Rectangle {
                width: parent.width
                height: text.contentHeight
                color: index % 2 === 0 ? "darkblue" : "black"
                border.color: "black"
                Text {
                    id: text
                    width: parent.width
                    text: modelData
                    wrapMode: Text.Wrap
                    color: "white"
                    font.pointSize: 15
                }
            }
        }
        Component.onCompleted: {
            scrollToEnd()
        }

        onCountChanged: {
            Qt.callLater(scrollToEnd)
        }

        function scrollToEnd() {
            positionViewAtIndex(model.count - 1, ListView.End)
        }


    }

    function appendMessage(newMessage) {
        messageModel.append({ messageText: newMessage });
    }
}

