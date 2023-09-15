#ifndef DISKCONTROL_H
#define DISKCONTROL_H

#include <QStringList>

class DiskControl
{
private:
    QString GetCommandReturn(QString command);

public:
    DiskControl();

    void GetDiskInfo(QStringList *diskPath, QStringList *diskFormat, QStringList *freeSpaceList, QStringList *totalSpaceList, QStringList *mountPathList);
};

#endif // DISKCONTROL_H
