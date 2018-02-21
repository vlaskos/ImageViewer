//
//  VKDetailsScreen.m
//  VKImageViewver
//
//  Created by vlad.kosyi on 2/18/18.
//  Copyright © 2018 vlad.kosyi. All rights reserved.
//

#import "VKDetailsScreen.h"
#import "NSImage+VKImage_Additionals.h"

@interface VKDetailsScreen ()

@property (weak) IBOutlet NSButton *blurButton;
@property (weak) IBOutlet NSImageView *mainImageView;
@property (strong, nonatomic) NSArray* images;
@property (assign, nonatomic) NSInteger index;
@property (assign, nonatomic) NSInteger blurredIndex;

@end

@implementation VKDetailsScreen

// MARK: - LifeCycle
//------------------------------------------------------------------------------------------------------------------------------------

- (void)viewDidLoad {
    [super viewDidLoad];

    // added NSEventMaskKeyDown listener
    [NSEvent addLocalMonitorForEventsMatchingMask:NSEventMaskKeyDown handler:^NSEvent * _Nullable(NSEvent * event) {
        [self keyDown: event];
        return event;
    }];
}

// MARK: - Methods
//------------------------------------------------------------------------------------------------------------------------------------

- (void) setData:(NSArray*) data withIndex:(NSInteger) index {
    
    if (self.images == nil) {
        self.images = [NSArray arrayWithArray:data];
    }
    
    self.index = index;
    
     [self setImage: self.images[self.index]];
}

- (void) setImage:(NSImage*) image {
    
    self.mainImageView.image = image;
}

- (void) previousImage {
    if (self.index > 0) {
        self.index = self.index - 1;
        [self setImage: self.images[self.index]];
    }
    [self changeBlurButtonTitle:@"Blur"];
}

- (void) nextImage {
    if (self.index < self.images.count - 1) {
        self.index = self.index + 1;
        [self setImage: self.images[self.index]];
    }
    [self changeBlurButtonTitle:@"Blur"];
}

- (void) changeBlurButtonTitle:(NSString*) title {
    if (self.index != self.blurredIndex) {
        [self.blurButton setTitle:title];
    }
}

// MARK: - KeyDown Events
//------------------------------------------------------------------------------------------------------------------------------------

-(void)keyDown:(NSEvent*) event {
    
    switch (event.keyCode) {
        case 126: // up key
            [self previousImage];
            break;
        case 125: // down key
            [self nextImage];
            break;
        case 53: // down key
            [self dismissController:self];
            break;
        default:
            break;
    }
}

// MARK: - Actions
//------------------------------------------------------------------------------------------------------------------------------------

- (IBAction)previoudAction:(id)sender {
    [self previousImage];
}

- (IBAction)nextAction:(id)sender {
    [self nextImage];
}

- (IBAction)blurButtonAction:(NSButton*)sender {
    
    // needs to improve
    if (![sender.title isEqualToString:@"Blurred"]) {
        [sender setTitle:@"Blurred"];
        self.blurredIndex = self.index;
        NSImage *sourceImage = self.mainImageView.image;
        self.mainImageView.image = [NSImage blurredImageWithImage:sourceImage];
    }
}

@end
