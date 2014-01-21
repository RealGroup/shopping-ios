//
//  Competencia.h
//  ShoppingPrecios
//
//  Created by RealGroup02 on 20/01/14.
//  Copyright (c) 2014 RealGroup02. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Competencia : NSObject
{
    NSInteger idCompetencia;
    NSInteger idLista;
    NSInteger idShopper;
    NSString  *nombrecompetencia;
}
@property (nonatomic, assign)NSInteger idCompetencia;
@property (nonatomic, assign)NSInteger idLista;
@property (nonatomic, assign)NSInteger idShopper;
@property (nonatomic, retain)NSString *nombreCompetencia;


@end
