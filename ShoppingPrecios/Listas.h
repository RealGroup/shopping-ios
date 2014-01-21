//
//  Listas.h
//  ShoppingPrecios
//
//  Created by RealGroup02 on 15/01/14.
//  Copyright (c) 2014 RealGroup02. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Listas : NSObject
{
	NSInteger listaID;
	NSString *nombreLista;
	NSInteger competenciaID;
}

@property (nonatomic, assign) NSInteger listaID;
@property (nonatomic, retain) NSString *nombreLista;
@property (nonatomic, assign) NSInteger competenciaID;


@end

