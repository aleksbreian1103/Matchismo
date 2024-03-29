//
//  Card.m
//  Matchismo
//
//  Created by Genady Okrain on 1/25/13.
//  Copyright (c) 2013 Genady Okrain. All rights reserved.
//

#import "Card.h"

@interface Card()

@end

@implementation Card

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    
    return score;
}

- (NSString *)description {
    return self.contents;
}

@end
