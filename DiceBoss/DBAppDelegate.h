//
//  DBAppDelegate.h
//  DiceBoss
//
//  Created by Ronaldo Nascimento on 11/16/11.
//  Copyright (c) 2011 Ronaldo Nascimento. All rights reserved.
//
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
//

#import <Cocoa/Cocoa.h>

@interface DBAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSArrayController *throwsController;
@property (copy) NSMutableArray *throwsArray;
@property (copy) NSNumber *total;
@property (copy) NSNumber *count;
@property (copy) NSNumber *minimum;
@property (copy) NSNumber *maximum;
@property (copy) NSNumber *median;
@property (copy) NSNumber *average;
@property (assign) IBOutlet NSTableView *tableView;
@property (assign) IBOutlet NSPanel *statsPanel;

// stats panel
@property (assign) IBOutlet NSTextField *minLabel;
@property (assign) IBOutlet NSTextField *medLabel;
@property (assign) IBOutlet NSTextField *avgLabel;
@property (assign) IBOutlet NSTextField *maxLabel;
@property (assign) IBOutlet NSTextField *countLabel;

-(int)roll:(int)count forD:(int)die;
-(void)addResult:(int)result forNum:(int)count forDie:(int)dn;
-(IBAction)rolld20:(id)sender;
-(IBAction)rolld12:(id)sender;
-(IBAction)rolld10:(id)sender;
-(IBAction)rolld8:(id)sender;
-(IBAction)rolld6:(id)sender;
-(IBAction)rolld4:(id)sender;
-(IBAction)rolld100:(id)sender;

-(IBAction)roll2d6:(id)sender;
-(IBAction)roll2d10:(id)sender;
-(IBAction)roll3d6:(id)sender;
-(IBAction)clearItems:(id)sender;
-(IBAction)viewStats:(id)sender;
-(void)resetStats;
-(void)computeStats;

@end
