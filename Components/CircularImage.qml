import QtQuick 2.15
import QtQuick.Controls 2.15
import Qt5Compat.GraphicalEffects

Item {

    // Width and height
    property int imageWidth : 100
    property int imageHeight : 100

    //Property's
    property bool rounded : true
    property string imageSource : ""

    id: main
    implicitWidth: imageWidth
    implicitHeight: imageHeight


    Image{
        id: img
        width: main.width
        height: main.height
        fillMode: Image.PreserveAspectCrop
        smooth: true
        source: main.imageSource
        antialiasing: true

        layer.enabled: main.rounded
        layer.samples: 8
        layer.effect: OpacityMask{
            maskSource: mask
        }
        

        Rectangle{
            id: mask
            width: main.width
            height: main.height
            radius: width
            visible: false
        }
        // For making image darker
        Rectangle{
            id: imageMask 
            width: main.width
            height: main.height
            opacity: 0.30
            color: "black"
        }
    }
    
}
