//
//  PanelModificationController.h
//  iMaths
//
//  Created by Luis Blazquez Miñambres on 13/10/18.
//  Copyright © 2018 Luis Blazquez Miñambres. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class GraphicsClass;
@class PanelModel;

#define NUM_PARAMETERS 10
#define NUM_DEFAULT_FUNCTIONS 6

@interface PanelModificationController : NSWindowController <NSWindowDelegate,
                                                             NSTextFieldDelegate,
                                                             NSControlTextEditingDelegate,
                                                             NSComboBoxDelegate,
                                                             NSComboBoxDataSource>
{
    /* Punteros o referencias a otras clases */
    
    PanelModel *modelInPanel;
    
    /* Outlets */
    
    IBOutlet NSComboBox *newFunction;
    IBOutlet NSTextField *newName;
    IBOutlet NSTextField *newParamA;
    IBOutlet NSTextField *newParamB;
    IBOutlet NSTextField *newParamC;
    IBOutlet NSTextField *newParamN;
    IBOutlet NSColorWell *newColour;
    IBOutlet NSButton *confirmChanges;
    IBOutlet NSButton *cancelChanges;
    
    /* Variables de instancia */
    
    bool fieldsChanged, BisEnabled, CisEnabled, NisEnabled;
    NSInteger pos;
}


-(void)handleModifyGraphic:(NSNotification *)aNotification;

-(IBAction)confirmNewGraphic:(id)sender;
-(IBAction)cancelNewGraphic:(id)sender;
-(void) fomatterOnlyRealNumbers;

@end
