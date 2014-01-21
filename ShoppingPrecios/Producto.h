//
//  Producto.h
//  ShoppingPrecios
//
//  Created by RealGroup02 on 21/01/14.
//  Copyright (c) 2014 RealGroup02. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Producto : NSObject
{
    NSInteger idProducto;
    NSInteger idCompetencia;
    NSInteger idLista;
    NSString  *codigoProducto;
    NSString  *nombreProducto;
    NSString  *descripcionProducto;
    NSInteger precioAnterior;
    NSInteger precioSodimac;
    NSInteger precioActual;
    NSInteger mismoPrecio;
    NSString  *observacion;
    NSInteger encontrado;
    NSInteger fechaHora;
}

@property (nonatomic, assign)NSInteger idProducto;
@property (nonatomic, assign)NSInteger idCompetencia;
@property (nonatomic, assign)NSInteger idLista;
@property (nonatomic, retain)NSString *codigoProducto;
@property (nonatomic, retain)NSString *nombreProducto;
@property (nonatomic, retain)NSString *descripcionProducto;
@property (nonatomic, assign)NSInteger precioAnterior;
@property (nonatomic, assign)NSInteger precioSodimac;
@property (nonatomic, assign)NSInteger precioActual;
@property (nonatomic, assign)NSInteger mismoPrecio;
@property (nonatomic, retain)NSString *observacion;
@property (nonatomic, assign)NSInteger encontrado;
@property (nonatomic, assign)NSInteger fechaHora;

@end
