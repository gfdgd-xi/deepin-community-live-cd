#include "editpartdialog.h"
#include "ui_editpartdialog.h"

EditPartDialog::EditPartDialog(QString part, QMap<QString, QString> *partSetMountPoint, QMap<QString, QString> *partSetPartFormat, QWidget *parent) :
    QDialog(parent),
    ui(new Ui::EditPartDialog)
{
    ui->setupUi(this);
    // 设置标题
    this->setWindowTitle("编辑分区 " + part);
    // 设置该 .h 下的全局变量
    this->partSetMountPoint = partSetMountPoint;
    this->partSetPartFormat = partSetPartFormat;
    this->part = part;
    // 判断之前有没有选择，有的话自动填写
    if(partSetMountPoint->count(part)){
        ui->mountPointChooser->setCurrentText(partSetMountPoint->value(part));
    }
    if(partSetPartFormat->count(part)){
        ui->partFormatChooser->setCurrentText(partSetPartFormat->value(part));
    }
}

EditPartDialog::~EditPartDialog()
{
    delete ui;
}

void EditPartDialog::on_buttonBox_accepted()
{
    // 判断选择的是不是有挂载点
    if(ui->mountPointChooser->currentIndex() == 0){
        // 如果不是
        if(partSetMountPoint->count(part)){
            // 移除标识
            partSetMountPoint->remove(part);
        }
    }
    else{
        // 否则添加标识
        partSetMountPoint->insert(part, ui->mountPointChooser->currentText());
    }
    // 判断选择的是不是格式化
    if(ui->partFormatChooser->currentIndex() == 0){
        // 如果不是
        if(partSetPartFormat->count(part)){
            partSetPartFormat->remove(part);
        }
    }
    else{
        // 否则添加标识
        partSetPartFormat->insert(part, ui->partFormatChooser->currentText());
    }

}

