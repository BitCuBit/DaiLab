//
//  DAILabRoomViewController_iPad.h
//  DAILab
//
//  Created by Pablo Casado Varela on 01/02/13.
//  Copyright (c) 2013 Pablo Casado Varela. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import <CoreMotion/CoreMotion.h>

#import "DAILabSceneRoom.h"

@interface DAILabRoomViewController_iPad : UIViewController <GLKViewDelegate,GLKViewControllerDelegate> {
    CMMotionManager *mm;
    NSOperationQueue *queueAccelerometer;
    NSOperationQueue *queueGyroscope;
    DAILabSceneRoom *cube;
    float ant;
    float antUpDown;
    
    
}

@property (strong, nonatomic) EAGLContext *context;
@property (strong, nonatomic) GLKView *glView;
@property (strong, nonatomic) GLKViewController *viewController;


@end
