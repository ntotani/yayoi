#include "Match.h"
#include <algorithm>

using namespace std;

namespace yayoi {

    Match::Match()
    :_rnd(0)
    ,_row(1)
    ,_col(1)
    ,_pieces({})
    ,_decks({{RED, {}}, {BLUE, {}}})
    ,_castle({}) {
        setCastle();
    }

    Match::Match(int seed, vector<Piece*> pieces, int row, int col, const map<Chip, int> &freq)
    :_rnd(seed)
    ,_row(row)
    ,_col(col)
    ,_pieces(pieces)
    ,_decks({{RED, {}}, {BLUE, {}}})
    ,_castle({}) {
        fillDeck(RED, freq);
        fillDeck(BLUE, freq);
        setCastle();
    }

    void Match::setCastle() {
        for (auto e : _pieces) {
            if (e->isKing()) {
                _castle[e->getTeam()] = e->getPosition();
            }
        }
    }

    Match::~Match() {
        for (auto e : _pieces) {
            if (e) {
                delete e;
            }
        }
    }

    void Match::fillDeck(Team team, const map<Chip, int> &freq) {
        vector<pair<Chip, int>> chips;
        for (auto e : freq) {
            for (int i = 0; i < e.second; i++) {
                chips.push_back({e.first, _rnd()});
            }
        }
        sort(chips.begin(), chips.end(), [](const pair<Chip, int> &a, const pair<Chip, int> &b) {
            return a.second < b.second;
        });
        for (auto e : chips) {
            _decks.at(team).push_back(e.first);
        }
    }

    void Match::applyChip(Piece *target, int idx) {
        auto &deck = _decks.at(target->getTeam());
        auto it = deck.begin();
        for (int i = 0; i < idx; i++) {
            it++;
        }
        if (target->getHp() > 0) {
            auto pos = target->getPosition();
            auto dir = (*it).getDir();
            pair<int, int> newPos(pos.first + dir.first, pos.second + dir.second);
            if (newPos.first >= 0 && newPos.first < _row && newPos.second >= 0 && newPos.second < _col) {
                Piece *onTile = nullptr;
                for (auto e : _pieces) {
                    if (e->getPosition() == newPos) {
                        onTile = e;
                        break;
                    }
                }
                if (onTile == nullptr) {
                    target->applyChip(dir);
                } else {
                    onTile->applyDamage(calcDamage(target, onTile));
                    if (onTile->getHp() <= 0) {
                        target->applyChip(dir);
                    }
                }
            }
        }
        deck.erase(it);
        deck.push_back(*it);
    }

    int Match::calcDamage(Piece *from, Piece *to) {
        int attack = from->getStatus(Piece::POWER);
        int block = to->getStatus(from->getJob() == Piece::FIGHTER ? Piece::ARMOR : Piece::RESIST);
        int damage = 30 * attack / block;
        damage *= from->getJob() == Piece::HEALER ? -1 : 1;
        return damage;
    }

    Team Match::wonTeam() const {
        for (auto e : _pieces) {
            if (e->isKing()) {
                if (e->getHp() == 0) {
                    return e->getTeam() == RED ? BLUE : RED;
                }
                if (e->getPosition() == _castle.at(RED) && e->getTeam() == BLUE) {
                    return BLUE;
                }
                if (e->getPosition() == _castle.at(BLUE) && e->getTeam() == RED) {
                    return RED;
                }
            }
        }
        return UNKNOWN;
    }

}
