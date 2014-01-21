//
//  DBManager.h
//  ShoppingPrecios
//
//  Created by erer ererer on 1/19/14.
//  Copyright (c) 2014 RealGroup02. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>


@interface DBManager : NSObject

+ (void) eliminaUsuario:(NSInteger*)idUsuario;
- (NSString *)obtenerRutaBD;

@end
