//
//  DAILabPrincipalViewController_iPhone.h
//  DAILab
//
//  Created by Pablo Casado Varela on 31/01/13.
//  Copyright (c) 2013 Pablo Casado Varela. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import <CoreMotion/CoreMotion.h>
#import "DAILabSceneLivingRoom.h"


@interface DAILabPrincipalViewController_iPhone : UIViewController <GLKViewDelegate,GLKViewControllerDelegate>{
    CMMotionManager *mm;
    NSOperationQueue *queueAccelerometer;
    NSOperationQueue *queueGyroscope;
    DAILabSceneLivingRoom *cube;
    float ant;
    float antUpDown;
    
    
}


@property (strong, nonatomic) EAGLContext *context;
@property (strong, nonatomic) GLKView *glView;
@property (strong, nonatomic) GLKViewController *viewController;


@end
