//
//  PanelModel.h
//  iMaths
//
//  Created by Luis Blazquez Miñambres on 12/10/18.
//  Copyright © 2018 Luis Blazquez Miñambres. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PanelModel : NSObject
{
    NSMutableArray *arrayListFunctions; // Array que contendra una serie de objetos de tipo Funcion
}

/* Getters y setters */

@property (nonatomic) NSMutableArray *arrayListFunctions;

@end
