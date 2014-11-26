#include "Piece.h"

using namespace std;

namespace yayoi {

    Piece::Piece()
    :_job(FIGHTER)
    ,_color(SUN)
    ,_baseStatus({{POWER, 0}, {ARMOR, 0}, {RESIST, 0}})
    ,_individualStatus({{POWER, 0}, {ARMOR, 0}, {RESIST, 0}}){
    }

    Piece::Piece(Job job, Color color, const map<Param, int> &baseStatus, const map<Param, int> &individualStatus) {
        _job = job;
        _color = color;
        _baseStatus = baseStatus;
        _individualStatus = individualStatus;
    }

    Piece::~Piece() {
    }

    int Piece::getStatus(Param param) const {
        return _baseStatus.at(param) + _individualStatus.at(param) * 2;
    }

}
