//
//  ProductoDAO.h
//  ShoppingPrecios
//
//  Created by RealGroup02 on 21/01/14.
//  Copyright (c) 2014 RealGroup02. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "DBManager.h"

@interface ProductoDAO : NSObject
{
    sqlite3 *bd;
    DBManager *dbManager;
}

@property (nonatomic, strong)DBManager *dbManager;

-(BOOL)insertaProducto:(NSString *)idProducto idCompetencia:(NSString *)idCompetencia idLista:(NSString *)idLista codigoProducto:(NSString *)codigoProducto nombreProducto:(NSString *)nombreProducto descripcionProducto:(NSString *)descripcionProducto precioAnterior:(NSInteger)precioAnterior precioActual:(NSInteger)precioActual mismoPrecio:(NSInteger)mismoPrecio observacion:(NSString *)observacion encontrado:(NSInteger)encontrado fechaHora:(NSInteger)fechaHora;

@end
