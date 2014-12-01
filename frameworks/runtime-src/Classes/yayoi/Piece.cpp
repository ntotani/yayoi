#include "Piece.h"

using namespace std;

namespace yayoi {

    Piece::Piece()
    :_masterId(0)
    ,_individualStatus({{POWER, 0}, {ARMOR, 0}, {RESIST, 0}})
    ,_hp(MAX_HP)
    ,_team(RED)
    ,_position({0, 0})
    ,_king(false)
    ,_idInMatch(0) {
    }

    Piece::Piece(int masterId, const map<Param, int> &individualStatus, Team team, int row, int col, bool king)
    :_masterId(masterId)
    ,_individualStatus(individualStatus)
    ,_hp(MAX_HP)
    ,_team(team)
    ,_position({row, col})
    ,_king(king)
    ,_idInMatch(0) {
    }

    Piece::~Piece() {
    }

    void Piece::setMaster(int masterId, Piece::Job job, Piece::Color color, const map<Param, int> &baseStatus) {
        Master master;
        master._job = job;
        master._color = color;
        master._baseStatus = baseStatus;
        getMasters()[masterId] = master;
    }

    map<int, Piece::Master>& Piece::getMasters() {
        static map<int, Piece::Master> masters;
        return masters;
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
