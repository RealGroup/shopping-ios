//
//  VehiculoDAO.m
//  VehiculosCRUD
//
//  Created by Carlos Navarro Mallach on 04/07/12.
//  Copyright (c) 2012 Casa. All rights reserved.
//

#import "VehiculoDAO.h"
#import "Vehiculo.h"

@implementation VehiculoDAO
 
- (NSString *) obtenerRutaBD
{
    NSString *dirDocs;
    NSArray *rutas;
    NSString *rutaBD;
    
    rutas = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    dirDocs = [rutas objectAtIndex:0];
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    rutaBD = [[NSString alloc] initWithString:[dirDocs stringByAppendingPathComponent:@"vehiculos.sqlite"]];
    
    if([fileMgr fileExistsAtPath:rutaBD] == NO){
        [fileMgr copyItemAtPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"vehiculos.sqlite"] toPath:rutaBD error:NULL];
    }
    
    return rutaBD;
}

- (void) crearVehiculo:(NSString *)nombre ruedas:(NSInteger)ruedas
{
	NSString *ubicacionDB = [self obtenerRutaBD];
	
	if(!(sqlite3_open([ubicacionDB UTF8String], &bd) == SQLITE_OK))
    {
		NSLog(@"No se puede conectar con la BD");
		return;
	}
    else
    {
		NSString *sqlInsert = [NSString stringWithFormat:@"INSERT INTO vehiculo (nombre_vehiculo, numero_ruedas) VALUES ('%@', %d)", nombre, ruedas];
		const char *sql = [sqlInsert UTF8String];
		sqlite3_stmt *sqlStatement;
		
		if(sqlite3_prepare_v2(bd, sql, -1, &sqlStatement, NULL) != SQLITE_OK)
        {
			NSLog(@"Problema al preparar el statement");
			return;
		}
        else
        {
			if(sqlite3_step(sqlStatement) == SQLITE_DONE)
            {
				sqlite3_finalize(sqlStatement);
				sqlite3_close(bd);
			}
		}
		
	}
	
}

- (NSMutableArray *) obtenerVehiculos
{
	NSMutableArray *listaVehiculos = [[NSMutableArray alloc] init];
	NSString *ubicacionDB = [self obtenerRutaBD];
	
	if(!(sqlite3_open([ubicacionDB UTF8String], &bd) == SQLITE_OK))
    {
		NSLog(@"No se puede conectar con la BD");
	}
	
	const char *sentenciaSQL = "SELECT id, nombre_vehiculo, numero_ruedas FROM vehiculo";
	sqlite3_stmt *sqlStatement;
	
	if(sqlite3_prepare_v2(bd, sentenciaSQL, -1, &sqlStatement, NULL) != SQLITE_OK)
    {
		NSLog(@"Problema al preparar el statement");
	}
	
	while(sqlite3_step(sqlStatement) == SQLITE_ROW)
    {
		Vehiculo *vehiculo = [[Vehiculo alloc] init];
		vehiculo.vehiculoID = sqlite3_column_int(sqlStatement, 0);
		vehiculo.nombreVehiculo = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 1)];
		vehiculo.numeroRuedas = sqlite3_column_int(sqlStatement, 2);
		
		[listaVehiculos addObject:vehiculo];
	}
	
	return listaVehiculos;
}

- (void) actualizarVehiculo:(NSInteger) vehiculoID nombre:(NSString *)nombre ruedas:(NSInteger)ruedas
{
	NSString *ubicacionBD = [self obtenerRutaBD];
	
	if(!(sqlite3_open([ubicacionBD UTF8String], &bd) == SQLITE_OK))
    {
		NSLog(@"No se puede conectar con la BD");
		return;
	}
    else
    {
		NSString *sqlUpdate = [NSString stringWithFormat:@"UPDATE vehiculo SET nombre_vehiculo = '%@', numero_ruedas = %d WHERE id = %d", nombre, ruedas, vehiculoID];
		const char *sql = [sqlUpdate UTF8String];
		sqlite3_stmt *sqlStatement;

		if(sqlite3_prepare_v2(bd, sql, -1, &sqlStatement, NULL) != SQLITE_OK)
        {
			NSLog(@"Problema al preparar el statement.");
			return;
		}
        else
        {
			if(sqlite3_step(sqlStatement) == SQLITE_DONE)
            {
				sqlite3_finalize(sqlStatement);
				sqlite3_close(bd);
			}
		}
	}
}

- (void) borrarVehiculo:(NSInteger) vehiculoID
{
	NSString *ubicacionBD = [self obtenerRutaBD];
	
	if(!(sqlite3_open([ubicacionBD UTF8String], &bd) == SQLITE_OK))
    {
		NSLog(@"No se puede conectar con la BD");
		return;
	}
    else
    {
		NSString *sqlDelete = [NSString stringWithFormat:@"DELETE FROM vehiculo WHERE id = %d", vehiculoID];
		const char *sql = [sqlDelete UTF8String];
		sqlite3_stmt *sqlStatement;
		
		if(sqlite3_prepare_v2(bd, sql, -1, &sqlStatement, NULL) != SQLITE_OK)
        {
			NSLog(@"Problema al preparar el statement.");
			return;
		}
        else
        {
			if(sqlite3_step(sqlStatement) == SQLITE_DONE)
            {
				sqlite3_finalize(sqlStatement);
				sqlite3_close(bd);
			}
		}
	}
}

@end
