import QtQuick 2.1
import QtQuick.Controls 1.0

Rectangle {
    id: pin1
    width: 20
    height: 20
    radius: 5
    border.color: "#000000"
    
    MouseArea {
        id: pinMouse
        anchors.fill: parent
        anchors.margins: -10
        drag.target: parent
    }
    
}
