//
//  ListasViewController.m
//  ShoppingPrecios
//
//  Created by RealGroup02 on 15/01/14.
//  Copyright (c) 2014 RealGroup02. All rights reserved.
//

#import "ListasViewController.h"
#import "Listas.h"
#import "CompetenciaViewController.h"

@interface ListasViewController ()

@end

@implementation ListasViewController
@synthesize dao;
@synthesize listas;
@synthesize webservice;

NSInteger offline=0;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    dao = [[ListasDAO alloc] init];
    listas = [[NSMutableArray alloc] init];
    listas = [dao obtenerListas];
    
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload]; 
}

- (void) viewWillAppear:(BOOL)animated
{
	listas = [[NSMutableArray alloc] init];
    listas = [dao obtenerListas];
    
	[self.tableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [listas count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    static NSString *CellIdentifier = @"celda";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSString *nombre =      [[listas objectAtIndex:[indexPath row]] valueForKey:@"nombreLista"];
    
    cell.textLabel.text = nombre ;
	
    return cell;
     */
    
    static NSString *CellIdentifier = @"celda";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Display recipe in the table cell
    NSInteger xx = indexPath.row;
    Listas *lista = [listas objectAtIndex:xx];
    
 //   UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
//    recipeImageView.image = [UIImage imageNamed:listas.imageFile];
    
    UILabel *nombreLista = (UILabel *)[cell viewWithTag:101];
    nombreLista.text = lista.nombreLista;
    
    UILabel *cantidad = (UILabel *)[cell viewWithTag:102];
    cantidad.text = lista.cantidad;
    
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
	CompetenciaViewController *destino = [self.storyboard instantiateViewControllerWithIdentifier:@"competencias"];
    
	Listas *tmp = [listas objectAtIndex:[indexPath row]];
	destino.lista = tmp;
	
	[self.navigationController pushViewController:destino animated:YES];
}

@end
