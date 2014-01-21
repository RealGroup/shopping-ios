//
//  ListasViewController.h
//  ShoppingPrecios
//
//  Created by RealGroup02 on 15/01/14.
//  Copyright (c) 2014 RealGroup02. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListasDAO.h"
#import "WebService.h"

@interface ListasViewController : UITableViewController
{
	ListasDAO *dao;
    WebService *webservice;
	NSMutableArray *listas;
}

@property (nonatomic, strong) ListasDAO *dao;
@property (nonatomic, strong) WebService *webservice;
@property (nonatomic, strong) NSMutableArray *listas;

@end
