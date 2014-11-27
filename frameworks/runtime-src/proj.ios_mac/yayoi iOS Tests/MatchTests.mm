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

- (void)testApplyChip_loop { // 使ったチップはデッキの最後尾に戻る
    _match->fillDeck(RED, {{Chip(0, 1), 1}, {Chip(2, 3), 1}});
    auto headChip = _match->getDeck(RED).front();
    auto p = Piece();
    _match->applyChip(RED, 0, &p);
    auto deck = _match->getDeck(RED);
    XCTAssertEqual(2, deck.size());
    XCTAssertNotEqual(headChip.getDir().first, deck.front().getDir().first);
    XCTAssertNotEqual(headChip.getDir().second, deck.front().getDir().second);
}

Piece* createPiece() {
    return new Piece(Piece::FIGHTER, Piece::SUN, {{Piece::POWER, 40}, {Piece::ARMOR, 40}, {Piece::RESIST, 40}}, {{Piece::POWER, 30}, {Piece::ARMOR, 30}, {Piece::RESIST, 30}}, RED, 0, 0);
}

- (void)testApplyChip_gain {
    auto p = createPiece();
    delete _match;
    _match = new Match(0, {p}, 5, 5, {{Chip(0, 1), 1}});
    _match->applyChip(RED, 0, p);
    XCTAssertEqual(0, p->getPosition().first);
    XCTAssertEqual(1, p->getPosition().second);
}

- (void)testApplyChip_wall { // 壁に進もうとすると失敗する
    auto p = createPiece();
    delete _match;
    _match = new Match(0, {p}, 5, 5, {{Chip(0, -1), 1}});
    _match->applyChip(RED, 0, p);
    XCTAssertEqual(0, p->getPosition().first);
    XCTAssertEqual(0, p->getPosition().second);
}

- (void)testApplyChip_dead { // 死んでると失敗する
    auto p = createPiece();
    p->applyDamage(100);
    delete _match;
    _match = new Match(0, {p}, 5, 5, {{Chip(0, 1), 1}});
    _match->applyChip(RED, 0, p);
    XCTAssertEqual(0, p->getPosition().first);
    XCTAssertEqual(0, p->getPosition().second);
}

- (void)testApplyChip_punch {
    auto from = createPiece();
    auto to = createPiece();
    to->applyChip({0, 1});
    delete _match;
    _match = new Match(0, {from, to}, 5, 5, {{Chip(0, 1), 1}});
    _match->applyChip(RED, 0, from);
    XCTAssertEqual(0, from->getPosition().first);
    XCTAssertEqual(0, from->getPosition().second);
    XCTAssertNotEqual(Piece::MAX_HP, to->getHp());
}

@end
