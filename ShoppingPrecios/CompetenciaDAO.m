//
//  CompetenciaDAO.m
//  ShoppingPrecios
//
//  Created by RealGroup02 on 20/01/14.
//  Copyright (c) 2014 RealGroup02. All rights reserved.
//

#import "CompetenciaDAO.h"
#import "Competencia.h"

@implementation CompetenciaDAO

@synthesize dbManager;

-(BOOL)insertaCompetencia:(NSString *)idCompetencia idLista:(NSString *)idLista idShopper:(NSString *)idShopper nombreCompetencia:(NSString *)nombreCompetencia
{
    
    dbManager = [[DBManager alloc] init];
    
    NSString *ubicacionDB = [dbManager obtenerRutaBD];
	
	if(!(sqlite3_open([ubicacionDB UTF8String], &bd) == SQLITE_OK))
    {
		NSLog(@"No se puede conectar con la BD");
	}
 
	NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO competencias (id_competencia, id_lista, id_shopper, nombre_competencia) VALUES (%@, %@, %@, \"%@\")",idCompetencia, idLista, idShopper, nombreCompetencia];
    
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

- (NSMutableArray *) obtenerCompetencias:(NSInteger)idLista
{

    NSMutableArray *competencias = [[NSMutableArray alloc] init];
    
    dbManager = [[DBManager alloc] init];
    NSString *ubicacionDB = [dbManager obtenerRutaBD];
	
	if(!(sqlite3_open([ubicacionDB UTF8String], &bd) == SQLITE_OK))
    {
		NSLog(@"No se puede conectar con la BD");
	}
	
//    const char *sentenciaSQL = "SELECT LST.ID_LISTA ID_LISTA,LST.NOMBRE_LISTA,count(LST.ID_LISTA) CANTIDAD FROM LISTAS LST,COMPETENCIAS COMP WHERE COMP.ID_LISTA = LST.ID_LISTA AND COMP.ID_SHOPPER = 1 GROUP BY LST.ID_LISTA";
    NSString *idl = [NSString stringWithFormat:@"%d", idLista ];
    
    NSString *sentenciaSQL = @"SELECT COUNT(*) CANTIDAD,COMP.ID_COMPETENCIA,COMP.ID_SHOPPER,COMP.NOMBRE_COMPETENCIA FROM COMPETENCIAS COMP,PRODUCTOS PROD WHERE PROD.ID_COMPETENCIA = COMP.ID_COMPETENCIA AND PROD.ID_LISTA = COMP.ID_LISTA AND COMP.ID_LISTA =";
 
    
    sentenciaSQL = [sentenciaSQL stringByAppendingString:idl];
    sentenciaSQL = [sentenciaSQL stringByAppendingString: @" GROUP BY PROD.ID_COMPETENCIA"];
    
    //      const char *sentenciaSQL = "SELECT LST.ID_LISTA ID_LISTA,LST.NOMBRE_LISTA,count(LST.ID_LISTA) CANTIDAD FROM LISTAS LST,COMPETENCIAS COMP WHERE COMP.ID_LISTA = LST.ID_LISTA AND COMP.ID_SHOPPER = " + currentIdShopper + " GROUP BY LST.ID_LISTA";
    
    //	const char *sentenciaSQL = "SELECT id_lista, nombre_lista FROM listas";
    const char *insert_stmt = [sentenciaSQL UTF8String];
	sqlite3_stmt *sqlStatement;
	
	if(sqlite3_prepare_v2(bd, insert_stmt, -1, &sqlStatement, NULL) != SQLITE_OK)
    {
		NSLog(@"Problema al preparar el statement");
	}
	
	while(sqlite3_step(sqlStatement) == SQLITE_ROW)
    {
		Competencia *competencia = [[Competencia alloc] init];
		competencia.idCompetencia = sqlite3_column_int(sqlStatement, 1);
		competencia.nombreCompetencia = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 3)];
        competencia.cantidad   = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 0)];
        
        //	listas.competenciaID = sqlite3_column_int(sqlStatement, 2);
		
		[competencias addObject:competencia];
	}
	
	return competencias;

}

@end
