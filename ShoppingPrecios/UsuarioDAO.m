//
//  UsuarioDAO.m
//  ShoppingPrecios
//
//  Created by RealGroup02 on 20/01/14.
//  Copyright (c) 2014 RealGroup02. All rights reserved.
//

#import "UsuarioDAO.h"
#import "Usuario.h"

@implementation UsuarioDAO

@synthesize dbManager;

-(BOOL)insertaUsuario:(NSString *)idUsuario nombreUsuario:(NSString *)nombreUsuario loginUsuario:(NSString *)loginUsuario clave:(NSString *)clave;
{

    dbManager = [[DBManager alloc] init];
    
   NSString *ubicacionDB = [dbManager obtenerRutaBD];
    
//    NSString *ubicacionDB = [self obtenerRutaBD];
	
	if(!(sqlite3_open([ubicacionDB UTF8String], &bd) == SQLITE_OK))
    {
		NSLog(@"No se puede conectar con la BD");
	}
    //login_usuario, clave FROM sesion_usuario
	NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO sesion_usuario (id_usuario, nombre_usuario, login_usuario, clave) VALUES (%@, \"%@\", \"%@\", \"%@\")",idUsuario, nombreUsuario, loginUsuario, clave];
    
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
