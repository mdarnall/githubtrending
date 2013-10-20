//
// Created by Matt Darnall on 10/19/13.
// Copyright (c) 2013 Matt Darnall. All rights reserved.
//


#import "TrendingRepositories.h"

NSString *TrendingRepositoriesItemsChanged = @"TrendingRepositoriesItemsChanged";

@implementation TrendingRepositories

- (void)setItems:(NSArray *)items {
    _items = items;
    [[NSNotificationCenter defaultCenter] postNotificationName:TrendingRepositoriesItemsChanged object:self];
}

@end