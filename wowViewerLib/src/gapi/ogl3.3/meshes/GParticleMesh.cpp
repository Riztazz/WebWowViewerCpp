//
// Created by Deamon on 7/24/2018.
//

#include "GParticleMesh.h"

GParticleMesh::GParticleMesh(IDevice &device, const gMeshTemplate &meshTemplate) : GMeshGL33(device, meshTemplate){
    m_meshType = MeshType::eParticleMesh;
}