import QtQuick 2.1
import QtQuick.Controls 1.0

Canvas
{
    id:lineCanvas

    property real startX
    property real startY

//    property real startAngle: 0

    property real endX
    property real endY

//    property real endAngle: 180

    property real distance: Math.sqrt( (startX-endX)*(startX-endX) + (startY-endY)*(startY-endY) );

    property real size : 1

    property real controlPoint1X: startX + distance*0.6
    property real controlPoint1Y: startY
    property real controlPoint2X: endX - distance*0.6
    property real controlPoint2Y: endY

    x: Math.min( startX, controlPoint1X, controlPoint2X, endX ) - size
    y: Math.min( startY, controlPoint1Y, controlPoint2Y, endY ) - size

    width: Math.max( startX, controlPoint1X, controlPoint2X, endX ) - x + size
    height: Math.max( startY, controlPoint1Y, controlPoint2Y, endY ) - y + size

//    states: [
//        State {
//            name: "TopLeft"
//            when: pin1.x < pin2.x && pin1.y < pin2.y
//            AnchorChanges {
//                   target: lineCanvas
//                   anchors.left: lineCanvas.pin1.left
//                   anchors.top: lineCanvas.pin1.top
//                   anchors.right: lineCanvas.pin2.right
//                   anchors.bottom: lineCanvas.pin2.bottom
//               }
//        },
//        State {
//            name: "BottomRight"
//            when: pin1.x > pin2.x && pin1.y > pin2.y
//            AnchorChanges {
//                   target: lineCanvas
//                   anchors.left: lineCanvas.pin2.left
//                   anchors.top: lineCanvas.pin2.top
//                   anchors.right: lineCanvas.pin1.right
//                   anchors.bottom: lineCanvas.pin1.bottom
//               }
//        },
//        State {
//            name: "TopRight"
//            when: pin1.x < pin2.x && pin1.y > pin2.y
//            AnchorChanges {
//                   target: lineCanvas
//                   anchors.left: lineCanvas.pin1.left
//                   anchors.top: lineCanvas.pin2.top
//                   anchors.right: lineCanvas.pin2.right
//                   anchors.bottom: lineCanvas.pin1.bottom
//               }
//        },
//        State {
//            name: "BottomLeft"
//            when: pin1.x > pin2.x && pin1.y < pin2.y
//            AnchorChanges {
//                   target: lineCanvas
//                   anchors.left: lineCanvas.pin2.left
//                   anchors.top: lineCanvas.pin1.top
//                   anchors.right: lineCanvas.pin1.right
//                   anchors.bottom: lineCanvas.pin2.bottom
//               }
//        }
//    ]
    
//    anchors.left: lineCanvas.pin1.left
//    anchors.top: lineCanvas.pin1.top
//    anchors.right: lineCanvas.pin2.right
//    anchors.bottom: lineCanvas.pin2.bottom
    
    //renderStrategy: Canvas.Threaded
    //renderTarget: Canvas.FramebufferObject
    renderTarget: Canvas.Image

    //        x: Math.min( pin1.x, pin2.x );
    //        width: Math.max( pin1.x + pin1.width, pin2.x + pin2.width ) - x;
    //        y: Math.min( pin1.y, pin2.y );
    //        height: Math.max( pin1.y + pin1.height, pin2.y + pin2.height ) - x;
    
    
    onPaint: {
        console.log("Drawing ",lineCanvas );
        var c= lineCanvas.getContext("2d");
        c.clearRect(0,0,lineCanvas.width,lineCanvas.height);
        c.beginPath();
        c.moveTo( lineCanvas.startX - lineCanvas.x, lineCanvas.startY - lineCanvas.y );
        c.bezierCurveTo(
                   lineCanvas.controlPoint1X - lineCanvas.x,
                   lineCanvas.controlPoint1Y - lineCanvas.y,
                   lineCanvas.controlPoint2X - lineCanvas.x,
                   lineCanvas.controlPoint2Y - lineCanvas.y,
                   lineCanvas.endX- lineCanvas.x,
                   lineCanvas.endY - lineCanvas.y
        );
        c.stroke();
    }

}
