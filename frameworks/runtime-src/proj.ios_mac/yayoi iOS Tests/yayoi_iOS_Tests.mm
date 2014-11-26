#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#include "Piece.h"

using namespace yayoi;

@interface yayoi_iOS_Tests : XCTestCase

@end

@implementation yayoi_iOS_Tests {
    Piece *_p;
}

- (void)setUp {
    [super setUp];
    _p = new Piece(Piece::FIGHTER, Piece::SUN, {{Piece::POWER, 40}, {Piece::ARMOR, 40}, {Piece::RESIST, 40}}, {{Piece::POWER, 30}, {Piece::ARMOR, 30}, {Piece::RESIST, 30}});
}

- (void)tearDown {
    delete _p;
    [super tearDown];
}

- (void)testGetStatus {
    XCTAssertEqual(100, _p->getStatus(Piece::POWER));
}

@end
