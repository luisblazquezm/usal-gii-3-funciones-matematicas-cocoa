//
//  PanelModificationController.m
//  iMaths
//
//  Created by Luis Blazquez Miñambres on 13/10/18.
//  Copyright © 2018 Luis Blazquez Miñambres. All rights reserved.
//

#import "PanelModificationController.h"
#import "GraphicsClass.h"

@interface PanelModificationController ()

@end

@implementation PanelModificationController

extern NSString *PanelModifyGraphicNotification;

/*!
 * @brief  Inicializa todas las variables de instancias declaradass en fichero .h .
 * @return id, puntero genérico.
 */
-(id)init
{
    if (![super initWithWindowNibName:@"PanelModificationController"])
        return nil;
    
    return self;
}


/*!
 * @brief  Inicializa la ventana principal con el panel
 * @param  window .Ventana panelController.
 * @return instancetype.
 */
-(instancetype)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self){
        NSLog(@"En init PanelModification");
        //modelInPanel = [[PanelModel alloc] init];
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self
               selector:@selector(handleModifyGraphic:)
                   name:PanelModifyGraphicNotification
                 object:nil];
    }
    
    return self;
}


-(BOOL)windowShouldClose:(NSWindow *)sender
{
    NSInteger respuesta;
    
    respuesta = NSRunAlertPanel(@"Atencion",
                                @"¿Está seguro de que desea cerrar la ventana?.Esta accion finalizará la ejecución de la aplicación ",
                                @"No",
                                @"Si",
                                nil);
    
    if(respuesta == NSAlertDefaultReturn)
        return NO;
    else
        [NSApp terminate:self];
    return YES;
    
}

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

-(void)handleModifyGraphic:(NSNotification *)aNotification
{
    NSLog(@"Notificacion %@ recibida en handleModifyGraphic\r", aNotification);
    NSDictionary *notificationInfoReceived = [aNotification userInfo];
    GraphicsClass *graphic = [notificationInfoReceived objectForKey:@"graphicToModify"];
    
    [newFunction setStringValue:[graphic function]];
    [newName setStringValue:[graphic funcName]];
    [newParamA setFloatValue:[graphic paramA]];
    [newParamB setFloatValue:[graphic paramB]];
    [newParamN setFloatValue:[graphic paramN]];
    [newColour setColor:[graphic colour]];
    
}

-(IBAction)confirmNewGraphic:(id)sender
{
    
}

-(IBAction)cancelNewGraphic:(id)sender
{
    
}



@end
