#ifndef ABOUTPROGRAM_H
#define ABOUTPROGRAM_H

#include <QDialog>

namespace Ui {
class AboutProgram;
}

class AboutProgram : public QDialog
{
    Q_OBJECT

public:
    explicit AboutProgram(QWidget *parent = nullptr);
    ~AboutProgram();

private:
    Ui::AboutProgram *ui;
};

#endif // ABOUTPROGRAM_H
