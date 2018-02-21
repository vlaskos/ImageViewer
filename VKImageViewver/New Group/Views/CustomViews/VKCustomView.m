//
//  VKCustomView.m
//  VKImageViewver
//
//  Created by vlad.kosyi on 2/19/18.
//  Copyright © 2018 vlad.kosyi. All rights reserved.
//

#import "VKCustomView.h"

@implementation VKCustomView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    NSRect drawRect = NSInsetRect(self.bounds, 5, 5);
    
    if (self.selected)
    {
        [[NSColor blueColor] set];
        [NSBezierPath strokeRect:drawRect];
    }
    
}

// MARK: - Accessors
//------------------------------------------------------------------------------------------------------------------------------------

- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    [self setNeedsDisplay:YES];
}

@end
