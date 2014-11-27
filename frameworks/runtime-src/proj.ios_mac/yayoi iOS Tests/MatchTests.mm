#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#include "Match.h"

using namespace std;
using namespace yayoi;

@interface MatchTests : XCTestCase

@end

@implementation MatchTests {
    Match *_match;
}

- (void)setUp {
    [super setUp];
    _match = new Match();
}

- (void)tearDown {
    delete _match;
    [super tearDown];
}

- (void)testFillDeck_one {
    map<Chip, int> freq = {{Chip(2, 1), 1}};
    _match->fillDeck(RED, freq);
    auto deck = _match->getDeck(RED);
    XCTAssertEqual(1, deck.size());
    XCTAssertEqual(2, deck.front().getDir().first);
    XCTAssertEqual(1, deck.front().getDir().second);
}

- (void)testFillDeck_many {
    _match->fillDeck(RED, {{Chip(0, 1), 1}, {Chip(2, 3), 99}});
    auto deck = _match->getDeck(RED);
    XCTAssertEqual(100, deck.size());
    XCTAssertEqual(2, deck.front().getDir().first);
    XCTAssertEqual(3, deck.front().getDir().second);
}

@end
