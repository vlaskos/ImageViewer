//
//  VKMainCollectionViewItem.m
//  VKImageViewver
//
//  Created by vlad.kosyi on 2/18/18.
//  Copyright © 2018 vlad.kosyi. All rights reserved.
//

#import "VKMainCollectionViewItem.h"
#import "VKCustomView.h"

@interface VKMainCollectionViewItem ()

@property (weak) IBOutlet NSImageView *customImageView;

@end

@implementation VKMainCollectionViewItem

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.wantsLayer = YES;
    
}

- (void) configureItemWithImage:(NSImage*) image {
    self.customImageView.image = image;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];

    [(VKCustomView *)self.view setSelected:selected];
}

@end
