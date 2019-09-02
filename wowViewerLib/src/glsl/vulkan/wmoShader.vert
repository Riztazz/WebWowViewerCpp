#version 450

/* vertex shader code */
precision highp float;
layout (location = 0) in vec3 aPosition;
layout (location = 1) in vec3 aNormal;
layout (location = 2) in vec2 aTexCoord;
layout (location = 3) in vec2 aTexCoord2;
layout (location = 4) in vec2 aTexCoord3;
layout (location = 5) in vec4 aColor;
layout (location = 6) in vec4 aColor2;

layout(std140) uniform sceneWideBlockVSPS {
    mat4 uLookAtMat;
    mat4 uPMatrix;
};

layout(std140) uniform modelWideBlockVS {
    mat4 uPlacementMat;
};

layout(std140) uniform meshWideBlockVS {
    ivec4 VertexShader_UseLitColor;
};

out vec2 vTexCoord;
out vec2 vTexCoord2;
out vec2 vTexCoord3;
out vec4 vColor;
out vec4 vColor2;
out vec4 vPosition;
out vec3 vNormal;

#include commonFunctions

void main() {
    vec4 worldPoint = uPlacementMat * vec4(aPosition, 1);

    vec4 cameraPoint = uLookAtMat * worldPoint;


    mat4 viewModelMat = uLookAtMat * uPlacementMat;
    mat3 viewModelMatTransposed = mat3(
                viewModelMat[0].xyz,
                viewModelMat[1].xyz,
                viewModelMat[2].xyz
            );

    gl_Position = uPMatrix * cameraPoint;
    vPosition = vec4(cameraPoint.xyz, aColor.w);
    vNormal = normalize(viewModelMatTransposed * aNormal);

    vColor.rgba = vec4(vec3(0.5, 0.499989986, 0.5), 1.0);
    vColor2 = vec4((aColor.bgr * 2.0), aColor2.a);
    int uVertexShader = VertexShader_UseLitColor.x;
    #if(VERTEXSHADER==-1)
        vTexCoord = aTexCoord;
        vTexCoord2 = aTexCoord2;
        vTexCoord3 = aTexCoord3;
    #endif
    #if(VERTEXSHADER==0) //MapObjDiffuse_T1
        vTexCoord = aTexCoord;
        vTexCoord2 = aTexCoord2; //not used
        vTexCoord3 = aTexCoord3; //not used
    #endif
    #if(VERTEXSHADER==1) //MapObjDiffuse_T1_Refl
        vTexCoord = aTexCoord;
        vTexCoord2 = reflect(normalize(cameraPoint.xyz), vNormal).xy;
        vTexCoord3 = aTexCoord3; //not used
    #endif
    #if(VERTEXSHADER==2) //MapObjDiffuse_T1_Env_T2
        vTexCoord = aTexCoord;
        vTexCoord2 = posToTexCoord(vPosition.xyz, vNormal);;
        vTexCoord3 = aTexCoord3;
    #endif
    #if(VERTEXSHADER==3) //MapObjSpecular_T1
        vTexCoord = aTexCoord;
        vTexCoord2 = aTexCoord2; //not used
        vTexCoord3 = aTexCoord3; //not used
    #endif
    #if(VERTEXSHADER==4) //MapObjDiffuse_Comp
        vTexCoord = aTexCoord;
        vTexCoord2 = aTexCoord2; //not used
        vTexCoord3 = aTexCoord3; //not used
    #endif
    #if(VERTEXSHADER==5) //MapObjDiffuse_Comp_Refl
        vTexCoord = aTexCoord;
        vTexCoord2 = aTexCoord2;
        vTexCoord3 = reflect(normalize(cameraPoint.xyz), vNormal).xy;
    #endif
    #if(VERTEXSHADER==6) //MapObjDiffuse_Comp_Terrain
        vTexCoord = aTexCoord;
        vTexCoord2 = vPosition.xy * -0.239999995;
        vTexCoord3 = aTexCoord3; //not used
    #endif
    #if(VERTEXSHADER==7) //MapObjDiffuse_CompAlpha
        vTexCoord = aTexCoord;
        vTexCoord2 = vPosition.xy * -0.239999995;
        vTexCoord3 = aTexCoord3; //not used
    #endif
    #if(VERTEXSHADER==8) //MapObjParallax
        vTexCoord = aTexCoord;
        vTexCoord2 = vPosition.xy * -0.239999995;
        vTexCoord3 = aTexCoord3; //not used
    #endif

//
//    vs_out.vTexCoord = vTexCoord;
//    vs_out.vTexCoord2 = vTexCoord2;
//    vs_out.vTexCoord3 = vTexCoord3;
//    vs_out.vColor = vColor;
//    vs_out.vColor2 = vColor2;
//    vs_out.vPosition = vPosition;
//    vs_out.vNormal = vNormal;
}
