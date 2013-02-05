//
//  DAILabPrincipalViewController_iPhone.m
//  DAILab
//
//  Created by Pablo Casado Varela on 31/01/13.
//  Copyright (c) 2013 Pablo Casado Varela. All rights reserved.
//

#import "DAILabPrincipalViewController_iPhone.h"

@interface DAILabPrincipalViewController_iPhone ()

@end

@implementation DAILabPrincipalViewController_iPhone

#define kFilteringFactor 0.1
#define kAccelerometerFrequency 60.0 //Hz
#define kFactorUpdate 0.0150

@synthesize context;
@synthesize glView;
@synthesize viewController;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        ant = 0.0;
        antUpDown = 0.0;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    // Cargo deteccion giroscopio
    [self loadGyroscope];
    
    //Cargo contexto OpenGL
    [self setupGL];
    
    //Creamos el cubo
    // Inicializo la escena del cubo
    cube = [[DAILabSceneLivingRoom alloc] init];
    
    [self.view addSubview:glView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) glkViewControllerUpdate:(GLKViewController *)controller {
    [cube update];
}

- (void) glkView:(GLKView *)view drawInRect:(CGRect)rect {
    [cube render];
}


/* Inicializa la carga de los datos del giroscopio */
- (void) loadGyroscope {
    
    mm = [[CMMotionManager alloc] init];
    if ([mm isGyroAvailable]) {
        if ([mm isGyroActive] == NO) {
            [mm setGyroUpdateInterval:1.0f / kAccelerometerFrequency];
            queueGyroscope = [[NSOperationQueue alloc] init];
            [mm startGyroUpdatesToQueue:queueGyroscope withHandler:^(CMGyroData *gyroData, NSError *error){
                
                [cube updateFactor:-gyroData.rotationRate.y * kFactorUpdate];
                [cube updateFactorUpDown:-gyroData.rotationRate.x * kFactorUpdate];
                
            }];
        }
    }
    
    
}


- (EAGLContext *) createBestEAGLContext {
    EAGLContext *eaglContext;
    eaglContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    if (eaglContext == nil)
        eaglContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
    return eaglContext;
}



/* Funcion que inicializa el contexto de OpenGL */
- (void) setupGL {
    
    context = [self createBestEAGLContext];
    [EAGLContext setCurrentContext:context];
    
    glView = [[GLKView alloc] initWithFrame:self.view.bounds context:context];
    glView.delegate = self;
    glView.drawableDepthFormat = GLKViewDrawableDepthFormatNone;
    
    // Creamos el controlador
    // Asignamos el delegado
    viewController = [[GLKViewController alloc] init];
    viewController.delegate = self;
    viewController.view = glView;
    
    // Gestión errores OpenGL
    GLenum err = glGetError();
    if (err != GL_NO_ERROR)
        NSLog(@"glGetError(): %d", (int)err);
    
}


@end
