//
//  ShoppingPreciosViewController.m
//  ShoppingPrecios
//
//  Created by RealGroup02 on 15/01/14.
//  Copyright (c) 2014 RealGroup02. All rights reserved.
//

#import "ShoppingPreciosViewController.h"

@interface ShoppingPreciosViewController ()

@end

@implementation ShoppingPreciosViewController
@synthesize webservice;

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *docsDir;
    NSArray *dirPaths;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = dirPaths[0];
    
    _databasePath = [[NSString alloc]initWithString: [docsDir stringByAppendingPathComponent:@"bdshoppingdeprecios.sqlite"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath: _databasePath ] == NO)
    {
        const char *dbpath = [_databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &_bdshoppingdeprecios) == SQLITE_OK)
        {
            char *errMsg;
     //     const char *sql_stmt = "CREATE TABLE IF NOT EXISTS USUARIOS (ID INTEGER PRIMARY KEY AUTOINCREMENT, NOMBRE TEXT, PASSWORD TEXT)";
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS SESION_USUARIO (ID INTEGER PRIMARY KEY AUTOINCREMENT, NOMBRE TEXT, PASSWORD TEXT)";
            
            
            const char *sql_stmt2 = "CREATE TABLE IF NOT EXISTS LISTAS (ID INTEGER PRIMARY KEY AUTOINCREMENT, NOMBRE TEXT, COMPETENCIA integer)";

            if (sqlite3_exec(_bdshoppingdeprecios, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                _mensaje.text = @"Error al crear la tabla";
            }

            if (sqlite3_exec(_bdshoppingdeprecios, sql_stmt2, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                _mensaje.text = @"Error al crear la tabla";
            }
            sqlite3_close(_bdshoppingdeprecios);
        }
        else
        {
            _mensaje.text = @"Error al abrir la Base de Datos";
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 

- (IBAction)ingresar:(id)sender
{
    
     sqlite3_stmt    *statement;
     const char *dbpath = [_databasePath UTF8String];
     
     if (sqlite3_open(dbpath, &_bdshoppingdeprecios) == SQLITE_OK)
     {
         NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO USUARIOS (nombre, password) VALUES (\"%@\", \"%@\")",self.usuario.text, self.clave.text];
         
         //        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO listas (nombre, competencia) VALUES (\"%@\", 1)",self.usuario.text];
     
         //        "SELECT id, nombre_vehiculo, numero_ruedas FROM vehiculo";
         const char *insert_stmt = [insertSQL UTF8String];
     
         sqlite3_prepare_v2(_bdshoppingdeprecios, insert_stmt, -1, &statement, NULL);
     
         if (sqlite3_step(statement) == SQLITE_DONE)
         {
             self.mensaje.text = @"";
             self.usuario.text = @"";
             self.clave.text = @"";
         }
         else
         {
             self.mensaje.text = @"Error ";
         }
     
         sqlite3_finalize(statement);
         sqlite3_close(_bdshoppingdeprecios);
     }
    
     
    ///////////////
    
    webservice = [[WebService alloc] init];
    BOOL autorizado = [webservice validaUsuario:_usuario.text withDataString: _clave.text];

    if (autorizado)
    {
        NSLog(@"Autorizado");
        
    }
    else
    {
          NSLog(@"No Autorizado");
    }
    
 
}

- (IBAction)offline:(id)sender
{
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &_bdshoppingdeprecios) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT login_usuario, clave FROM sesion_usuario WHERE login_usuario=\"%@\" and clave=\"%@\" ", _usuario.text,_clave.text];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(_bdshoppingdeprecios, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *addressField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                _clave.text = addressField;
                _mensaje.text = @"Ok";
            }
            else
            {
                _mensaje.text = @"Usuario o Password incorrecto";
                _clave.text = @"";
            }
            sqlite3_finalize(statement);
        }
        
        sqlite3_close(_bdshoppingdeprecios);
    }
    

}
@end
