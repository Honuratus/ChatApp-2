import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects


Item{
    id: main
    implicitWidth: main.leftBarWidth
    implicitHeight: main.leftBarHeight

    // Number Properties
    property int leftBarWidth: 70
    property int leftBarHeight: parent.height

    // Colors
    property color lBarGradientStart : "#484F61"
    property color lBarGradientStop : "#212530"
    property color lBarIconColor : "#707787"

    // Debug property's
    property bool enableBorders: true
    property color borderColor: "red"

    // Image and Icon widht and height
    property int profilePhotoWidth: 50
    property int profilePhotoHeight: 50
    property int selected : 0


     //filler Rectangle
    Rectangle{
        id: fillerRectangle
        anchors.fill: main
        gradient: Gradient {
               orientation: Gradient.Horizontal
               GradientStop { position: 0.0; color: main.lBarGradientStart }
               GradientStop { position: 1.0; color: main.lBarGradientStop }
        }
        radius: 20
        ColumnLayout{
            anchors.fill: parent
            Rectangle{
                color: "transparent"
                border.color: main.borderColor
                border.width: main.enableBorders ? 1:0
                Layout.fillWidth: true
                height: 100
                CircularImage{
                    anchors.centerIn: parent   
                    imageSource: "../Images/pp.jpg"
                    imageWidth: main.profilePhotoWidth
                    imageHeight: main.profilePhotoHeight

                }
            }
            Rectangle{
                color: "transparent"
                border.color: main.borderColor
                border.width: main.enableBorders ? 1:0
                Layout.fillWidth: true
                Layout.fillHeight: true
                ColumnLayout{
                    anchors.centerIn: parent
                    spacing: 20

                    IconImage{
                        source: "../Images/chatIcon.png"
                        sourceSize.height: 30
                        sourceSize.width: 30
                        color: main.selected == 0 ? "white" : main.lBarIconColor
                        antialiasing: true
                        smooth: true
                    }
                    IconImage{
                        source: "../Images/ppIcon.png"
                        sourceSize.height: 30
                        sourceSize.width: 30
                        color: main.selected == 1 ? "white" : main.lBarIconColor
                        antialiasing: true
                        smooth: true
                    }
                }

            }
            Rectangle{
                color: "transparent"
                border.color: "red"
                border.width: main.enableBorders ? 1:0
                Layout.fillWidth: true
                height: 100
                IconImage{
                    anchors.centerIn: parent
                    source: "../Images/quitIcon.png"
                    sourceSize.height: 30
                    sourceSize.width: 30
                    color: main.selected == 2 ? "white" : main.lBarIconColor
                    antialiasing: true
                    smooth: true
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            Qt.exit(1)
                        }
                    }
                }

            }
        }
    }

}
