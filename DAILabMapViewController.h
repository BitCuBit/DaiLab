//
//  DAILabMapViewController.h
//  DAILab
//
//  Created by Pablo Casado Varela on 01/02/13.
//  Copyright (c) 2013 Pablo Casado Varela. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAILabPrincipalViewController_iPad.h"
#import "DAILabRoomViewController_iPad.h"
#import "DAILabBathRoomViewController_iPad.h"

@interface DAILabMapViewController : UIViewController


@property (strong, nonatomic) IBOutlet UIImageView *imageViewRoom;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewLivingRoom;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewBathRoom;

@end
