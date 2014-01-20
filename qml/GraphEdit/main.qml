import QtQuick 2.1
import QtQuick.Controls 1.0

import CustomLine 1.0

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

    ListModel{
        id: lineMode

        ListElement
        {
            text: "OpenGL Line Drawing"
        }

        ListElement
        {
            text: "Canvas Line Drawing"
        }
    }

    Item
    {
        id:componentlist

        Component {
            CustomLine {
                id: customLineCanvas
                startX: pin1.x + pin1.width
                startY: pin1.y + pin1.height / 2
                endX: pin2.x
                endY: pin2.y + pin2.height / 2
            }
        }

        Component {
            LineCanvas {
                id: customLineCanvas
                startX: pin1.x + pin1.width
                startY: pin1.y + pin1.height / 2
                endX: pin2.x
                endY: pin2.y + pin2.height / 2
            }
        }

        property list<Component> items
        Component.onCompleted:{ items=data; }
    }

    Repeater
    {
        model: spinBox1.value

        Loader
        {
            id:testloader1
            //source:

            sourceComponent: componentlist.items[comboBox1.currentIndex]

            property Item pin1: pin1
            property Item pin2: pin2

            Component.onCompleted:{
                pin1.x = Math.random() * (window1.width-200)+100;
                pin1.y = Math.random() * (window1.height-200)+100;
                pin2.x = Math.random() * (window1.width-200)+100;
                pin2.y = Math.random() * (window1.height-200)+100;
            }

            Pin {
                id: pin1
            }

            Pin {
                x:100
                y:30
                id: pin2
            }
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

    ComboBox {
        id: comboBox1
        x: 192
        y: 6
        width: 200
        model: lineMode
    }
}
