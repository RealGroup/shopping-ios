//
//  ProductosViewController.m
//  ShoppingPrecios
//
//  Created by RealGroup02 on 22/01/14.
//  Copyright (c) 2014 RealGroup02. All rights reserved.
//

#import "ProductosViewController.h"
#import "ProductoDAO.h"
#import "Producto.h"

@interface ProductosViewController ()

@end

@implementation ProductosViewController

@synthesize competencia;
@synthesize productoDAO;
@synthesize productos;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    NSInteger idCompetencia = competencia.idCompetencia;
    NSInteger idLista = competencia.idLista;
    
    productoDAO = [[ProductoDAO alloc] init];
    
    productos = [[NSMutableArray alloc] init];
    productos = [productoDAO listaProductos:idCompetencia idLista:idLista ];
    
    //productos = [productoDAO obtenerProductos]
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [productos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
     static NSString *CellIdentifier = @"Cell";
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
     
     return cell;*/
    static NSString *CellIdentifier = @"celda2";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Display recipe in the table cell
    NSInteger xx = indexPath.row;
    Producto *producto = [productos objectAtIndex:xx];
    
    /*
     UIImage *image = [UIImage imageNamed:[self.images objectAtIndex:imageIndex]];
     
     if (image)
     {
     [cell.buttonView1 setImage:image forState:UIControlStateNormal];
     }
     */
    
    
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    if(producto.encontrado>0)
    {
       recipeImageView.image = [UIImage imageNamed:@"shoppeado.png"];
    }
    else
    {
        recipeImageView.image = [UIImage imageNamed:@"sin_shoppear.png"];
    }
    
    UILabel *nombreProducto = (UILabel *)[cell viewWithTag:105];
    nombreProducto.text = producto.nombreProducto;
    
 //   UILabel *cantidad = (UILabel *)[cell viewWithTag:104];
   // cantidad.text = competencia.cantidad;
    
    // Assign our own background image for the cell
    //    UIImage *background = [self cellBackgroundForRowAtIndexPath:indexPath];
    
    //  UIImageView *cellBackgroundView = [[UIImageView alloc] initWithImage:background];
    //   cellBackgroundView.image = background;
    // cell.backgroundView = cellBackgroundView;
    
    return cell;

}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ProductosViewController *destino = [self.storyboard instantiateViewControllerWithIdentifier:@"detalleproducto"];
    
//	Competencia *tmp = [competencias objectAtIndex:[indexPath row]];
 //   tmp.idLista =  lista.listaID;
    
	//destino.competencia = tmp;
	
	[self.navigationController pushViewController:destino animated:YES];
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
