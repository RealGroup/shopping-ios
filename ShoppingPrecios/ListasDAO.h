//
//  ListasDAO.h
//  ShoppingPrecios
//
//  Created by RealGroup02 on 15/01/14.
//  Copyright (c) 2014 RealGroup02. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface ListasDAO : NSObject
{
    
	sqlite3 *bd;
}
 
- (NSMutableArray *) obtenerListas;
- (NSString *) obtenerRutaBD;
- (BOOL)insertalista:(NSString*)idLista nombreLista:(NSString *)nombreLista mayor:(NSString *)mayor menor:(NSString *)menor;
@end
