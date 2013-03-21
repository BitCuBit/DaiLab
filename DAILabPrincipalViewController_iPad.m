//
//  DAILabPrincipalViewController_iPad.m
//  DAILab
//
//  Created by Pablo Casado Varela on 31/01/13.
//  Copyright (c) 2013 Pablo Casado Varela. All rights reserved.
//

#import "DAILabPrincipalViewController_iPad.h"

@interface DAILabPrincipalViewController_iPad ()

@end

@implementation DAILabPrincipalViewController_iPad

#define kFilteringFactor 0.1
#define kAccelerometerFrequency 50.0 //Hz
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
    
    // Añado reconocimiento de arrastre de imagen
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:panGesture];

    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    [self.view addGestureRecognizer:pinchGesture];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [glView addGestureRecognizer:tapGesture];
    
    [self.view addSubview:glView];

}

- (void) viewDidUnload {
    GLKView *view = (GLKView *)self.view;
    [EAGLContext setCurrentContext:view.context];
    
    ((GLKView *)self.view).context = nil;
    [EAGLContext setCurrentContext:nil];
}

- (void)tap:(UITapGestureRecognizer *)gesture {
    CGPoint sit = [gesture locationInView:glView];
    NSLog(@"X: %f, Y: %f", sit.x, sit.y);
}

- (void)pinch:(UIPanGestureRecognizer *)gesture {

//    [self dismissViewControllerAnimated:YES completion:^{}];

}


/* Gestiona el movimiento de arrastre tactil con los dedos */
- (void)pan:(UIPanGestureRecognizer *)gesture {
    float x = [gesture locationInView:self.view].x;
    float y = [gesture locationInView:self.view].y;
    


    
    float factor = x - ant;
    float factorUpDown = y - antUpDown;
    
    if (factor > 0.5) {
        [cube updateFactor:0.05];
        
    }
    else if (factor < -0.5){
        [cube updateFactor:-0.05];
        
    }
    else
        [cube updateFactor:0.0];
    
    if (factorUpDown > 0.5) {
        [cube updateFactorUpDown:-0.05];
        
    }
    else if (factorUpDown < -0.5){
        [cube updateFactorUpDown:0.05];
        
    }
    else
        [cube updateFactorUpDown:0.0];
    ant = x;
    antUpDown = y;
    
    
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


                    [cube updateFactorUpDown:-gyroData.rotationRate.x * kFactorUpdate];

                    [cube updateFactor:-gyroData.rotationRate.y * kFactorUpdate];


                
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
