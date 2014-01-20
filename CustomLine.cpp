#include "CustomLine.h"

#include <QSGGeometryNode>

#include <QSGFlatColorMaterial>

#include <QtCore/qmath.h>

qreal localBezier(qreal A,  // Start value
              qreal B,  // First control value
              qreal C,  // Second control value
              qreal D,  // Ending value
              qreal t)  // Parameter 0 <= t <= 1
{
    qreal s = 1 - t;
    qreal AB = A*s + B*t;
    qreal BC = B*s + C*t;
    qreal CD = C*s + D*t;
    qreal ABC = AB*s + BC*t;
    qreal BCD = BC*s + CD*t;
    return ABC*s + BCD*t;
}


CustomLine::CustomLine(QQuickItem *parent) :
    QQuickItem(parent)
{
    setFlag( QQuickItem::ItemHasContents );
    localBezier(1,2,3,4,0.5);
}

QSGNode *CustomLine::updatePaintNode(QSGNode *oldnode, QQuickItem::UpdatePaintNodeData *data)
{
    Q_UNUSED(data)
    QSGGeometryNode *node = oldnode?dynamic_cast<QSGGeometryNode*>(oldnode):0;

    QSGGeometry *geometry=0;
    QSGFlatColorMaterial *material = 0;

    if(!node)
    {
        geometry = new QSGGeometry(QSGGeometry::defaultAttributes_Point2D(), 32);
        material = new QSGFlatColorMaterial;

        node = new QSGGeometryNode;
        node->setGeometry(geometry);
        node->setFlag(QSGNode::OwnsGeometry);
        node->setMaterial(material);
        node->setFlag(QSGNode::OwnsMaterial);
    }

    if(recalculatePath)
    {
        geometry= node->geometry();
    }

    if(geometry)
    {
        geometry->setDrawingMode(GL_LINE_STRIP);
        geometry->setLineWidth(10);

        qreal distance= qSqrt( (m_startX-m_endX)*(m_startX-m_endX) + (m_startY-m_endY)*(m_startY-m_endY) );

        qreal controlPoint1X= m_startX + distance*0.6;
        qreal controlPoint1Y= m_startY;
        qreal controlPoint2X= m_endX - distance*0.6;
        qreal controlPoint2Y= m_endY;

        setX( std::min(std::min(m_startX,controlPoint1X),std::min(controlPoint2X,m_endX)) );
        setY( std::min(std::min(m_startY,controlPoint1Y),std::min(controlPoint2Y,m_endY)) );
        setWidth( std::max(std::max(m_startX,controlPoint1X),std::max(controlPoint2X,m_endX)) - x() );
        setHeight( std::max(std::max(m_startY,controlPoint1Y),std::max(controlPoint2Y,m_endY)) - y() );

        QSGGeometry::Point2D* array= geometry->vertexDataAsPoint2D();
        int i=0;
        array[i++].set(m_startX-x(), m_startY-y());
        for( ; i< 31 ; ++i )
        {
           array[i].set(
                  localBezier( m_startX, controlPoint1X, controlPoint2X, m_endX, i/32.0 ) - x(),
                  localBezier( m_startY, controlPoint1Y, controlPoint2Y, m_endY, i/32.0 ) - y()
           );
        }
        array[i].set(m_endX-x(),m_endY-y());

        node->markDirty(QSGNode::DirtyGeometry);

    }

    if(material)
    {
        material->setColor(QColor(255, 0, 0));
    }

    recalculatePath=false;

    return node;
}
