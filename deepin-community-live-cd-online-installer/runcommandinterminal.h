#ifndef RUNCOMMANDINTERMINAL_H
#define RUNCOMMANDINTERMINAL_H

#include <qtermwidget5/qtermwidget.h>
#include <QProgressBar>

class RunCommandInTerminal
{
public:
    RunCommandInTerminal(QTermWidget *terminal, QProgressBar *progressbar);
    void AddCommand(QString command);
    void RunCommand();
    QStringList commandList;
private:
    QTermWidget *terminal;
    QProgressBar *progressbar;
    bool runStatus;
};

#endif // RUNCOMMANDINTERMINAL_H
