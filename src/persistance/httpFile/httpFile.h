#ifndef WOWMAPVIEWERREVIVED_HTTPFILE_H
#define WOWMAPVIEWERREVIVED_HTTPFILE_H

#include <string>
#include <vector>
#include <functional>
//curl
#include "cpr/cpr.h"
#include "../../wowViewerLib/src/include/sharedFile.h"

class HttpFile;

typedef std::function<void (HFileContent)> HTTPReadyCallback ;

class HttpFile {

public:
    HttpFile(std::string httpUrl){
        this->m_httpUrl = httpUrl;
        this->written = 0;
//        this->m_callback = nullptr;
        this->m_fileBuffer;
    }

    ~HttpFile(){

    }

public:
    void startDownloading();
    void setCallback(HTTPReadyCallback callback);
    void writeToBuffer(void *buffer, long int size);

private:
    std::string m_httpUrl;
    HTTPReadyCallback m_callback;

    long int fileSize;
    long int written;
    HFileContent m_fileBuffer;


};


#endif //WOWMAPVIEWERREVIVED_HTTPFILE_H
