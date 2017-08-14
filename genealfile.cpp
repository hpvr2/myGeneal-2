#include "genealfile.h"

#include <QFile>
#include <QTextStream>
#include <QDebug>

GenealFile::GenealFile(QObject *parent)
    : QObject(parent)
{

}

QString GenealFile::readFile(const QUrl &fileUrl) const
{
    QString out;

    QFile file(fileUrl.toLocalFile());
    if (!file.open(QFile::ReadOnly))
        qFatal("Failed to read %s", qPrintable(fileUrl.toLocalFile()));
    QTextStream stream(&file);
    stream.setAutoDetectUnicode(true);
    out = stream.readAll();
//    qDebug() << "Read:" << out;
    file.close();
    return out;
}

void GenealFile::writeFile(const QUrl &fileUrl, const QString &text) const
{
    QFile file(fileUrl.toLocalFile());
    if (!file.open(QFile::WriteOnly))
        qFatal("Failed to write %s", qPrintable(fileUrl.toLocalFile()));
    QTextStream stream(&file);
    stream << text;
    file.close();
}

bool GenealFile::fileExists(const QUrl &file) const
{
    return QFile::exists(file.toLocalFile());
}
