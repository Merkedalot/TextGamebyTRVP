#include <QApplication>
#include <VPApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>

#include "handletextfield.h"

//test git comment

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    VPApplication vplay;
    //char cpptext[255]="C++ Welcome message";
    //char playerinput[255];

    // Use platform-specific fonts instead of V-Play's default font
    vplay.setPreservePlatformFonts(true);

    QQmlApplicationEngine engine;
    vplay.initialize(&engine);

    vplay.setMainQmlFileName(QStringLiteral("qml/Main.qml"));

    engine.load(QUrl(vplay.mainQmlFileName()));

    QObject *rootObject = engine.rootObjects().at(0);
    QObject *gametext = rootObject->findChild<QObject*>("gametext");
    if (gametext)
    {
        gametext->setProperty("color", "blue");
        //gametext->setProperty("text", cpptext);
    }

    HandleTextField handleTextField;

    QObject *topLevel = engine.rootObjects().value(0);
    QQuickWindow *window = qobject_cast<QQuickWindow *>(topLevel);

    // connect our QML signal to our C++ slot
    QObject::connect(window, SIGNAL(submitTextField(QString)),
                     &handleTextField, SLOT(handleSubmitTextField(QString)));

    // connect our C++ signal to our QML slot
    // NOTE: if we want to pass an parameter to our QML slot, it has to be
    // a QVariant.

    QObject::connect(&handleTextField, SIGNAL(setTextField(QVariant)),
                     window, SLOT(setTextField(QVariant)));

    return app.exec();
}
