//
//  CompetenciaViewController.m
//  ShoppingPrecios
//
//  Created by RealGroup02 on 15/01/14.
//  Copyright (c) 2014 RealGroup02. All rights reserved.
//

#import "CompetenciaViewController.h"
#import "Competencia.h"
#import "ProductosViewController.h"

@interface CompetenciaViewController ()

@end

@implementation CompetenciaViewController

@synthesize lista;
@synthesize competenciaDAO;
@synthesize competencias;


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
  

    NSInteger idLista = lista.listaID;
    
    competenciaDAO = [[CompetenciaDAO alloc] init];
    competencias = [[NSMutableArray alloc] init];
    competencias = [competenciaDAO obtenerCompetencias:idLista];
    [super viewDidLoad];
}


- (void) viewWillAppear:(BOOL)animated
{
    NSInteger idLista = lista.listaID;
    
    competenciaDAO = [[CompetenciaDAO alloc] init];
    competencias = [[NSMutableArray alloc] init];
    competencias = [competenciaDAO obtenerCompetencias:idLista];
    
	[self.tableView reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [competencias count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
  
    return cell;*/
    static NSString *CellIdentifier = @"celda";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Display recipe in the table cell
    NSInteger xx = indexPath.row;
    Competencia  *competencia = [competencias objectAtIndex:xx];
    
    //   UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    //    recipeImageView.image = [UIImage imageNamed:listas.imageFile];
    
    UILabel *nombreLista = (UILabel *)[cell viewWithTag:103];
    nombreLista.text = competencia.nombreCompetencia;
    
    UILabel *cantidad = (UILabel *)[cell viewWithTag:104];
    cantidad.text = competencia.cantidad;
    
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
  
    ProductosViewController *destino = [self.storyboard instantiateViewControllerWithIdentifier:@"product"];
    
	Competencia *tmp = [competencias objectAtIndex:[indexPath row]];
    tmp.idLista =  lista.listaID;
        
	destino.competencia = tmp;
	
	[self.navigationController pushViewController:destino animated:YES];
    
}

@end
