#include "qtquick2controlsapplicationviewer.h"

#include <QtQml>

#include <CustomLine.h>

int main(int argc, char *argv[])
{
    Application app(argc, argv);

    qmlRegisterType<CustomLine>("CustomLine",1,0,"CustomLine");

    QtQuick2ControlsApplicationViewer viewer;
    viewer.setMainQmlFile(QStringLiteral("qml/GraphEdit/main.qml"));
    viewer.show();

    return app.exec();
}
