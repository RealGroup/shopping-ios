//
//  WebService.h
//  ShoppingPrecios
//
//  Created by RealGroup02 on 17/01/14.
//  Copyright (c) 2014 RealGroup02. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListasDAO.h"
#import "CompetenciaDAO.h"

@interface WebService : NSObject <NSXMLParserDelegate>

- (NSMutableArray *) obtenerListas;
- (BOOL)validaUsuario:(NSString*)usuario withDataString:(NSString *)clave;

@property (nonatomic, strong) ListasDAO *listasDAO;
@property (nonatomic, strong) CompetenciaDAO *competenciaDAO;

@end
