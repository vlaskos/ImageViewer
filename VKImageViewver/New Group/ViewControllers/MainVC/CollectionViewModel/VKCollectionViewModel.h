//
//  VKCollectionViewModel.h
//  VKImageViewver
//
//  Created by vlad.kosyi on 2/19/18.
//  Copyright © 2018 vlad.kosyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@protocol VKCollectionViewModelDelegate;

@interface VKCollectionViewModel : NSObject <NSCollectionViewDataSource, NSCollectionViewDelegate>

@property (nonatomic, weak) id <VKCollectionViewModelDelegate> delegate;
@property (strong, nonatomic) NSMutableArray *items;

- (instancetype)initWithData:(NSMutableArray*) data collectionView:(NSCollectionView*) collection;

@end

@protocol VKCollectionViewModelDelegate

- (void) didSelectItemWithIndex:(NSInteger) index;

@end
