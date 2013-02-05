//
//  DAILabSceneLivingRoom.h
//  DAILab
//
//  Created by Pablo Casado Varela on 31/01/13.
//  Copyright (c) 2013 Pablo Casado Varela. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

#define M_TAU (2*M_PI)

@interface DAILabSceneLivingRoom : NSObject {
    GLKVector3 position;
    float factor;
    float factorUpDown;
    Boolean up;
    GLKTextureInfo *textureFront;
    GLKTextureInfo *textureLeft;
    GLKTextureInfo *textureBack;
    GLKTextureInfo *textureRight;
    GLKTextureInfo *textureTop;
    GLKTextureInfo *textureBottom;
    GLKVector2 *textureCoordinates;

}

@property (strong, nonatomic) GLKBaseEffect *baseEffect;

- (void) update;
- (void) render;
- (void) updateFactor:(float)fact;
- (void) updateFactorUpDown:(float)fact;


@end
