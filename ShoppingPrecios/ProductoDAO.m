//
//  ProductoDAO.m
//  ShoppingPrecios
//
//  Created by RealGroup02 on 21/01/14.
//  Copyright (c) 2014 RealGroup02. All rights reserved.
//

#import "ProductoDAO.h"

@implementation ProductoDAO

@synthesize dbManager;

-(BOOL)insertaProducto:(NSString *)idProducto idCompetencia:(NSString *)idCompetencia idLista:(NSString *)idLista
        codigoProducto:(NSString *)codigoProducto nombreProducto:(NSString *)nombreProducto descripcionProducto:(NSString *)descripcionProducto
        precioAnterior:(NSString *)precioAnterior precioSodimac:(NSString *)precioSodimac precioActual:(NSString *)precioActual mismoPrecio:(NSString *)mismoPrecio
           observacion:(NSString *)observacion encontrado:(NSString *)encontrado fechaHora:(NSString *)fechaHora
{
    dbManager = [[DBManager alloc] init];
    
    NSString *ubicacionDB = [dbManager obtenerRutaBD];
    
	
	if(!(sqlite3_open([ubicacionDB UTF8String], &bd) == SQLITE_OK))
    {
		NSLog(@"No se puede conectar con la BD");
	}
    
    
	NSString *insertSQL = [NSString stringWithFormat:@"insert into productos (id_producto, id_competencia, id_lista, codigo_producto, nombre_producto, descripcion_producto, precio_anterior, precio_sodimac, precio_actual, mismo_precio, observacion, encontrado, fecha_hora) "
    "VALUES (%@, %@, %@, \"%@\", \"%@\",\"%@\",  %@, %@, %@, %@, \"%@\", %@, %@ )",
    idProducto, idCompetencia, idLista, codigoProducto, nombreProducto, descripcionProducto, precioAnterior, precioSodimac, precioActual, mismoPrecio, observacion, encontrado, fechaHora];
    
    const char *insert_stmt = [insertSQL UTF8String];
    
	sqlite3_stmt *sqlStatement;
	
	if(sqlite3_prepare_v2(bd, insert_stmt, -1, &sqlStatement, NULL) != SQLITE_OK)
    {
		NSLog(@"Problema al preparar el statement");
	}
    
    if (sqlite3_step(sqlStatement) == SQLITE_DONE)
    {
        
    }
    else
    {
        //  self.mensaje.text = @"Error ";
    }
    
    sqlite3_finalize(sqlStatement);
    
    sqlite3_close(bd);
    
    
    return YES;


}
@end
