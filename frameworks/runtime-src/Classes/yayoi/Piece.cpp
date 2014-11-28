#include "Piece.h"

using namespace std;

namespace yayoi {

    Piece::Piece()
    :_job(FIGHTER)
    ,_color(SUN)
    ,_baseStatus({{POWER, 0}, {ARMOR, 0}, {RESIST, 0}})
    ,_individualStatus({{POWER, 0}, {ARMOR, 0}, {RESIST, 0}})
    ,_hp(MAX_HP)
    ,_team(RED)
    ,_position({0, 0})
    ,_king(false) {
    }

    Piece::Piece(Job job, Color color, const map<Param, int> &baseStatus, const map<Param, int> &individualStatus, Team team, int row, int col, bool king)
    :_job(job)
    ,_color(color)
    ,_baseStatus(baseStatus)
    ,_individualStatus(individualStatus)
    ,_hp(MAX_HP)
    ,_team(team)
    ,_position({row, col})
    ,_king(king) {
    }

    Piece::~Piece() {
    }

    void Piece::applyChip(const pair<int, int> &chip) {
        _position.first += chip.first;
        _position.second += chip.second;
    }

    int Piece::applyDamage(int damage) {
        damage = min(damage, _hp);
        _hp -= damage;
        if (_hp <= 0) {
            _position = {-1, -1};
        }
        return damage;
    }

}
