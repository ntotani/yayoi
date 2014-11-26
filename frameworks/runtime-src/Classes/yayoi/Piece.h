#ifndef __yayoi__Piece__
#define __yayoi__Piece__

#include <stdio.h>

namespace yayoi {

    class Piece {
    public:
        Piece();
        int getPieceID();
    private:
        int _pieceID;
    };

}

#endif /* defined(__yayoi__Piece__) */
