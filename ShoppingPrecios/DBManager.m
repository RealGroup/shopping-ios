//
//  DBManager.m
//  ShoppingPrecios
//
//  Created by erer ererer on 1/19/14.
//  Copyright (c) 2014 RealGroup02. All rights reserved.
//

#import "DBManager.h"
#import "Definiciones.h"

@implementation DBManager

+ (void) eliminaUsuario:(NSInteger *)idUsuario
{
    sqlite3 *database;
    
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
    
    if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK)
    {
   //     const char *sqlStatement = [[NSString stringWithFormat:@"DELETE from Seguimiento WHERE codigo = '%@'", idUsuario] UTF8String];
     
        const char *sqlStatement = [[NSString stringWithFormat:@"DELETE from SESSION_USUARIO" ] UTF8String];
        
        sqlite3_exec(database, sqlStatement, NULL, NULL, NULL);
    }
    
    sqlite3_close(database);
}

- (NSString *)obtenerRutaBD
{

    NSString *dirDocs;
    NSArray *rutas;
    NSString *rutaBD;
    
    rutas = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    dirDocs = [rutas objectAtIndex:0];
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    rutaBD = [[NSString alloc] initWithString:[dirDocs stringByAppendingPathComponent:databaseName]];
    
    if([fileMgr fileExistsAtPath:rutaBD] == NO)
    {
        [fileMgr copyItemAtPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName] toPath:rutaBD error:NULL];
    }
    
    return rutaBD;
}
@end
