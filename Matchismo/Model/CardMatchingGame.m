//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Genady Okrain on 1/31/13.
//  Copyright (c) 2013 Genady Okrain. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic) int score;
@property (strong, nonatomic) NSString *lastResult;
@property (nonatomic) NSUInteger matchMode;
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck selectedMatchMode:(NSUInteger)mode
{
    self = [super init];
    
    if (self) {        
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (!card) {
                self = nil;
            } else {
                self.cards[i] = card;
            }
        }
        
        if (mode > count) {
            self = nil;
        } else {
            self.matchMode = mode;
        }
    }

    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

#define FLIP_COST 1
#define MISMATCH_PENALTY 2
#define MATCH_BONUS 4

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            self.score -= FLIP_COST;
            
            // create array with all other face up cards
            NSMutableArray *faceUpCards = [[NSMutableArray alloc] init];
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    [faceUpCards addObject:otherCard];
                }
            }
            
            if ([faceUpCards count] < self.matchMode-1) {
                self.lastResult = [NSString stringWithFormat:@"Flipped up %@", card.contents];
            } else {
                int matchScore = [card match:faceUpCards];
                
                if (matchScore) {
                    for (Card *otherCard in faceUpCards) {
                        otherCard.unplayable = YES;
                    }
                    card.unplayable = YES;
                    self.score += matchScore * MATCH_BONUS;
                    self.lastResult = [NSString stringWithFormat:@"Matched %@ & %@ for %d points", card.contents, [faceUpCards componentsJoinedByString:@" & "], matchScore * MATCH_BONUS];
                } else {
                    for (Card *otherCard in faceUpCards) {
                        otherCard.faceUp = NO;
                    }
                    self.score -= MISMATCH_PENALTY;
                    self.lastResult = [NSString stringWithFormat:@"%@ & %@ don’t match! %d point penalty!", card.contents, [faceUpCards componentsJoinedByString:@" & "], MISMATCH_PENALTY];
                }
            }
        }
        card.faceUp = !card.isFaceUp;
    }
}

@end
