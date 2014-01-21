//
//  ListasViewController.h
//  ShoppingPrecios
//
//  Created by RealGroup02 on 15/01/14.
//  Copyright (c) 2014 RealGroup02. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListasDAO.h"

@interface ListasViewController : UIViewController
{
	ListasDAO *dao;
	NSMutableArray *listas;
}
- (IBAction)boton:(id)sender;

@property (nonatomic, strong) ListasDAO *dao;
@property (nonatomic, strong) NSMutableArray *listas;

@end
