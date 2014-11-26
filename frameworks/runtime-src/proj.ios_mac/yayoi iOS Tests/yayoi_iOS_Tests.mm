#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#include "Piece.h"

using namespace yayoi;

@interface yayoi_iOS_Tests : XCTestCase

@end

@implementation yayoi_iOS_Tests {
    Piece *_piece;
}

- (void)setUp {
    [super setUp];
    _piece = new Piece();
}

- (void)tearDown {
    delete _piece;
    [super tearDown];
}

- (void)testGetPieceID {
    XCTAssertEqual(0, _piece->getPieceID());
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
