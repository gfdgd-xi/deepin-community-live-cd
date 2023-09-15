#include "mainwindow.h"

#include <QApplication>
#include <QLocale>
#include <QTranslator>
#include <unistd.h>
#include <stdio.h>
#include <QMessageBox>
#include <QLoggingCategory>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    // 设置允许 qDebug 输出
    QLoggingCategory::defaultCategory()->setEnabled(QtDebugMsg, true);
    QTranslator translator;
    const QStringList uiLanguages = QLocale::system().uiLanguages();
    for (const QString &locale : uiLanguages) {
        const QString baseName = "deepin-community-live-cd-online-installer_" + QLocale(locale).name();
        if (translator.load(":/i18n/" + baseName)) {
            a.installTranslator(&translator);
            break;
        }
    }
    if(geteuid() != 0){
        QMessageBox::critical(NULL, "错误", "请用 root 权限运行该程序");
        return 1;
    }
    MainWindow w;
    w.show();
    return a.exec();
}
