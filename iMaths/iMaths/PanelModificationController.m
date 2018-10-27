//
//  PanelModificationController.m
//  iMaths
//
//  Created by Luis Blazquez Miñambres on 13/10/18.
//  Copyright © 2018 Luis Blazquez Miñambres. All rights reserved.
//

#import "PanelModificationController.h"
#import "GraphicsClass.h"

/* --------- Esquema metodos ---------
 *   > Inicializadores
 *       - init()
 *       - initWithWindow()
 *   > Tratamiento de ventana
 *       - windowShouldClose()
 *       - windowDidLoad()
 *   > Acciones de modificación
 *       - handleModifyGraphic()
 *   > Tratamiento de botones de modificación
 *       - confirmNewGraphic()
 *       - cancelNewGraphic()
 */

@interface PanelModificationController ()

@end

@implementation PanelModificationController

extern NSString *ModifyGraphicNotification;
NSString *PanelGraphicModifiedNotification = @"PanelGraphicModified";

/* --------------------------- INICIALIZADORES ---------------------- */

/*!
 * @brief  Inicializa todas las variables de instancias declaradass en fichero .h .
 * @return id, puntero genérico.
 */
-(id) init
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
-(instancetype) initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self){
        NSLog(@"En init PanelModification");
        fieldsChanged = NO;
        
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self
               selector:@selector(handleModifyGraphic:)
                   name:ModifyGraphicNotification
                 object:nil];
    }
    
    return self;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
-(BOOL) windowShouldClose:(NSWindow *)sender
{
    NSInteger respuesta;
    
    respuesta = NSRunAlertPanel(@"Atencion",
                                @"¿Está seguro de que desea cerrar la ventana?.Esta accion finalizará la ejecución de la aplicación ",
                                @"No",
                                @"Si",
                                nil);
    
    if(respuesta == NSAlertDefaultReturn) {
        return NO;
    } else {
        [NSApp stopModal];
        return YES;
    }
    
}
#pragma clang diagnostic pop

- (void) windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

/* --------------------------- ACCIONES DE MODIFICACION ---------------------- */


-(void) handleModifyGraphic:(NSNotification *)aNotification
{
    NSLog(@"Notificacion %@ recibida en handleModifyGraphic\r", aNotification);
    NSDictionary *notificationInfoToModify = [aNotification userInfo];
    GraphicsClass *graphic = [notificationInfoToModify objectForKey:@"graphicToModify"];
        
    [newFunction setStringValue:[graphic function]];
    [newName setStringValue:[graphic funcName]];
    [newParamA setFloatValue:[graphic paramA]];
    [newParamB setFloatValue:[graphic paramB]];
    [newParamC setFloatValue:[graphic paramC]];
    [newParamN setFloatValue:[graphic paramN]];
    [newColour setColor:[graphic colour]];
    
    NSWindow *w = [self window];
    [NSApp runModalForWindow:w];
    
}


/* --------------------------- TRATMIENTO DE BOTONES DE MODIFICACION ---------------------- */


-(IBAction) confirmNewGraphic:(id)sender
{
    // OJOOOOO NO PERMITIR QUE EL USURIO MODIFIQUE EN PANEL PREFERENCIAS MIENTRAS ESTA ESTE ABIERTO PARA EVITAR QUE aRowSelected cambie
    GraphicsClass *newGraphic = [[GraphicsClass alloc] initWithGraphicName:[newName stringValue]
                                                               function:[newFunction stringValue]
                                                                 paramA:[newParamA floatValue]
                                                                 paramB:[newParamB floatValue]
                                                                 paramC:[newParamC floatValue]
                                                                 paramN:[newParamN floatValue]
                                                                 colour:[newColour color]];
    
    NSDictionary *notificationInfo = [NSDictionary dictionaryWithObject:newGraphic
                                                                 forKey:@"newGraphic"];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:PanelGraphicModifiedNotification
                      object:self
                    userInfo:notificationInfo];
    
    // Cierra el panel
    [NSApp stopModal];
    [self close];
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
-(IBAction) cancelNewGraphic:(id)sender
{
    NSInteger respuesta;
    respuesta = NSRunAlertPanel(@"Cambios realizados no guardados",
                                @"¿Está seguro de que desea cerrar la ventana?",
                                @"No. Guardar y cerrar panel",

                                @"Si. Cerrar panel",
                                nil);
    
    NSLog(@"NSAlertDefaultReturn %d", NSAlertDefaultReturn);
    
    if(respuesta == NSAlertDefaultReturn) { // No.Guardar y cerrar panel
        if (fieldsChanged) {
            [self confirmNewGraphic:sender];
        } else {
            [NSApp stopModal];
            [self close];
        }
    } else if (respuesta == NSAlertSecondButtonReturn) {// Si.Cerrar panel
         [NSApp stopModal];
         [self close];
     }
    
}
#pragma clang diagnostic pop

-(IBAction) controlTextDidChange:(NSNotification *)obj
{
    fieldsChanged = YES;
}



@end
