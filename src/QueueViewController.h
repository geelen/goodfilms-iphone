//
//  QueueViewController.h
//  goodfilms
//
//  Created by Glen Maddern on 23/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface QueueViewController : UITableViewController

@property (readwrite, retain) User *user;

@end
