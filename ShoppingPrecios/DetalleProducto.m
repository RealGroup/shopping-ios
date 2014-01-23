//
//  DetalleProducto.m
//  ShoppingPrecios
//
//  Created by RealGroup02 on 22/01/14.
//  Copyright (c) 2014 RealGroup02. All rights reserved.
//

#import "DetalleProducto.h"

@interface DetalleProducto ()

@end

@implementation DetalleProducto

@synthesize competencia;
@synthesize productoDAO;
@synthesize productos;
@synthesize producto;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    NSInteger idLista = competencia.idLista;
    NSInteger idCompetencia = competencia.idCompetencia;
  //  Producto *product = producto;
    
    productoDAO = [[ProductoDAO alloc] init];
    productos = [[NSMutableArray alloc] init];
    productos = [productoDAO listaProductos:idCompetencia idLista:idLista];
    
    _precioSodimac.text = [NSString stringWithFormat:@"%d", producto.precioSodimac ];
    _codigoProducto.text = producto.codigoProducto;
    _nombreProducto.text = producto.nombreProducto;
    _trabajado.on = producto.encontrado;
    
    
 //   producto.precioSodimac;
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
