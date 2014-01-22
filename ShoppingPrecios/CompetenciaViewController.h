//
//  CompetenciaViewController.h
//  ShoppingPrecios
//
//  Created by RealGroup02 on 15/01/14.
//  Copyright (c) 2014 RealGroup02. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Listas.h"
#import "CompetenciaDAO.h"

@interface CompetenciaViewController : UITableViewController
{
    Listas *lista;
    CompetenciaDAO *competenciaDAO;
    NSMutableArray *competencias;
    
}

@property (nonatomic, strong) Listas *lista;
@property (nonatomic,strong) CompetenciaDAO *competenciaDAO;
@property (nonatomic, strong) NSMutableArray *competencias;

@end
