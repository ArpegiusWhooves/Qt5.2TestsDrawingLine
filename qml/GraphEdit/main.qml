import QtQuick 2.1
import QtQuick.Controls 1.0

ApplicationWindow {
    id: window1
    title: qsTr("Hello World")
    width: 640
    height: 480

    menuBar: MenuBar {
        Menu {
            title: qsTr("File")
            MenuItem {
                text: qsTr("Exit")
                onTriggered: Qt.quit();
            }
        }
    }

    Repeater
    {
        model: spinBox1.value
        TestConnectionLine {
            x: Math.random() * (window1.width-120)
            y: Math.random() * (window1.height-120)
        }
    }

    Button {
        text: qsTr("Hello World")
        anchors.centerIn: parent
    }

    SpinBox {
        id: spinBox1
        x: 20
        y: 6
        width: 141
        height: 25
        maximumValue: 999
        value: 10
    }
}
