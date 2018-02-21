//
//  VKMainScreen.m
//  VKImageViewver
//
//  Created by vlad.kosyi on 2/18/18.
//  Copyright © 2018 vlad.kosyi. All rights reserved.
//

#import "VKMainScreen.h"
#import "VKCollectionViewModel.h"
#import "VKDetailsScreen.h"
#import "VKMainCollectionViewItem.h"

@interface VKMainScreen () <VKCollectionViewModelDelegate>
    
@property (weak) IBOutlet NSCollectionView *collectionView;
@property (strong, nonatomic) NSCollectionViewFlowLayout *flowLayout;
@property (strong, nonatomic) VKCollectionViewModel *model;
@property (strong, nonatomic) NSMutableArray *items;

@end

@implementation VKMainScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureCollectionView];

}

- (void) configureCollectionView {
    
    self.flowLayout = [NSCollectionViewFlowLayout new];
    self.flowLayout.itemSize = NSMakeSize(320, 280.0);
    self.flowLayout.sectionInset = NSEdgeInsetsMake(10.0, 20.0, 10.0, 20.0);
    self.flowLayout.minimumInteritemSpacing = 20.0;
    self.flowLayout.minimumLineSpacing = 20.0;
    self.flowLayout.scrollDirection = NSCollectionViewScrollDirectionVertical;
    self.collectionView.collectionViewLayout = self.flowLayout;
    self.collectionView.layer.backgroundColor = [NSColor greenColor].CGColor;
    self.view.wantsLayer = YES;

    self.collectionView.layer.backgroundColor = [NSColor blackColor].CGColor;
    
    NSNib *nib = [[NSNib alloc] initWithNibNamed:@"VKMainCollectionViewItem" bundle:nil];
    [self.collectionView registerNib:nib forItemWithIdentifier:@"VKMainCollectionViewItem"];
    
    [self.collectionView reloadData];
    
    self.model = [[VKCollectionViewModel alloc] initWithData:self.items collectionView:self.collectionView];
    self.model.delegate = self;
    self.collectionView.delegate = self.model;
    self.collectionView.dataSource = self.model;

}

// MARK: - Getters
//------------------------------------------------------------------------------------------------------------------------------------

#warning TODO need to implement normal storing
// Needs to implement storage container for images

- (NSMutableArray *)items {
    if (_items == nil) {
        _items = [NSMutableArray new];
        for (int i = 1; i <= 5; i++) {
            NSString * imgName = [NSString stringWithFormat:@"%i", i];
            [_items addObject:[NSImage imageNamed:imgName]];
        }
        return _items;
    } else {
        return _items;
    }
}


// MARK: - VKCollectionViewModelDelegate
//------------------------------------------------------------------------------------------------------------------------------------

- (void)didSelectItemWithIndex:(NSInteger)index {
    
    NSStoryboard *sb = [NSStoryboard storyboardWithName:@"Main" bundle:nil];
    VKDetailsScreen *vc = [sb instantiateControllerWithIdentifier:@"VKDetailsScreen"];
    [self presentViewControllerAsModalWindow:vc];
    [vc setData:self.model.items withIndex:index];
}

@end
