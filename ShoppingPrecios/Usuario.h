//
//  Usuario.h
//  ShoppingPrecios
//
//  Created by RealGroup02 on 20/01/14.
//  Copyright (c) 2014 RealGroup02. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Usuario : NSObject
{
    NSInteger idUsuario;
    NSString *nombreUsuario;
    NSString *loginUsuario;
    NSString *clave;
}

@property (nonatomic, assign) NSInteger idUsuario;
@property (nonatomic, retain) NSString *nombreUsuario;
@property (nonatomic, retain) NSString *loginUsuario;
@property (nonatomic, retain) NSString *clave;

@end
