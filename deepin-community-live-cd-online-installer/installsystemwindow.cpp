#include "installsystemwindow.h"
#include "ui_installsystemwindow.h"
#include "installsystem.h"
#include <QObject>
#include <QMessageBox>
#include <qtermwidget5/qtermwidget.h>
#include <QThread>
//#include <qtermwidget5/Emulation.h>

InstallSystemWindow::InstallSystemWindow(QMap<QString, QString> partSetPartFormat, QMap<QString, QString> partSetMountPoint, QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::InstallSystemWindow)
{
    ui->setupUi(this);
    QTermWidget *ter = new QTermWidget(0);
    ui->verticalLayout->addWidget(ter);
    InstallSystem *system = new InstallSystem(ter, ui->progressBar, partSetPartFormat, partSetMountPoint);
    /*ter->setColorScheme("DarkPastels");
    ter->setShellProgram("/usr/bin/bash");
    ter->setArgs(QStringList() << "-c" << "gedit");
    ter->setAutoClose(0);
    ter->setAutoFillBackground(1);
    //ter->setTerminalBackgroundImage("/home/gfdgd_xi/Pictures/有兽档案馆Banner.png");
    ter->startShellProgram();
    connect(ter, &QTermWidget::finished, this, [&, this](){QMessageBox::information(NULL, "提示", "系统安装完成");});*/

}

InstallSystemWindow::~InstallSystemWindow()
{
    delete ui;
}
