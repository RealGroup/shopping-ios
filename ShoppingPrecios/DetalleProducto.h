//
//  DetalleProducto.h
//  ShoppingPrecios
//
//  Created by RealGroup02 on 22/01/14.
//  Copyright (c) 2014 RealGroup02. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Competencia.h"
#import "ProductoDAO.h"
#import "Producto.h"

@interface DetalleProducto : UIViewController
{
    Competencia *competencia;
    ProductoDAO *productoDAO;
    NSMutableArray *productos;
    Producto *producto;
    
}
@property (strong, nonatomic) IBOutlet UILabel *precioSodimac;
@property (strong, nonatomic) IBOutlet UILabel *nombreLista;
@property (strong, nonatomic) IBOutlet UILabel *codigoProducto;
@property (strong, nonatomic) IBOutlet UILabel *nombreProducto;
@property (strong, nonatomic) IBOutlet UISwitch *trabajado;
@property (strong, nonatomic) IBOutlet UISwitch *mismoPrecio;
@property (strong, nonatomic) IBOutlet UITextField *precio;
@property (strong, nonatomic) IBOutlet UITextView *observaciones;

@property (nonatomic, strong)Competencia *competencia;
@property (nonatomic, strong)ProductoDAO *productoDAO;
@property (nonatomic, strong)NSMutableArray *productos;
@property (nonatomic, strong)Producto *producto;

@end
