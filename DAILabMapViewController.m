//
//  DAILabMapViewController.m
//  DAILab
//
//  Created by Pablo Casado Varela on 01/02/13.
//  Copyright (c) 2013 Pablo Casado Varela. All rights reserved.
//

#import "DAILabMapViewController.h"

@interface DAILabMapViewController ()

@end

@implementation DAILabMapViewController
@synthesize imageViewBathRoom;
@synthesize imageViewLivingRoom;
@synthesize imageViewRoom;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UITapGestureRecognizer *panGestureLivingRoom = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(panLivingRoom:)];
    panGestureLivingRoom.numberOfTapsRequired = 1;
    [self.imageViewLivingRoom addGestureRecognizer:panGestureLivingRoom];
    
    UITapGestureRecognizer *panGestureRoom = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(panRoom:)];
    panGestureRoom.numberOfTapsRequired = 1;
    [self.imageViewRoom addGestureRecognizer:panGestureRoom];
    
    UITapGestureRecognizer *panGestureBathRoom = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(panBathRoom:)];
    panGestureBathRoom.numberOfTapsRequired = 1;
    [self.imageViewBathRoom addGestureRecognizer:panGestureBathRoom];


}


- (void)panLivingRoom:(UIPanGestureRecognizer *)gesture {
    DAILabPrincipalViewController_iPad *principal = [[DAILabPrincipalViewController_iPad alloc] init];
    principal.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    [self presentViewController:principal animated:YES completion:^{}];



}
- (void)panRoom:(UIPanGestureRecognizer *)gesture {
    DAILabRoomViewController_iPad *room = [[DAILabRoomViewController_iPad alloc] init];
    room.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    [self presentViewController:room animated:YES completion:^{}];

}
- (void)panBathRoom:(UIPanGestureRecognizer *)gesture {
    DAILabBathRoomViewController_iPad *bathRoom = [[DAILabBathRoomViewController_iPad alloc] init];
    bathRoom.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    [self presentViewController:bathRoom animated:YES completion:^{}];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
