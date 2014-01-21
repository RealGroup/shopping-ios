//
//  VehiculoDAO.h
//  VehiculosCRUD
//
//  Created by Carlos Navarro Mallach on 04/07/12.
//  Copyright (c) 2012 Casa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface VehiculoDAO : NSObject{
    
	sqlite3 *bd;
}

- (void) crearVehiculo: (NSString *)nombre ruedas:(NSInteger) ruedas;
- (NSMutableArray *) obtenerVehiculos;
- (void) actualizarVehiculo: (NSInteger) vehiculoID nombre:(NSString *)nombre ruedas:(NSInteger) ruedas;
- (void) borrarVehiculo: (NSInteger) vehiculoID;
- (NSString *) obtenerRutaBD;

@end
