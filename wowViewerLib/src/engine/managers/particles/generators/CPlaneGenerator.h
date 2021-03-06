//
// Created by deamon on 17.01.18.
//

#ifndef WEBWOWVIEWERCPP_CPLANEGENERATOR_H
#define WEBWOWVIEWERCPP_CPLANEGENERATOR_H


#include "../CRndSeed.h"
#include "CParticleGenerator.h"

class CPlaneGenerator : public CParticleGenerator {
public:
    CPlaneGenerator(CRndSeed &cRndSeed, M2Particle *particle) : CParticleGenerator(cRndSeed, particle) {

    }

    ~CPlaneGenerator() override {}

    void CreateParticle(CParticle2 &p, animTime_t delta) override;
};


#endif //WEBWOWVIEWERCPP_CPLANEGENERATOR_H
