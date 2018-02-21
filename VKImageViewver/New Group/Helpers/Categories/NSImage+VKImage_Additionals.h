//
//  NSImage+VKImage_Additionals.h
//  VKImageViewver
//
//  Created by vlad.kosyi on 2/21/18.
//  Copyright © 2018 vlad.kosyi. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSImage (VKImage_Additionals)

+ (NSImage *)blurredImageWithImage:(NSImage *)sourceImage;

@end
