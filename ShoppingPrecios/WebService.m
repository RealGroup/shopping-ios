//
//  WebService.m
//  ShoppingPrecios
//
//  Created by RealGroup02 on 17/01/14.
//  Copyright (c) 2014 RealGroup02. All rights reserved.
//

#import "WebService.h"
#import "Listas.h"
#import "DBManager.h"
#include "GDataXMLNode.h"

@implementation WebService

NSString *valor;
NSString *elemento;
BOOL autorizado;
NSInteger idUsuario;
NSMutableArray *lista ;
@synthesize listasDAO;
@synthesize competenciaDAO;
@synthesize productoDAO;

- (NSMutableArray *) obtenerListas
{
	return lista;
}

static NSString *kXPath_Item = @"//listasAsiginadas";
static NSString *kNombre_Lista = @"nombreLista";
static NSString *kIdLista = @"idLista";
static NSString *kCompetencias = @"competenciasAsignada";

- (BOOL)validaUsuario:(NSString*)usuario withDataString:(NSString *)clave
{
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<soapenv:Envelope "
                             " xmlns:q0=\"http://service.login.shopping.sodimac.cl/\" xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"  xmlns:xsd=\"http://www.w3.org/2001/XMLSchema \""
                             " xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">"
                             "<soapenv:Header>"
                             "</soapenv:Header>"
                             "<soapenv:Body>"
                             "<q0:getAutentication><arg0>" ];
   
    soapMessage = [soapMessage stringByAppendingString:usuario];
    soapMessage = [soapMessage stringByAppendingString:@"</arg0><arg1>"] ;
    soapMessage = [soapMessage stringByAppendingString:clave];
    soapMessage = [soapMessage stringByAppendingString:@"</arg1>"];
    soapMessage = [soapMessage stringByAppendingString:@"</q0:getAutentication></soapenv:Body></soapenv:Envelope>"];
    
    NSLog(@"SOAP: %@",soapMessage );
    
  //  NSString *urlString = [NSString stringWithFormat:@"http://192.168.137.3:8090/shoppingPrecioInt/LoginPort"];
      NSString *urlString = [NSString stringWithFormat:@"http://192.168.0.15:8090/shoppingPrecioInt/LoginPort"];
    NSMutableURLRequest *theRequest = [[NSMutableURLRequest alloc] init] ;
    
    NSString *msgLength = [NSString stringWithFormat:@"%d",[soapMessage length]];
    
    [theRequest setURL:[NSURL URLWithString:urlString]];
    [theRequest addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue:msgLength forHTTPHeaderField:@"Content-Lenght"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest addValue:@"myhost.com" forHTTPHeaderField:@"Host"];
    [theRequest addValue:@"http://tempuri.org/function" forHTTPHeaderField:@"SOAPAction"];
    [theRequest setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSHTTPURLResponse* urlResponse = nil;

    NSError *error = [[NSError alloc] init];
    NSData *data = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&urlResponse error:&error];
    NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"Response Code: %d", [urlResponse statusCode]);
    NSLog(@"Response: %@", result);
    
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
    
    NSArray *itemslistas = [doc nodesForXPath:@"//return" error:nil];
    
    for (GDataXMLElement *lista in itemslistas)
    {
        
        NSArray *idListax = [lista elementsForName:@"autorizado"];
        NSString *idlistav ;
        
        for(GDataXMLElement *idLista in idListax)
        {
            idlistav =  idLista.stringValue;
        }
        if ([idlistav isEqualToString:@"true"])
        {
             
        }
  //      NSArray *listas = [lista elementsForName:kNombre_Lista];
    //    NSString *nombreLista;
        
        
    }
    
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    [parser setDelegate:self];
    [parser parse];  

    
    //--------------------------
    /*
    <soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:ser='http://service.sincronizacion.shopping.sodimac.cl/'>
    <soapenv:Header/>
    <soapenv:Body>
    <ser:getListasAsignadas>
    <arg0>1</arg0>
    <arg1>1389991694595</arg1>
    </ser:getListasAsignadas>
    </soapenv:Body>
    </soapenv:Envelope>
     */
    
    if (autorizado)
    {
        lista = [[NSMutableArray alloc] init];

         soapMessage = [NSString stringWithFormat:
@"<soapenv:Envelope xmlns:q0=\"http://service.sincronizacion.shopping.sodimac.cl/\" xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" >"
            "<soapenv:Header>"
            "</soapenv:Header>"
            "<soapenv:Body>"
            "<q0:getListasAsignadas><arg0>1" ];
  //    soapMessage = [soapMessage stringByAppendingString:usuario];
        soapMessage = [soapMessage stringByAppendingString:@"</arg0><arg1>189"];
   //     soapMessage = [soapMessage stringByAppendingString:clave];
        soapMessage = [soapMessage stringByAppendingString:@"</arg1>"];
        soapMessage = [soapMessage stringByAppendingString:@"</q0:getListasAsignadas></soapenv:Body></soapenv:Envelope>"];
     /*
        
    <soapenv:Envelope
    xmlns:q0="http://service.sincronizacion.shopping.sodimac.cl/"
    xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <soapenv:Header>
        </soapenv:Header>
        <soapenv:Body>
        
        <q0:getListasAsignadas>
        <arg0>1</arg0>
        <arg1>2222</arg1>
        </q0:getListasAsignadas>
        
        </soapenv:Body>
        </soapenv:Envelope>
        */
        /*
        soapMessage = [NSString stringWithFormat:
                       @"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ser=\"http://service.sincronizacion.shopping.sodimac.cl/\">"
        "<soapenv:Header/>"
        "<soapenv:Body>"
        "<ser:getListasAsignadas>"
        "<arg0>1</arg0>"
        "<arg1>221</arg1>"
        "</ser:getListasAsignadas>"
        "</soapenv:Body>"
        "</soapenv:Envelope>"];
        
        */
        NSLog(@"SOAP: %@",soapMessage );
        
        urlString = [NSString stringWithFormat:@"http://192.168.0.15:8090/shoppingPrecioInt/ObtenerListasPort"];
        
        msgLength = [NSString stringWithFormat:@"%d",[soapMessage length]];
        //  NSLog(@"sss %@", msgLength);
        
        [theRequest setURL:[NSURL URLWithString:urlString]];
        [theRequest addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [theRequest addValue:msgLength forHTTPHeaderField:@"Content-Lenght"];
        [theRequest setHTTPMethod:@"POST"];
        [theRequest addValue:@"myhost.com" forHTTPHeaderField:@"Host"];
        [theRequest addValue:@"http://tempuri.org/function" forHTTPHeaderField:@"SOAPAction"];
        [theRequest setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
        //   NSURLConnection theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
        
        NSHTTPURLResponse* urlResponse = nil;
        //  NSURLConnection *responseData = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
        NSError *error = [[NSError alloc] init];
        NSData *data = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&urlResponse error:&error];
        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSLog(@"Response Code: %d", [urlResponse statusCode]);
        NSLog(@"Response: %@", result);
//////////
        
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
       
        NSArray *itemslistas = [doc nodesForXPath:kXPath_Item error:nil];
        
        for (GDataXMLElement *lista in itemslistas)
        {
     
            NSArray *idListax = [lista elementsForName:kIdLista];
            NSString *idlistav ;
            
            for(GDataXMLElement *idLista in idListax)
            {
                idlistav =  idLista.stringValue;
            }
            
            NSArray *listas = [lista elementsForName:kNombre_Lista];
            NSString *nombreLista;
            
            for(GDataXMLElement *nombre in listas)
            {
                nombreLista =  nombre.stringValue;
            }
            NSString *mayor;
            
            NSArray *mayors = [lista elementsForName:@"toleranciaMayorQue"];
            if (mayors.count > 0)
            {
                GDataXMLElement *mayorx = (GDataXMLElement *) [mayors objectAtIndex:0];
                mayor = mayorx.stringValue;
            }
            
            NSString *menor;
            
            NSArray *menors = [lista elementsForName:@"toleranciaMenorQue"];
            if (menors.count > 0)
            {
                GDataXMLElement *menorx = (GDataXMLElement *) [menors objectAtIndex:0];
                menor = menorx.stringValue;
            }
            
           listasDAO = [[ListasDAO alloc] init];
           [listasDAO insertalista:idlistav nombreLista:nombreLista mayor:mayor menor:menor];
            
            NSArray *competencias = [lista elementsForName:kCompetencias];
            
            for(GDataXMLElement *competencia in competencias)
            {
                //NSString *comm = competencia.stringValue;
                NSString *idcompetencia;
                NSArray *idcompetencias = [competencia elementsForName:@"idCompetencia"];
                if (idcompetencias.count > 0)
                {
                    GDataXMLElement *idcompetenciax = (GDataXMLElement *) [idcompetencias objectAtIndex:0];
                    idcompetencia = idcompetenciax.stringValue;
                }
                
                NSString *nombreCompetencia;
                NSArray *nombrecompetencias = [competencia elementsForName:@"nombreCompetencia"];
                if (nombrecompetencias.count > 0)
                {
                    GDataXMLElement *nombreCompetenciax = (GDataXMLElement *) [nombrecompetencias objectAtIndex:0];
                    nombreCompetencia = nombreCompetenciax.stringValue;
                }
                
                NSString *idshopper;
                NSArray *idshoppers = [competencia elementsForName:@"idShopper"];
                if (idshoppers.count > 0)
                {
                    GDataXMLElement *idshopperx = (GDataXMLElement *) [idshoppers objectAtIndex:0];
                    idshopper = idshopperx.stringValue;
                }
                
                competenciaDAO = [[CompetenciaDAO alloc] init];
                [competenciaDAO insertaCompetencia:idcompetencia idLista:idlistav idShopper:idshopper nombreCompetencia:nombreCompetencia];
                
                NSArray *productosAsignados = [competencia elementsForName:@"productosAsignado"];
                
                for(GDataXMLElement *producto in productosAsignados)
                {
                    NSString *idProducto;
                    NSArray *idProductos = [producto elementsForName:@"idProducto"];
                    if (idProductos.count > 0)
                    {
                        GDataXMLElement *idProductox = (GDataXMLElement *) [idProductos objectAtIndex:0];
                        idProducto = idProductox.stringValue;
                 	}
                    
                    NSString *codigoProducto;
                    NSArray *codigoProductos = [producto elementsForName:@"codigoProducto"];
                    if (codigoProductos.count > 0)
                    {
                        GDataXMLElement *codigoProductox = (GDataXMLElement *) [codigoProductos objectAtIndex:0];
                        codigoProducto = codigoProductox.stringValue;
                 	}
                    
                    NSString *nombreProducto;
                    NSArray *nombreProductos = [producto elementsForName:@"nombreProducto"];
                    if (nombreProductos.count > 0)
                    {
                        GDataXMLElement *nombreProductox = (GDataXMLElement *) [nombreProductos objectAtIndex:0];
                        nombreProducto = nombreProductox.stringValue;
                 	}
                    
                    NSString *descripcionProducto;
                    NSArray *descripcionProductos = [producto elementsForName:@"descripcionProducto"];
                    if (descripcionProductos.count > 0)
                    {
                        GDataXMLElement *descripcionProductox = (GDataXMLElement *) [descripcionProductos objectAtIndex:0];
                        descripcionProducto = descripcionProductox.stringValue;
                 	}

                    NSString *precioAnterior;
                    NSArray *precioAnteriors = [producto elementsForName:@"precioAnterior"];
                    if (precioAnteriors.count > 0)
                    {
                        GDataXMLElement *precioAnteriorx = (GDataXMLElement *) [precioAnteriors objectAtIndex:0];
                        precioAnterior = precioAnteriorx.stringValue;
                 	}

                    NSString *precioSodimac;
                    NSArray *precioSodimacs = [producto elementsForName:@"precioSocimac"];
                    if (precioSodimacs.count > 0)
                    {
                        GDataXMLElement *precioSodimacx = (GDataXMLElement *) [precioSodimacs objectAtIndex:0];
                        precioSodimac = precioSodimacx.stringValue;
                 	}
                    
                    NSString *precioActual;
                    NSArray *precioActuals = [producto elementsForName:@"precioActual"];
                    if (precioActuals.count > 0)
                    {
                        GDataXMLElement *precioActualx = (GDataXMLElement *) [precioActuals objectAtIndex:0];
                        precioActual = precioActualx.stringValue;
                 	}
                    
                    NSString *encontrado;
                    NSArray *encontrados = [producto elementsForName:@"encontrado"];
                    
                    if (encontrados.count > 0)
                    {
                        GDataXMLElement *encontradox = (GDataXMLElement *) [encontrados objectAtIndex:0];
                        encontrado = encontradox.stringValue;
                 	}
                    NSString *fechaHora;
                    NSArray *fechaHoras = [producto elementsForName:@"fechaHora"];
                    
                    if (fechaHoras.count > 0)
                    {
                        GDataXMLElement *fechaHorax = (GDataXMLElement *) [fechaHoras objectAtIndex:0];
                        fechaHora = fechaHorax.stringValue;
                        
                        NSDateFormatter *ConvertFormat;
                        int *DateTimeConverted;
                        
                        ConvertFormat = [[NSDateFormatter alloc] init];
                        [ConvertFormat setDateFormat:@"yyyyMMddHHmmss"];
                        
             //           DateTimeConverted = [ConvertFormat stringFromDate:fechaHora];
                    
                    
                    
                    }
                    
                    productoDAO = [[ProductoDAO alloc] init];
                    
                    [productoDAO insertaProducto:idProducto idCompetencia:idcompetencia idLista:idlistav codigoProducto:codigoProducto nombreProducto:nombreProducto descripcionProducto:descripcionProducto precioAnterior:precioAnterior precioSodimac:precioSodimac precioActual:precioActual mismoPrecio:@"0" observacion:@" " encontrado:encontrado fechaHora:@"12345"];
                    
            //        [competenciaDAO insertaCompetencia:idcompetencia idLista:idlistav idShopper:idshopper nombreCompetencia:nombreCompetencia];
                    
                    
                }
            }
            
 
            
  //          [self performSelectorOnMainThread:@selector(parsedSong:) withObject:song waitUntilDone:NO];
            
            // performSelectorOnMainThread: will retain the object until the selector has been performed
            // so we can release our reference
     //       [song release];
        }
       
     //   [doc release];
          /*
        NSTimeInterval duration = [NSDate timeIntervalSinceReferenceDate] - start;
        [self performSelectorOnMainThread:@selector(addToParseDuration:) withObject:[NSNumber numberWithDouble:duration] waitUntilDone:NO];
        [self performSelectorOnMainThread:@selector(parseEnded) withObject:nil waitUntilDone:NO];
        self.xmlData = nil;
        // Set the condition which ends the run loop.
        done = YES;
        */
        
        
//////////
  //      NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
   //     [parser setDelegate:self];
  //      [parser parse];
    }
    return autorizado;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    elemento = elementName;
    if([elementName isEqualToString:@"autorizado"])
    {
        elemento = elementName;
  
    }
    else if ([elementName isEqualToString:@"nombreLista"])
    {
        elemento = @"nombreLista";
    }
    
    
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if ([elemento isEqualToString:@"autorizado"])
    {
        if ([string isEqualToString:@"true"])
        {
            autorizado = YES;
            idUsuario=1;
            NSLog(@"Autorizado= %@", string);
            
            
            [DBManager eliminaUsuario:idUsuario];
        }
        else
        {
            autorizado = NO;
        }
        elemento = @"";
    }
   /*
    else if ([elemento isEqualToString:@"nombreLista"])
    {
        idUsuario=1;
            
        Listas *listas = [[Listas alloc] init];
		listas.listaID = 1;
		listas.nombreLista = string;
	//	listas.competenciaID = 1;
		
		[lista addObject:listas];
        elemento=@"";
  
    }*/
}


@end
