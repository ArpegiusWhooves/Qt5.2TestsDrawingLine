#ifndef CUSTOMLINE_H
#define CUSTOMLINE_H

#include <QQuickItem>

class CustomLine : public QQuickItem
{
    Q_OBJECT

    Q_PROPERTY(qreal startX READ startX WRITE setStartX NOTIFY startXChanged)
    Q_PROPERTY(qreal startY READ startY WRITE setStartY NOTIFY startYChanged)
    Q_PROPERTY(qreal endX READ endX WRITE setEndX NOTIFY endXChanged)
    Q_PROPERTY(qreal endY READ endY WRITE setEndY NOTIFY endYChanged)

    qreal m_startX;
    qreal m_startY;
    qreal m_endX;
    qreal m_endY;

    bool recalculatePath;


public:
    explicit CustomLine(QQuickItem *parent = 0);

    QSGNode *updatePaintNode(QSGNode *node, UpdatePaintNodeData *data);

    qreal startX() const
    {
        return m_startX;
    }

    qreal startY() const
    {
        return m_startY;
    }

    qreal endX() const
    {
        return m_endX;
    }

    qreal endY() const
    {
        return m_endY;
    }

signals:

    void startXChanged(qreal arg);

    void startYChanged(qreal arg);

    void endXChanged(qreal arg);

    void endYChanged(qreal arg);

public slots:

void setStartX(qreal arg)
{
    if (m_startX != arg) {
        m_startX = arg;
        emit startXChanged(arg);
        recalculatePath=true;
        update();
    }
}
void setStartY(qreal arg)
{
    if (m_startY != arg) {
        m_startY = arg;
        emit startYChanged(arg);
        recalculatePath=true;
        update();
    }
}
void setEndX(qreal arg)
{
    if (m_endX != arg) {
        m_endX = arg;
        emit endXChanged(arg);
        recalculatePath=true;
        update();
    }
}
void setEndY(qreal arg)
{
    if (m_endY != arg) {
        m_endY = arg;
        emit endYChanged(arg);
        recalculatePath=true;
        update();
    }
}
};

#endif // CUSTOMLINE_H
