//
// Created by deamon on 22.06.17.
//

#ifndef WOWVIEWERLIB_SKINGEOM_H
#define WOWVIEWERLIB_SKINGEOM_H

#include <vector>
#include "../persistance/header/skinFileHeader.h"
#include "../persistance/header/M2FileHeader.h"
#include "../../gapi/interface/IDevice.h"
#include "../../include/wowScene.h"

class SkinGeom {
public:
    SkinGeom(std::string fileName){};
    SkinGeom(int fileDataId){};

    void process(HFileContent skinFile, const std::string &fileName);
    HGIndexBuffer getIBO(IDevice &device);

    bool isLoaded() { return m_loaded; };
    M2SkinProfile * getSkinData(){ if (m_loaded) {return m_skinData;} else {return nullptr;}};

    void fixData(M2Data *m2File);
private:
    HFileContent m2Skin;
    M2SkinProfile *m_skinData = nullptr;

    HGIndexBuffer indexVbo = HGIndexBuffer(nullptr);
    bool m_loaded = false;
    bool m_fixed = false;

    void fixShaderIdBasedOnLayer(M2Data *m2Filem2File);

    void fixShaderIdBasedOnBlendOverride(M2Data *m2File);
};


#endif //WOWVIEWERLIB_SKINGEOM_H
