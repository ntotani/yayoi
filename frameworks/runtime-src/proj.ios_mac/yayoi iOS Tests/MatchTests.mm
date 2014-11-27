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

- (void)testFillDeck {
    map<Chip, int> freq = {{Chip(2, 1), 1}};
    _match->fillDeck(RED, freq);
    auto deck = _match->getDeck(RED);
    XCTAssertEqual(1, deck.size());
    XCTAssertEqual(2, deck.front().getDir().first);
    XCTAssertEqual(1, deck.front().getDir().second);
}

@end
