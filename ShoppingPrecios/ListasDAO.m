//
//  ListasDAO.m
//  ShoppingPrecios
//
//  Created by RealGroup02 on 15/01/14.
//  Copyright (c) 2014 RealGroup02. All rights reserved.
//

#import "ListasDAO.h"
#import "Listas.h"

@implementation ListasDAO

- (NSString *) obtenerRutaBD
{
    NSString *dirDocs;
    NSArray *rutas;
    NSString *rutaBD;
    
    rutas = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    dirDocs = [rutas objectAtIndex:0];
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    rutaBD = [[NSString alloc] initWithString:[dirDocs stringByAppendingPathComponent:@"bdshoppingdeprecios.sqlite"]];
    
    if([fileMgr fileExistsAtPath:rutaBD] == NO)
    {
        [fileMgr copyItemAtPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"bdshoppingdeprecios.db"] toPath:rutaBD error:NULL];
    }
    
    return rutaBD;
}

- (BOOL)insertalista:(NSString*)idLista nombreLista:(NSString *)nombreLista mayor:(NSString *)mayor menor:(NSString *)menor
{  
	NSString *ubicacionDB = [self obtenerRutaBD];
	
	if(!(sqlite3_open([ubicacionDB UTF8String], &bd) == SQLITE_OK))
    {
		NSLog(@"No se puede conectar con la BD");
	}
    
	NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO LISTAS (id_lista, nombre_lista, mayor, menor) VALUES (%@, \"%@\", %@, %@)",idLista, nombreLista, mayor,menor];
    
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
        return NO;
    }
    
    sqlite3_finalize(sqlStatement);
    sqlite3_close(bd);    
    
    return YES;
}


- (NSMutableArray *) obtenerListas
{
	NSMutableArray *lista = [[NSMutableArray alloc] init];
	NSString *ubicacionDB = [self obtenerRutaBD];
	
	if(!(sqlite3_open([ubicacionDB UTF8String], &bd) == SQLITE_OK))
    {
		NSLog(@"No se puede conectar con la BD");
	}
	
    const char *sentenciaSQL = "SELECT LST.ID_LISTA ID_LISTA,LST.NOMBRE_LISTA,count(LST.ID_LISTA) CANTIDAD FROM LISTAS LST,COMPETENCIAS COMP WHERE COMP.ID_LISTA = LST.ID_LISTA AND COMP.ID_SHOPPER = 1 GROUP BY LST.ID_LISTA";
    
//      const char *sentenciaSQL = "SELECT LST.ID_LISTA ID_LISTA,LST.NOMBRE_LISTA,count(LST.ID_LISTA) CANTIDAD FROM LISTAS LST,COMPETENCIAS COMP WHERE COMP.ID_LISTA = LST.ID_LISTA AND COMP.ID_SHOPPER = " + currentIdShopper + " GROUP BY LST.ID_LISTA";
    
//	const char *sentenciaSQL = "SELECT id_lista, nombre_lista FROM listas";
    
	sqlite3_stmt *sqlStatement;
	
	if(sqlite3_prepare_v2(bd, sentenciaSQL, -1, &sqlStatement, NULL) != SQLITE_OK)
    {
		NSLog(@"Problema al preparar el statement");
	}
	
	while(sqlite3_step(sqlStatement) == SQLITE_ROW)
    {
		Listas *listas = [[Listas alloc] init];
		listas.listaID = sqlite3_column_int(sqlStatement, 0);
		listas.nombreLista = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 1)];
        listas.cantidad    = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 2)];
                           
	//	listas.competenciaID = sqlite3_column_int(sqlStatement, 2);
		
		[lista addObject:listas];
	}
	
	return lista;
}

@end
