#include "aboutprogram.h"
#include "ui_aboutprogram.h"
#include <QDate>

AboutProgram::AboutProgram(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::AboutProgram)
{
    ui->setupUi(this);
    // 获取当前年份
    QDate currentdate = QDate::currentDate();
    int year = currentdate.year();
    // 显示关于内容
    ui->information->setHtml("<p>Deepin Community Live CD 在线安装工具是一个能在 Live CD 上自动从互联网获取系统安装包安装系统的工具</p>"\
                             "<p>目前支持安装 Debian</p>"\
                             "<p>程序版本：" + QString(APP_VERSION) + "</p>"\
                             "<p>QQ 交流群：881201853</p>"\
                             "<p>本程序依照 GPLV3 协议开源</p>"\
                             "<hr>"\
                             "<p>程序地址：</p>"\
                             "<pre><code>\n"\
                             "Gitee：https://gitee.com/gfdgd-xi/deepin-community-live-cd-online-installer\n"\
                             "Github：https://github.com/gfdgd-xi/deepin-community-live-cd-online-installer\n"\
                             "</code></pre>"\
                             "<hr>"\
                             "<h1>©2022~" + QString::number(year) + " gfdgd xi</h1>");
}

AboutProgram::~AboutProgram()
{
    delete ui;
}
