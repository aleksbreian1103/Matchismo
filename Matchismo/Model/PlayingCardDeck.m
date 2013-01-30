//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by Genady Okrain on 1/25/13.
//  Copyright (c) 2013 Genady Okrain. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

- (id)init
{
    self = [super init];
    
    if (self) {
        for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
            for (NSString *suit in [PlayingCard validSuits]) {
                PlayingCard *card = [[PlayingCard alloc] init];
                card.rank = rank;
                card.suit = suit;
                [self addCard:card atTop:YES];
            }
        }
        
    }
    
    return self;
}

@end
