//
//  VKDetailsScreen.h
//  VKImageViewver
//
//  Created by vlad.kosyi on 2/18/18.
//  Copyright © 2018 vlad.kosyi. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface VKDetailsScreen : NSViewController

- (void) setImage:(NSImage*) image;
- (void) setData:(NSArray*) data withIndex:(NSInteger) index;

@end
