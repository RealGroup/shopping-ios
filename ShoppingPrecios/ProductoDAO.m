//
//  ProductoDAO.m
//  ShoppingPrecios
//
//  Created by RealGroup02 on 21/01/14.
//  Copyright (c) 2014 RealGroup02. All rights reserved.
//

#import "ProductoDAO.h"
#import "Producto.h"

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

-(NSMutableArray *)listaProductos:(NSInteger)idCompetencia idLista:(NSInteger)idLista
{
    /*
     SELECT PROD.PRECIO_ANTERIOR PRECIO_ANTERIOR,PROD.PRECIO_ACTUAL PRECIO_ACTUAL,PROD.ENCONTRADO ENCONTRADO,COMP.ID_COMPETENCIA,COMP.NOMBRE_COMPETENCIA NOMBRE_COMPETENCIA
     FROM PRODUCTOS PROD,COMPETENCIAS COMP';
     WHERE COMP.ID_COMPETENCIA = PROD.ID_COMPETENCIA AND COMP.ID_LISTA = PROD.ID_LISTA AND PROD.ID_LISTA  =' + idListaSel + '
     AND PROD.ID_PRODUCTO =' + idProductoSel;
     */
    NSMutableArray *productos = [[NSMutableArray alloc] init];
    
    dbManager = [[DBManager alloc] init];
    NSString *ubicacionDB = [dbManager obtenerRutaBD];
	
	if(!(sqlite3_open([ubicacionDB UTF8String], &bd) == SQLITE_OK))
    {
		NSLog(@"No se puede conectar con la BD");
	}
	
    //    const char *sentenciaSQL = "SELECT LST.ID_LISTA ID_LISTA,LST.NOMBRE_LISTA,count(LST.ID_LISTA) CANTIDAD FROM LISTAS LST,COMPETENCIAS COMP WHERE COMP.ID_LISTA = LST.ID_LISTA AND COMP.ID_SHOPPER = 1 GROUP BY LST.ID_LISTA";
    
  //  NSString *idCompetenciax = [NSString stringWithFormat:@"%d", idCompetencia];
 //   NSString *idListax = [NSString stringWithFormat:@"%d", idLista];
    
    
  //  NSString *sentenciaSQL = @"SELECT PROD.PRECIO_ANTERIOR PRECIO_ANTERIOR,PROD.PRECIO_ACTUAL PRECIO_ACTUAL,PROD.ENCONTRADO ENCONTRADO,COMP.ID_COMPETENCIA,COMP.NOMBRE_COMPETENCIA NOMBRE_COMPETENCIA FROM PRODUCTOS PROD,COMPETENCIAS COMP WHERE COMP.ID_COMPETENCIA = PROD.ID_COMPETENCIA AND COMP.ID_LISTA = PROD.ID_LISTA AND PROD.ID_LISTA  ='";
    
    /*
     SELECT PROD.ID_PRODUCTO,PROD.CODIGO_PRODUCTO,
     PROD.DESCRIPCION_PRODUCTO,PROD.NOMBRE_PRODUCTO,
     PROD.PRECIO_ANTERIOR,PROD.PRECIO_SODIMAC,
     PROD.PRECIO_ACTUAL,PROD.ENCONTRADO,PROD.MISMO_PRECIO,
     COMP.NOMBRE_COMPETENCIA NOMBRE_COMPETENCIA,LST.NOMBRE_LISTA NOMBRE_LISTA
     FROM PRODUCTOS PROD,COMPETENCIAS COMP,LISTAS LST
     WHERE COMP.ID_COMPETENCIA = PROD.ID_COMPETENCIA
     AND COMP.ID_LISTA = PROD.ID_LISTA
     AND LST.ID_LISTA = PROD.ID_LISTA';
     AND COMP.ID_COMPETENCIA =' + idCompetenciaSel + '
     AND PROD.ID_LISTA  =' + idListaSel;
     */
    
    
   NSString *sentenciaSQL = @"SELECT PROD.ID_PRODUCTO,PROD.CODIGO_PRODUCTO,PROD.DESCRIPCION_PRODUCTO,PROD.NOMBRE_PRODUCTO,PROD.PRECIO_ANTERIOR,PROD.PRECIO_SODIMAC,    PROD.PRECIO_ACTUAL,PROD.ENCONTRADO,PROD.MISMO_PRECIO,COMP.NOMBRE_COMPETENCIA NOMBRE_COMPETENCIA,LST.NOMBRE_LISTA NOMBRE_LISTA FROM PRODUCTOS PROD,COMPETENCIAS COMP,LISTAS LST WHERE COMP.ID_COMPETENCIA = PROD.ID_COMPETENCIA	AND COMP.ID_LISTA = PROD.ID_LISTA AND LST.ID_LISTA = PROD.ID_LISTA AND COMP.ID_COMPETENCIA =";
     sentenciaSQL = [sentenciaSQL stringByAppendingString:[NSString stringWithFormat:@"%d", idCompetencia]];
    sentenciaSQL = [sentenciaSQL stringByAppendingString:@" AND PROD.ID_LISTA ="];
    sentenciaSQL = [sentenciaSQL stringByAppendingString:[NSString stringWithFormat:@"%d", idLista]];
    
    const char *insert_stmt = [sentenciaSQL UTF8String];
	sqlite3_stmt *sqlStatement;
	
	if(sqlite3_prepare_v2(bd, insert_stmt, -1, &sqlStatement, NULL) != SQLITE_OK)
    {
		NSLog(@"Problema al preparar el statement");
	}
	
	while(sqlite3_step(sqlStatement) == SQLITE_ROW)
    {
        Producto *producto = [[Producto alloc] init];
        
		//Competencia *competencia = [[Competencia alloc] init];
		producto.idProducto = sqlite3_column_int(sqlStatement, 0);
		producto.nombreProducto = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 3)];
        
        NSString *str = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 7)];
        
        int aValue = [[str stringByReplacingOccurrencesOfString:@" " withString:@""] intValue];
        
        NSLog(@"%d", aValue);
        
        producto.encontrado   = aValue;
        
        //	listas.competenciaID = sqlite3_column_int(sqlStatement, 2);
		
		[productos addObject:producto];
	}
	
	return productos;
    

}

@end
