//
//  ShoppingPreciosViewController.h
//  ShoppingPrecios
//
//  Created by RealGroup02 on 15/01/14.
//  Copyright (c) 2014 RealGroup02. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "WebService.h"

@interface ShoppingPreciosViewController : UIViewController
{
  WebService *webservice;
}

@property (strong, nonatomic) IBOutlet UITextField *usuario;
@property (strong, nonatomic) IBOutlet UITextField *clave;
@property (strong, nonatomic) IBOutlet UILabel *mensaje;
 
- (IBAction)ingresar:(id)sender;
- (IBAction)offline:(id)sender;
@property (nonatomic, strong) WebService *webservice;
@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *bdshoppingdeprecios;

@end
