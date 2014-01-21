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
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
 //   if(offline)
  //  {
        dao = [[ListasDAO alloc] init];
        listas = [[NSMutableArray alloc] init];
        listas = [dao obtenerListas];
//	}
 //   else
 //   {
  //      webservice = [[WebService alloc] init];
  //      listas = [[NSMutableArray alloc] init];
  //      listas = [webservice obtenerListas];
  //  }
    
    [super viewDidLoad];

}

- (void)viewDidUnload
{
    [super viewDidUnload]; 
}

- (void) viewWillAppear:(BOOL)animated
{
	listas = [[NSMutableArray alloc] init];
    
 //   if(offline)
//    {
    
    listas = [dao obtenerListas];
    
  /*
    }
    else
    {
    //    webservice = [[WebService alloc] init];
    //       listas = [[NSMutableArray alloc] init];
            listas = [webservice obtenerListas];
            
    }*/
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
    static NSString *CellIdentifier = @"celda";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSString *nombre =      [[listas objectAtIndex:[indexPath row]] valueForKey:@"nombreLista"];
    
    cell.textLabel.text = nombre ;
	
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
