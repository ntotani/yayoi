#ifndef __yayoi__Piece__
#define __yayoi__Piece__

#include <map>

namespace yayoi {

    class Piece {
    public:

        enum Param { POWER, ARMOR, RESIST };
        enum Job { FIGHTER, MAGE, HEALER };
        enum Color { SUN, MON, TUE, WED, THU, FRI, SAT };

        const static int MAX_HP = 100;

        Piece();
        Piece(Job job, Color color, const std::map<Param, int> &baseStatus, const std::map<Param, int> &individualStatus);
        ~Piece();
        Job getJob() const { return _job; };
        Color getColor() const { return _color; };
        int getBaseStatus(Param param) const { return _baseStatus.at(param); };
        int getIndividualStatus(Param param) const { return _individualStatus.at(param); };
        int getStatus(Param param) const {
            return _baseStatus.at(param) + _individualStatus.at(param) * 2;
        };
        int getHp() const { return _hp; };
        int applyDamage(int damage);

    private:
        Job _job;
        Color _color;
        std::map<Param, int> _baseStatus;
        std::map<Param, int> _individualStatus;
        int _hp;
    };

}

#endif /* defined(__yayoi__Piece__) */
