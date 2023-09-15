#ifndef INSTALLSYSTEMWINDOW_H
#define INSTALLSYSTEMWINDOW_H

#include <QMainWindow>

namespace Ui {
class InstallSystemWindow;
}

class InstallSystemWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit InstallSystemWindow(QMap<QString, QString> partSetPartFormat, QMap<QString, QString> partSetMountPoint, QWidget *parent = nullptr);
    ~InstallSystemWindow();

private:
    Ui::InstallSystemWindow *ui;
};

#endif // INSTALLSYSTEMWINDOW_H
