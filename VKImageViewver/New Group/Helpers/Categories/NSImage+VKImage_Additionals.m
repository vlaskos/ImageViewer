//
//  NSImage+VKImage_Additionals.m
//  VKImageViewver
//
//  Created by vlad.kosyi on 2/21/18.
//  Copyright © 2018 vlad.kosyi. All rights reserved.
//

#import "NSImage+VKImage_Additionals.h"
#import <CoreImage/CoreImage.h>

@implementation NSImage (VKImage_Additionals)

+ (NSImage *)blurredImageWithImage:(NSImage *)sourceImage{
    
    CIImage* inputImage = [CIImage imageWithData:[sourceImage
                                                  TIFFRepresentation]];
    CIFilter* filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setDefaults];
    [filter setValue:inputImage forKey:@"inputImage"];
    CIImage* outputImage = [filter valueForKey:@"outputImage"];
    
    NSRect outputImageRect = NSRectFromCGRect([outputImage extent]);
    NSImage* blurredImage = [[NSImage alloc]
                             initWithSize:outputImageRect.size];
    [blurredImage lockFocus];
    [outputImage drawAtPoint:NSZeroPoint fromRect:outputImageRect
                   operation:NSCompositingOperationCopy fraction:1.0];
    [blurredImage unlockFocus];

    return blurredImage;
}

@end
