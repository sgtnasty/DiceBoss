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
@synthesize tableView;

@synthesize statsPanel;
@synthesize total;
@synthesize count;
@synthesize minimum;
@synthesize maximum;
@synthesize median;
@synthesize average;
@synthesize minLabel;
@synthesize medLabel;
@synthesize avgLabel;
@synthesize maxLabel;
@synthesize countLabel;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [self resetStats];
    self.throwsArray = [[NSMutableArray alloc] init];
}

-(void)resetStats
{
    self.total = [NSNumber numberWithInt:0];
    self.count = [NSNumber numberWithInt:0];
    self.minimum = [NSNumber numberWithInt:INT_MAX];
    self.maximum = [NSNumber numberWithInt:INT_MIN];
    self.median = [NSNumber numberWithInt:0];
    self.average = [NSNumber numberWithInt:0];
}

-(void)computeStats
{
    if ([self.throwsArray count] > 0)
    {
        NSEnumerator *enumer = [throwsArray objectEnumerator];
        NSMutableArray *numbers = [[NSMutableArray alloc] 
                                   initWithCapacity:[throwsArray count]];
        id throw;
        while (throw = [enumer nextObject])
        {
            NSNumber *number = [[NSNumber alloc] initWithInt:[[throw objectForKey:@"result"] intValue]];
            [numbers addObject:number];
        }
        
        NSArray *sorted = [numbers sortedArrayUsingSelector:@selector(compare:)];
        NSUInteger middle = [sorted count] / 2;
        self.median = [sorted objectAtIndex:middle];
        int t = [self.total intValue];
        int c = [self.count intValue];
        double a = ((double)t) / ((double)c);
        NSLog(@"%d/%d = %f", t, c, a);
        self.average = [NSNumber numberWithDouble:a];
    }
    
    if ([self.statsPanel isVisible])
    {
        [self.minLabel setIntValue:[self.minimum intValue]];
        [self.medLabel setIntValue:[self.median intValue]];
        [self.avgLabel setDoubleValue:[self.average doubleValue]];
        [self.maxLabel setIntValue:[self.maximum intValue]];
        [self.countLabel setIntValue:[self.count intValue]];
    }
}

-(BOOL) applicationShouldTerminateAfterLastWindowClosed:(NSApplication *) theApplication
{
    return YES; 
}

-(int)roll:(int)dieCount forD:(int)die
{
    int rolls = 0;
    for (int i=0; i<dieCount; i++)
    {
        double roll = 1.0 + arc4random_uniform(die);
        NSLog(@"roll d%d=%f", die, roll);
        rolls += (int)floor(roll);
    }
    if (rolls < [self.minimum intValue]) self.minimum = [NSNumber numberWithInt:rolls];
    if (rolls > [self.maximum intValue]) self.maximum = [NSNumber numberWithInt:rolls];
    self.total = [NSNumber numberWithInt:rolls + [self.total intValue]];
    self.count = [NSNumber numberWithInt:1 + [self.count intValue]];
    return rolls;
}

-(void)addResult:(int)result forNum:(int)dieCount forDie:(int)dn
{
    NSDictionary *throw = [NSDictionary dictionaryWithObjectsAndKeys:
                           [NSString stringWithFormat:@"%dd%d", dieCount, dn], @"throw",
                           [NSString stringWithFormat:@"%d", result], @"result",
                           [NSString stringWithFormat:@"%d", [self.total intValue]], @"total",
                           nil];
    [throwsController addObject:throw];
    [tableView scrollRowToVisible:[throwsArray count]-1];
    [self computeStats];
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

-(IBAction)roll2d10:(id)sender
{
    [self addResult:[self roll:2 forD:10] forNum:2 forDie:10];
}

-(IBAction)roll3d6:(id)sender
{
    [self addResult:[self roll:3 forD:6] forNum:3 forDie:6];
}

-(IBAction)clearItems:(id)sender
{
    [self resetStats];
    self.total = 0;
    [throwsController removeObjects:throwsArray];
    [self computeStats];
}

-(IBAction)viewStats:(id)sender
{
    [self.statsPanel makeKeyAndOrderFront:self];
    [self computeStats];
}

@end
