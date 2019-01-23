#ifndef FILELOADER_H
#define FILELOADER_H

#include <QThread>
#include <QObject>
#include <QDirIterator>
#include "utils/bae.h"

class CollectionDB;
class FileLoader : public QObject
{
    Q_OBJECT

public:
    FileLoader();

    ~FileLoader() override;

    void requestPaths(const QStringList &paths);

    void nextTrack();

public slots:

    void getTracks(const QStringList &paths);

signals:
    void trackReady(BAE::DB track);
    void finished(int size);
    void collectionSize(int size);

private:
    QThread t;
    CollectionDB *db;
    bool go = false;
    bool wait = true;
    QStringList queue;
};


#endif // FILELOADER_H
