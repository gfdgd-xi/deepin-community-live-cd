#include "diskcontrol.h"
#include <unistd.h>
#include <stdio.h>
#include <QProcess>
#include <QDebug>
#include <sys/vfs.h>

#include <QMessageBox>

DiskControl::DiskControl()
{
    // 检测是否以 root 权限运行
    // 该库需要以 root 权限运行
    if(!geteuid() == 0){
        throw "Please run program with root!";
    }
}

// 获取命令输出
QString DiskControl::GetCommandReturn(QString command){
    QProcess process;
    process.start(command);
    process.waitForFinished();
    QString result = process.readAllStandardOutput();
    process.close();
    return result;
}

void DiskControl::GetDiskInfo(QStringList *diskPath, QStringList *diskFormat, QStringList *freeSpaceList, QStringList *totalSpaceList, QStringList *mountPathList){
    // 清空列表
    diskPath->clear();
    diskFormat->clear();
    freeSpaceList->clear();
    totalSpaceList->clear();
    mountPathList->clear();
    QStringList diskList;
    QString infoStr = GetCommandReturn("fdisk -l");
    // 筛选字符串
    QStringList oldList = infoStr.split("\n");
    // 获取分区列表
    for(int i = 0; i < oldList.size(); i++){
        QString info = oldList.at(i);
        // 判断是不是分区
        if(info.trimmed().mid(0, 5) == "/dev/"){
            // 二次筛选出路径
            QStringList diskInfoList = info.split(" ");
            QString disk = diskInfoList.at(0);
            diskPath->append(disk);
            // 筛选分区格式
            //diskFormat->append(diskInfoList.at(diskInfoList.count() - 1));
        }

    }
    // 获取分区格式和大小
    for (int i = 0; i < diskPath->size(); i++){
        QString disk = diskPath->at(i);
        QStringList resultList = GetCommandReturn("df -H -T " + disk + "").split("\n").at(1).trimmed().split(" ");
        resultList.removeAll("");
        qDebug() << resultList;
        diskFormat->append(resultList.at(1));
        mountPathList->append(resultList.at(resultList.count() - 1));
        freeSpaceList->append(resultList.at(resultList.count() - 3));
        totalSpaceList->append(resultList.at(resultList.count() - 5));
    }
}
