//
//  DBAppDelegate.m
//  DiceBoss
//
//  Created by Ronaldo Nascimento on 11/16/11.
//  Copyright (c) 2011 Ronaldo Nascimento. All rights reserved.
// This file is part of DiceBoss.
// 
// DiceBoss is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// DiceBoss is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
// 
// You should have received a copy of the GNU General Public License
// along with DiceBoss.  If not, see <http://www.gnu.org/licenses/>.
//

#import "DBAppDelegate.h"

@implementation DBAppDelegate

@synthesize window = _window;
@synthesize throwsArray;
@synthesize throwsController;
@synthesize total;
@synthesize tableView;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    throwsArray = [[NSMutableArray alloc] init];
    total = 0;
}

-(BOOL) applicationShouldTerminateAfterLastWindowClosed:(NSApplication *) theApplication
{
    return YES; 
}

-(int)roll:(int)count forD:(int)die
{
    int rolls = 0;
    for (int i=0; i<count; i++)
    {
        double roll = 1.0 + arc4random_uniform(die);
        NSLog(@"roll d%d=%f", die, roll);
        rolls += (int)floor(roll);
    }
    total += rolls;
    return rolls;
}

-(void)addResult:(int)result forNum:(int)count forDie:(int)dn
{
    NSDictionary *throw = [NSDictionary dictionaryWithObjectsAndKeys:
                           [NSString stringWithFormat:@"%dd%d", count, dn], @"throw",
                           [NSString stringWithFormat:@"%d", result], @"result",
                           [NSString stringWithFormat:@"%d", total], @"total",
                           nil];
    [throwsController addObject:throw];
    //[tableView reloadData];
    [tableView scrollRowToVisible:[throwsArray count]-1];
}

-(IBAction)rolld20:(id)sender
{
    [self addResult:[self roll:1 forD:20] forNum:1 forDie:20];
}

-(IBAction)rolld12:(id)sender
{
    [self addResult:[self roll:1 forD:12] forNum:1 forDie:12];
}

-(IBAction)rolld10:(id)sender
{
    [self addResult:[self roll:1 forD:10] forNum:1 forDie:10];
}

-(IBAction)rolld8:(id)sender
{
    [self addResult:[self roll:1 forD:8] forNum:1 forDie:8];
}

-(IBAction)rolld6:(id)sender
{
    [self addResult:[self roll:1 forD:6] forNum:1 forDie:6];
}

-(IBAction)rolld4:(id)sender
{
    [self addResult:[self roll:1 forD:4] forNum:1 forDie:4];
}

-(IBAction)rolld100:(id)sender
{
    [self addResult:[self roll:1 forD:100] forNum:1 forDie:100];
}

-(IBAction)roll2d6:(id)sender
{
    [self addResult:[self roll:2 forD:6] forNum:2 forDie:6];
}

-(IBAction)roll3d6:(id)sender
{
    [self addResult:[self roll:3 forD:6] forNum:3 forDie:6];
}

-(IBAction)clearItems:(id)sender
{
    self.total = 0;
    [throwsController removeObjects:throwsArray];
}

@end
