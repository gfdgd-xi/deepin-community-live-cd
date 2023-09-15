#include "installsystem.h"
#include "runcommandinterminal.h"
#include <QFile>
#include <qtermwidget5/qtermwidget.h>
#include <QProgressBar>

InstallSystem::InstallSystem(QTermWidget *terminal, QProgressBar *progressbar, QMap<QString, QString> partSetPartFormat, QMap<QString, QString> partSetMountPoint)
{
    this->terminal = terminal;
    this->progressbar = progressbar;
    this->partSetMountPoint = partSetMountPoint;
    this->partSetPartFormat = partSetPartFormat;
    this->command = new RunCommandInTerminal(this->terminal, this->progressbar);
    this->command->AddCommand("zenity --info");
    this->command->RunCommand();
}
