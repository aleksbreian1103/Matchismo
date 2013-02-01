//
//  PlayingCard.m
//  Matchismo
//
//  Created by Genady Okrain on 1/25/13.
//  Copyright (c) 2013 Genady Okrain. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    // copy otherCards to local array
    NSArray *cards = [[NSArray alloc] initWithArray:otherCards];
    for (int i = 0; i < [cards count]; i++) {
        for (int j = i+1; j < [cards count]; j++) {
            // Select cards
            PlayingCard *card1 = cards[i];
            PlayingCard *card2 = cards[j];
            
            // check for the same suit
            if ([card1.suit isEqualToString:card2.suit]) {
                score += 1;
            }
            // check for the same rank
            if (card1.rank == card2.rank) {
                score += 4;
            }
        }
    }
    
    // check self
    for (PlayingCard *otherCard in otherCards) {
        // check for the same suit
        if ([self.suit isEqualToString:otherCard.suit]) {
            score += 1;
        }
        // check for the same rank
        if (self.rank == otherCard.rank) {
            score += 4;
        }
    }

    return score;
}

- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit; // because we provide setter AND getter

+ (NSArray *)validSuits
{
    return @[@"♠",@"♣",@"♥",@"♦"];
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}


+ (NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank { return [self rankStrings].count-1;}

- (void) setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end
