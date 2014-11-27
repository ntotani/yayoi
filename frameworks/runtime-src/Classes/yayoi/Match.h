#ifndef __yayoi__Match__
#define __yayoi__Match__

#include <vector>
#include <list>
#include <map>
#include <random>
#include "Piece.h"

namespace yayoi {

    class Chip {
    public:
        Chip(int vertical, int horizon):_dir({vertical, horizon}){};
        ~Chip(){};
        const std::pair<int, int>& getDir() const { return _dir; };
        bool operator<(const Chip &e) const { return _dir < e._dir; };
    private:
        std::pair<int, int> _dir;
    };

    class Match {
    public:
        Match();
        Match(int seed, std::vector<Piece*> pieces, int row, int col, const std::map<Chip, int> &freq);
        ~Match();
        int getRow() const { return _row; };
        int getCol() const { return _col; };
        const std::vector<Piece*>& getPieces() const { return _pieces; };
        const std::list<Chip>& getDeck(Team team) const { return _decks.at(team); };
        void fillDeck(Team team, const std::map<Chip, int> &freq);
        void applyChip(Piece* target, int idx);
        static int calcDamage(Piece* from, Piece* to);

    private:
        std::mt19937 _rnd;
        int _row;
        int _col;
        std::vector<Piece*> _pieces;
        std::map<Team, std::list<Chip>> _decks;
    };

}

#endif /* defined(__yayoi__Match__) */
