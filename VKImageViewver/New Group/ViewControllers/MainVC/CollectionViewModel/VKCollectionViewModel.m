//
//  VKCollectionViewModel.m
//  VKImageViewver
//
//  Created by vlad.kosyi on 2/19/18.
//  Copyright © 2018 vlad.kosyi. All rights reserved.
//

#import "VKCollectionViewModel.h"
#import "VKMainCollectionViewItem.h"

@interface VKCollectionViewModel ()

@property (strong, nonatomic) NSCollectionView *collectionView;

@end

@implementation VKCollectionViewModel

- (instancetype)initWithData:(NSMutableArray*) data collectionView:(NSCollectionView*) collection {
    self = [super init];
    if (self) {
        
        if (self.items == nil) {
            self.items = [NSMutableArray arrayWithArray:data];
        }
        // to do fix it
        self.collectionView = collection;
        
        NSArray *supportedTypes = [NSArray arrayWithObjects:@"com.vlaskos.VKImageViewver.item", NSFilenamesPboardType, nil];
        [self.collectionView registerForDraggedTypes:supportedTypes];
        [self.collectionView setDraggingSourceOperationMask:NSDragOperationCopy forLocal:NO];
    }
    return self;
}

// MARK: - NSCollectionViewDataSource
//------------------------------------------------------------------------------------------------------------------------------------

- (NSInteger)numberOfSectionsInCollectionView:(NSCollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(NSCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

- (NSCollectionViewItem *)collectionView:(NSCollectionView *)collectionView itemForRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath {
    
    VKMainCollectionViewItem *item = [collectionView makeItemWithIdentifier:@"VKMainCollectionViewItem" forIndexPath:indexPath];
    [item configureItemWithImage:self.items[indexPath.item]];
    
    return item;
}

// MARK: - NSCollectionViewDelegate
//------------------------------------------------------------------------------------------------------------------------------------

- (void)collectionView:(NSCollectionView *)collectionView didSelectItemsAtIndexPaths:(NSSet<NSIndexPath *> *)indexPaths {
    
    if ([(NSObject*) self.delegate respondsToSelector:@selector(didSelectItemWithIndex:)]) {
        [self.delegate didSelectItemWithIndex:indexPaths.allObjects[0].item];
    }
}

#warning TODO double click action

//- (void)doubleClickItem:(NSCollectionViewItem *)item {
//    NSIndexPath *indexPath = [self.collectionView indexPathForItem:item];
//
//    if ([(NSObject*) self.delegate respondsToSelector:@selector(didSelectItemWithIndex:)]) {
////        [self.delegate didSelectItemWithIndex:indexPath.item];
//    }
//}


- (NSDragOperation)collectionView:(NSCollectionView *)collectionView validateDrop:(id <NSDraggingInfo>)draggingInfo proposedIndexPath:(NSIndexPath * __nonnull * __nonnull)proposedDropIndexPath dropOperation:(NSCollectionViewDropOperation *)proposedDropOperation {
    
    if (!draggingInfo.draggingSource) {
        
        return NSDragOperationCopy;
    }

    return NSDragOperationNone;
}

-(BOOL)collectionView:(NSCollectionView *)collectionView acceptDrop:(id<NSDraggingInfo>)draggingInfo indexPath:(NSIndexPath *)indexPath dropOperation:(NSCollectionViewDropOperation)dropOperation {
    
    NSPasteboard *pasteboard = [draggingInfo draggingPasteboard];
    
    for (NSPasteboardItem *oneItem in [pasteboard pasteboardItems]) {
        
        NSString *urlString = [oneItem stringForType:(id)kUTTypeFileURL];
        NSURL *URL = [NSURL URLWithString:urlString];
        
        if (URL) {
            
            NSImage* image = [[NSImage alloc] initWithContentsOfURL:URL];
            if(!image) { return NO; }
            [self.items addObject:image];
            [self.collectionView reloadData];
        }
    }

    return YES;
}

@end
