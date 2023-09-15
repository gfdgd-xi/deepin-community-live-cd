#ifndef INSTALLSYSTEM_H
#define INSTALLSYSTEM_H

#include "runcommandinterminal.h"
#include <QObject>
#include <qtermwidget5/qtermwidget.h>
#include <QProgressBar>
#include <QMap>

class InstallSystem
{
public:
    InstallSystem(QTermWidget *terminal, QProgressBar *progressbar, QMap<QString, QString> partSetPartFormat, QMap<QString, QString> partSetMountPoint);
private:
    QTermWidget *terminal;
    QProgressBar *progressbar;
    QMap<QString, QString> partSetPartFormat;
    QMap<QString, QString> partSetMountPoint;
    RunCommandInTerminal *command;
};

#endif // INSTALLSYSTEM_H
