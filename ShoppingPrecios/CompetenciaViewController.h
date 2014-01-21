//
//  CompetenciaViewController.h
//  ShoppingPrecios
//
//  Created by RealGroup02 on 15/01/14.
//  Copyright (c) 2014 RealGroup02. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Listas.h"

@interface CompetenciaViewController : UITableViewController
{
    Listas *lista;
}

@property (nonatomic, strong) Listas *lista;

@end
