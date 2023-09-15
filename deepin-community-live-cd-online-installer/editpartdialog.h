#ifndef EDITPARTDIALOG_H
#define EDITPARTDIALOG_H

#include <QDialog>

namespace Ui {
class EditPartDialog;
}

class EditPartDialog : public QDialog
{
    Q_OBJECT

public:
    explicit EditPartDialog(QString part, QMap<QString, QString> *partSetMountPoint, QMap<QString, QString> *partSetPartFormat, QWidget *parent = nullptr);
    ~EditPartDialog();

private slots:
    void on_buttonBox_accepted();

private:
    Ui::EditPartDialog *ui;
    QMap<QString, QString> *partSetMountPoint;
    QMap<QString, QString> *partSetPartFormat;
    QString part;
};

#endif // EDITPARTDIALOG_H
