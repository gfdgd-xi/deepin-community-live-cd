#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QTableView>
#include <QLabel>
#include <QLineEdit>

QT_BEGIN_NAMESPACE
namespace Ui { class MainWindow; }
QT_END_NAMESPACE

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = nullptr);
    ~MainWindow();

private slots:
    void on_action_exit_triggered();

    void on_refreshDiskList_clicked();

    void on_editChoosePart_clicked();

    void on_userName_textChanged(const QString &arg1);

    void on_hostName_textChanged(const QString &arg1);

    void on_rootPassword0_textChanged(const QString &arg1);

    void on_rootPassword1_textChanged(const QString &arg1);

    void on_action_about_triggered();

    void on_userPassword0_textChanged(const QString &arg1);

    void on_userPassword1_textChanged(const QString &arg1);

    void on_installButton_clicked();

private:
    QString GetCommandReturn(QString command);
    Ui::MainWindow *ui;
    void SetDiskList(QTableView *diskListWidget);
    QStringList GetDiskList();
    QMap<QString, QString> partSetMountPoint;
    QMap<QString, QString> partSetPartFormat;
    void PasswordCheck(QLabel *label0, QLabel *label1, QLineEdit *password0, QLineEdit *password1, QString labelTips0, QString labelTips1);
    QStringList specialSymbol = {"`", "~", "!", "@", "#", "$", "%", "^", "&", "*", "(", ")", "=", "|", "\\", "[", "]", "{", "}", ":", ";", "\"", "'", ",", "<", ">", "?", "/"};
};
#endif // MAINWINDOW_H
