//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Genady Okrain on 1/31/13.
//  Copyright (c) 2013 Genady Okrain. All rights reserved.
//

#import "Deck.h"

@interface CardMatchingGame : NSObject

// designated initializer
- (id)initWithCardCount:(NSUInteger)cardCount
              usingDeck:(Deck *)deck;

- (void)flipCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) int score;

@end
