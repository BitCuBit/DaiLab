//
//  DAILabSceneRoom.m
//  DAILab
//
//  Created by Pablo Casado Varela on 01/02/13.
//  Copyright (c) 2013 Pablo Casado Varela. All rights reserved.
//

#import "DAILabSceneRoom.h"

@implementation DAILabSceneRoom

@synthesize baseEffect;

- (id) init {
    self = [super init];
    if (self) {
        position = GLKVector3Make(0, 0, 0);
        factor = M_PI/2;
        factorUpDown = 0.0;
        up = TRUE;
        [self loadTextures];
        
    }
    return self;
}

- (void) loadTextures {
    UIImage *image = [UIImage imageNamed:@"FRONT_Room.png"];
    NSError *error;
    textureFront = [GLKTextureLoader textureWithCGImage:image.CGImage options:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:GLKTextureLoaderOriginBottomLeft] error:&error];
    if (error)
        NSLog(@"Error loading texture from image: %@", error);
    image = [UIImage imageNamed:@"LEFT_Room.png"];
    textureLeft = [GLKTextureLoader textureWithCGImage:image.CGImage options:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:GLKTextureLoaderOriginBottomLeft] error:&error];
    if (error)
        NSLog(@"Error loading texture from image: %@", error);
    image = [UIImage imageNamed:@"BACK_Room.png"];
    textureBack = [GLKTextureLoader textureWithCGImage:image.CGImage options:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:GLKTextureLoaderOriginBottomLeft] error:&error];
    if (error)
        NSLog(@"Error loading texture from image: %@", error);
    image = [UIImage imageNamed:@"RIGHT_Room.png"];
    textureRight = [GLKTextureLoader textureWithCGImage:image.CGImage options:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:GLKTextureLoaderOriginBottomLeft] error:&error];
    if (error)
        NSLog(@"Error loading texture from image: %@", error);
    image = [UIImage imageNamed:@"BOTTOM_Room.png"];
    textureBottom = [GLKTextureLoader textureWithCGImage:image.CGImage options:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:GLKTextureLoaderOriginBottomLeft] error:&error];
    if (error)
        NSLog(@"Error loading texture from image: %@", error);
    image = [UIImage imageNamed:@"TOP_Room.png"];
    textureTop = [GLKTextureLoader textureWithCGImage:image.CGImage options:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:GLKTextureLoaderOriginBottomLeft] error:&error];
    if (error)
        NSLog(@"Error loading texture from image: %@", error);
    
    
}


- (void) update {
}

- (void) updateFactor:(float)fact {
    factor += fact;
}

- (void) updateFactorUpDown:(float)fact {
    factorUpDown += fact;
    
    if (factorUpDown > 3.14/2 ) {
        factorUpDown = 3.14/2;
    }
    else if (factorUpDown < -3.14/2) {
        factorUpDown = -3.14/2;
    }
    
}

- (void) loadCoordinateTexture {
    // Textura
    textureCoordinates = [[NSMutableData dataWithLength:sizeof(GLKVector2)*4] mutableBytes];
    textureCoordinates[0] = GLKVector2Make(1, 1);
    textureCoordinates[1] = GLKVector2Make(0, 1);
    textureCoordinates[2] = GLKVector2Make(0, 0);
    textureCoordinates[3] = GLKVector2Make(1, 0);
    
}


- (void) render {
    glClearColor(0.5, 0.50, 0.5, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);
    
    
    GLKVector3 cubeFrontVertices[] = {
        {-20.0,20.0,20.0},
        {20.0,20.0,20.0},
        {20.0,-20.0,20.0},
        {-20.0,-20.0,20.0}
    };
    GLKVector3 cubeRightVertices [] = {
        {-20.0,20.0,-20.0},
        {-20.0,20.0,20.0},
        {-20.0,-20.0,20.0},
        {-20.0,-20.0,-20.0}
    };
    GLKVector3 cubeBackVertices [] = {
        {20.0,20.0,-20.0},
        {-20.0,20.0,-20.0},
        {-20.0,-20.0,-20.0},
        {20.0,-20.0,-20.0}
    };
    GLKVector3 cubeLeftVertices[] = {
        {20.0,20.0,20.0},
        {20.0,20.0,-20.0},
        {20.0,-20.0,-20.0},
        {20.0,-20.0,20.0}
    };
    
    GLKVector3 cubeBottomVertices [] = {
        {-20.0,-20.0,20.0},
        {20.0,-20.0,20.0},
        {20.0,-20.0,-20.0},
        {-20.0,-20.0,-20.0}
    };
    
    GLKVector3 cubeTopVertices [] = {
        {-20.0,20.0,-20.0},
        {20.0,20.0,-20.0},
        {20.0,20.0,20.0},
        {-20.0,20.0,20.0}
    };
    
    GLKVector4 colors[] = {
        GLKVector4Make(1.0, 1.0, 1.0, 1.0), // Red
        GLKVector4Make(1.0, 1.0, 1.0, 1.0), // Green
        GLKVector4Make(1.0, 1.0, 1.0, 1.0), // Blue
        GLKVector4Make(1.0, 1.0, 1.0, 1.0), // Black
        GLKVector4Make(1.0, 1.0, 1.0, 1.0), // Blue
        GLKVector4Make(1.0, 1.0, 1.0, 1.0), // Black
        GLKVector4Make(1.0, 1.0, 1.0, 1.0), // Red
        GLKVector4Make(1.0, 1.0, 1.0, 1.0), // Green
    };
    
    GLKVector4 colorVertices[] = {
        // Front
        colors[0], colors[1], colors[2],
        colors[0], colors[2], colors[3],
        // Right
        colors[1], colors[5], colors[6],
        colors[1], colors[6], colors[2],
        // Back
        colors[5], colors[4], colors[7],
        colors[5], colors[7], colors[6],
        // Left
        colors[4], colors[0], colors[3],
        colors[4], colors[3], colors[7],
        // Top
        colors[3], colors[2], colors[6],
        colors[3], colors[6], colors[7],
        // Bottom
        colors[4], colors[5], colors[1],
        colors[4], colors[1], colors[0],
    };
    
    
    baseEffect = [[GLKBaseEffect alloc] init];
    
    [self loadCoordinateTexture];
    
    GLKMatrix4 matrix = GLKMatrix4Multiply(GLKMatrix4MakeXRotation(factorUpDown),GLKMatrix4MakeYRotation(factor));
    
    baseEffect.transform.modelviewMatrix = GLKMatrix4Multiply(GLKMatrix4MakeLookAt(0, 0, -5, 0, 0, -1, 0, 1, 0), matrix);
    // Perspectiva 60º
    baseEffect.transform.projectionMatrix = GLKMatrix4MakePerspective(1.047, 1024 / 768, 0.1, -20);
    
    
    
    glEnable(GL_CULL_FACE);
    
    // Habilito textura
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, 0, textureCoordinates);
    // Habilito Color
    glEnableVertexAttribArray(GLKVertexAttribColor);
    glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, 0, colorVertices);
    
    
    
    // Cara FRONT #########################################
    
    // Texturas
    baseEffect.texture2d0.envMode = GLKTextureEnvModeModulate;
    baseEffect.texture2d0.target = GLKTextureTarget2D;
    baseEffect.texture2d0.name = textureFront.name;
    
    [baseEffect prepareToDraw];
    
    // Habilito Posición
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 0, cubeFrontVertices);
    
    
    glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
    
    // Cara LEFT #########################################
    
    baseEffect.texture2d0.envMode = GLKTextureEnvModeModulate;
    baseEffect.texture2d0.target = GLKTextureTarget2D;
    baseEffect.texture2d0.name = textureLeft.name;
    
    [baseEffect prepareToDraw];
    
    // Habilito Posición
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 0, cubeLeftVertices);
    
    glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
    
    // Cara BACK #########################################
    
    baseEffect.texture2d0.envMode = GLKTextureEnvModeModulate;
    baseEffect.texture2d0.target = GLKTextureTarget2D;
    baseEffect.texture2d0.name = textureBack.name;
    
    [baseEffect prepareToDraw];
    
    // Habilito Posición
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 0, cubeBackVertices);
    
    glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
    
    // Cara BOTTOM #########################################
    
    baseEffect.texture2d0.envMode = GLKTextureEnvModeModulate;
    baseEffect.texture2d0.target = GLKTextureTarget2D;
    baseEffect.texture2d0.name = textureBottom.name;
    
    [baseEffect prepareToDraw];
    
    // Habilito Posición
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 0, cubeBottomVertices);
    
    glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
    
    // Cara RIGHT #########################################
    
    baseEffect.texture2d0.envMode = GLKTextureEnvModeModulate;
    baseEffect.texture2d0.target = GLKTextureTarget2D;
    baseEffect.texture2d0.name = textureRight.name;
    
    [baseEffect prepareToDraw];
    
    // Habilito Posición
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 0, cubeRightVertices);
    
    glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
    
    
    // Cara TOP #########################################
    
    baseEffect.texture2d0.envMode = GLKTextureEnvModeModulate;
    baseEffect.texture2d0.target = GLKTextureTarget2D;
    baseEffect.texture2d0.name = textureTop.name;
    
    [baseEffect prepareToDraw];
    
    // Habilito Posición
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 0, cubeTopVertices);
    
    glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
    
    
    glDisableVertexAttribArray(GLKVertexAttribPosition);
    glDisableVertexAttribArray(GLKVertexAttribTexCoord0);
}


- (void) dealloc {
    textureBack = nil;
    textureBottom = nil;
    textureCoordinates = nil;
    textureFront = nil;
    textureLeft = nil;
    textureTop = nil;
    textureRight = nil;
}


@end
