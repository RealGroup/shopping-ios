//
//  UsuarioDAO.h
//  ShoppingPrecios
//
//  Created by RealGroup02 on 20/01/14.
//  Copyright (c) 2014 RealGroup02. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "DBManager.h"

@interface UsuarioDAO : NSObject
{
    sqlite3 *bd;
    DBManager *dbManager;
    
}
@property (nonatomic, strong) DBManager *dbManager;


- (BOOL)insertaUsuario:(NSString*)idUsuario nombreUsuario:(NSString *)nombreUsuario loginUsuario:(NSString *)loginUsuario clave:(NSString *)clave;


@end
