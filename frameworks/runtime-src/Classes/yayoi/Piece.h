#ifndef __yayoi__Piece__
#define __yayoi__Piece__

#include <map>
#include "Type.h"

namespace yayoi {

    class Piece {
    public:

        enum Param { POWER, ARMOR, RESIST };
        enum Job { FIGHTER, MAGE, HEALER };
        enum Color { SUN, MON, TUE, WED, THU, FRI, SAT };

        const static int MAX_HP = 100;

        Piece();
        Piece(Job job, Color color, const std::map<Param, int> &baseStatus, const std::map<Param, int> &individualStatus, Team team, int row, int col, bool king);
        ~Piece();
        Job getJob() const { return _job; };
        Color getColor() const { return _color; };
        int getBaseStatus(Param param) const { return _baseStatus.at(param); };
        int getIndividualStatus(Param param) const { return _individualStatus.at(param); };
        int getStatus(Param param) const {
            return _baseStatus.at(param) + _individualStatus.at(param) * 2;
        };
        int getHp() const { return _hp; };
        Team getTeam() const { return _team; };
        const std::pair<int, int>& getPosition() const { return _position; };
        bool isKing() const { return _king; };
        void applyChip(const std::pair<int, int>& chip);
        int applyDamage(int damage);

    private:
        Job _job;
        Color _color;
        std::map<Param, int> _baseStatus;
        std::map<Param, int> _individualStatus;
        int _hp;
        Team _team;
        std::pair<int, int> _position;
        bool _king;
    };

}

#endif /* defined(__yayoi__Piece__) */
