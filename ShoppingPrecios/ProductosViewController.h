//
//  ProductosViewController.h
//  ShoppingPrecios
//
//  Created by RealGroup02 on 22/01/14.
//  Copyright (c) 2014 RealGroup02. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Competencia.h"
#import "ProductoDAO.h"

@interface ProductosViewController : UITableViewController
{
   Competencia *competencia;
   ProductoDAO *productoDAO;
   NSMutableArray *productos;
    
}

@property (nonatomic, strong) Competencia *competencia;
@property (nonatomic, strong) ProductoDAO *productoDAO;
@property (nonatomic, strong) NSMutableArray *productos;

@end
