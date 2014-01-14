import QtQuick 2.1
import QtQuick.Controls 1.0

Item {
    
    LineCanvas {
        id: lineCanvas
        startX: pin1.x + pin1.width
        startY: pin1.y + pin1.height / 2
        endX: pin2.x
        endY: pin2.y + pin2.height / 2
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
