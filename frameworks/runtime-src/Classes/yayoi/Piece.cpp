#include "Piece.h"

using namespace std;

namespace yayoi {

    Piece::Piece()
    :_job(FIGHTER)
    ,_color(SUN)
    ,_baseStatus({{POWER, 0}, {ARMOR, 0}, {RESIST, 0}})
    ,_individualStatus({{POWER, 0}, {ARMOR, 0}, {RESIST, 0}})
    ,_hp(MAX_HP) {
    }

    Piece::Piece(Job job, Color color, const map<Param, int> &baseStatus, const map<Param, int> &individualStatus):_hp(MAX_HP) {
        _job = job;
        _color = color;
        _baseStatus = baseStatus;
        _individualStatus = individualStatus;
    }

    Piece::~Piece() {
    }

    int Piece::applyDamage(int damage) {
        damage = min(damage, _hp);
        _hp -= damage;
        return damage;
    }

}
