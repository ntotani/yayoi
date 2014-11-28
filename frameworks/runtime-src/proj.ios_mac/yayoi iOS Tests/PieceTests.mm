#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#include "Piece.h"

using namespace yayoi;

@interface PieceTests : XCTestCase

@end

@implementation PieceTests {
    Piece *_p;
}

- (void)setUp {
    [super setUp];
    _p = new Piece(Piece::FIGHTER, Piece::SUN, {{Piece::POWER, 40}, {Piece::ARMOR, 40}, {Piece::RESIST, 40}}, {{Piece::POWER, 30}, {Piece::ARMOR, 30}, {Piece::RESIST, 30}}, RED, 0, 0, false);
}

- (void)tearDown {
    delete _p;
    [super tearDown];
}

- (void)testGetStatus {
    XCTAssertEqual(100, _p->getStatus(Piece::POWER));
}

- (void)testApplyDamage_alive {
    XCTAssertEqual(10, _p->applyDamage(10));
    XCTAssertEqual(90, _p->getHp());
}

- (void)testApplyDamage_dead {
    XCTAssertEqual(100, _p->applyDamage(1000));
    XCTAssertEqual(0, _p->getHp());
}

@end
