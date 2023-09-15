#include "runcommandinterminal.h"
#include <QFile>
#include <QDateTime>

RunCommandInTerminal::RunCommandInTerminal(QTermWidget *terminal, QProgressBar *progressbar)
{
    this->terminal = terminal;
    this->progressbar = progressbar;
}

void RunCommandInTerminal::AddCommand(QString command){
    commandList.append(command);
}

void RunCommandInTerminal::RunCommand(){
    this->runStatus = true;
    // 写入为 Bash 文件，方便执行
    QString commandCode = "#!/bin/bash\n";
    QString bashPath = "/tmp/deepin-community-live-cd-installer-" + QString::number(QDateTime::currentMSecsSinceEpoch()) + ".sh";
    for(int i = 0; i < this->commandList.size(); i++){
        commandCode += this->commandList.at(i) + "\n";
    }
    commandCode += "rm -rfv '" + bashPath + "'";
    QFile file(bashPath);
    file.open(QFile::WriteOnly);
    if(!file.isWritable()){
        throw "Can't write the file!";
    }
    file.write(commandCode.toUtf8());
    file.close();
    system(("chmod +x '" + bashPath + "'").toUtf8()); // 赋予运行权限
    this->terminal->setColorScheme("DarkPastels");
    this->terminal->setShellProgram("/usr/bin/bash");
    this->terminal->setArgs(QStringList() << bashPath);
    this->terminal->setAutoClose(1);
    this->terminal->setAutoFillBackground(1);
    this->terminal->startShellProgram();
}
