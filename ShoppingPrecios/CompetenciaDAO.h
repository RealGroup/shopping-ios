//
//  CompetenciaDAO.h
//  ShoppingPrecios
//
//  Created by RealGroup02 on 20/01/14.
//  Copyright (c) 2014 RealGroup02. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "DBManager.h"

@interface CompetenciaDAO : NSObject
{
    sqlite3 *bd;
    DBManager *dbManager;
}

@property (nonatomic, strong)DBManager *dbManager;

-(BOOL)insertaCompetencia:(NSString *)idCompetencia idLista:(NSString *)idLista idShopper:(NSString *)idShopper nombreCompetencia:(NSString *)nombreCompetencia;
- (NSMutableArray *) obtenerCompetencias:(NSInteger)idLista;

@end
