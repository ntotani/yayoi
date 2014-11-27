#include "Match.h"
#include <algorithm>

using namespace std;

namespace yayoi {

    Match::Match()
    :_rnd(0)
    ,_row(1)
    ,_col(1)
    ,_pieces({})
    ,_decks({{RED, {}}, {BLUE, {}}}) {
    }

    Match::Match(int seed, vector<Piece*> pieces, int row, int col, const map<Chip, int> &freq)
    :_rnd(seed)
    ,_row(row)
    ,_col(col)
    ,_pieces(pieces)
    ,_decks({{RED, {}}, {BLUE, {}}}) {
        fillDeck(RED, freq);
        fillDeck(BLUE, freq);
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

    void Match::applyChip(Team team, int idx, Piece *target) {
        if (target->getTeam() != team) {
            return;
        }
        auto &deck = _decks.at(team);
        auto it = deck.begin();
        for (int i = 0; i < idx; i++) {
            it++;
        }
        if (target->getHp() > 0) {
            auto pos = target->getPosition();
            auto dir = (*it).getDir();
            pair<int, int> newPos(pos.first + dir.first, pos.second + dir.second);
            if (newPos.first >= 0 && newPos.first < _row && newPos.second >= 0 && newPos.second < _col) {
                target->applyChip(dir);
            }
        }
        deck.erase(it);
        deck.push_back(*it);
    }

}
