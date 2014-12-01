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

        class Master {
        public:
            Job _job;
            Color _color;
            std::map<Param, int> _baseStatus;
        };

        const static int MAX_HP = 100;

        Piece();
        Piece(int masterId, const std::map<Param, int> &individualStatus, Team team, int row, int col, bool king);
        ~Piece();

        static void setMaster(int masterId, Job job, Color color, const std::map<Param, int> &baseStatus);

        int getMasterId() const { return _masterId; };
        Job getJob() const { return getMasters().at(_masterId)._job; };
        Color getColor() const { return getMasters().at(_masterId)._color; };
        int getBaseStatus(Param param) const { return getMasters().at(_masterId)._baseStatus.at(param); };
        int getIndividualStatus(Param param) const { return _individualStatus.at(param); };
        int getStatus(Param param) const {
            return getBaseStatus(param) + getIndividualStatus(param) * 2;
        };
        int getHp() const { return _hp; };
        Team getTeam() const { return _team; };
        const std::pair<int, int>& getPosition() const { return _position; };
        bool isKing() const { return _king; };
        int getIdInMatch() const { return _idInMatch; };
        void setIdInMatch(int idInMatch) { _idInMatch = idInMatch; };
        void applyChip(const std::pair<int, int>& chip);
        int applyDamage(int damage);

    private:
        int _masterId;
        std::map<Param, int> _individualStatus;
        int _hp;
        Team _team;
        std::pair<int, int> _position;
        bool _king;
        int _idInMatch;
        static std::map<int, Master>& getMasters();
    };

}

#endif /* defined(__yayoi__Piece__) */
