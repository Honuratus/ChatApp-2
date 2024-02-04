import QtQuick 2.15
import QtQuick.Controls 2.15


ScrollView{
    id: view
    width: 400
    height: Math.max(40,Math.min(textField.height, 120))
    ScrollBar.horizontal: ScrollBar{
        policy: ScrollBar.AlwaysOff
    }

    // properties
    property string textValue : ""
    TextArea {
        id: textField
        width: 400
        height: 40
        text: textValue

        wrapMode: TextEdit.Wrap
        anchors.verticalCenterOffset: 3
        placeholderText: "Type..."
        placeholderTextColor: "white"
        font.pixelSize: 16
        color: "white"
        anchors.verticalCenter: parent.verticalCenter // Corrected property

        background: Rectangle {
            implicitWidth: textField.width
            implicitHeight: textField.height
            color: "#536878"
            border.color: "#2535D9"
            border.width: 1
            radius: 10
        }

        onTextChanged: {
            //var newHeight = Math.min(Math.max(contentHeight, 40), 120);
            textField.height = contentHeight;
            textValue = text
        }
    }

}



