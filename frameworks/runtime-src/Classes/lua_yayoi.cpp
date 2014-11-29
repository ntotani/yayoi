#include "lua_yayoi.hpp"
#include "Piece.h"
#include "Match.h"
#include "tolua_fix.h"
#include "LuaBasicConversions.h"



int lua_yayoi_Piece_getColor(lua_State* tolua_S)
{
    int argc = 0;
    yayoi::Piece* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"yayoi.Piece",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (yayoi::Piece*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_yayoi_Piece_getColor'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        int ret = (int)cobj->getColor();
        tolua_pushnumber(tolua_S,(lua_Number)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "yayoi.Piece:getColor",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_yayoi_Piece_getColor'.",&tolua_err);
#endif

    return 0;
}
int lua_yayoi_Piece_getStatus(lua_State* tolua_S)
{
    int argc = 0;
    yayoi::Piece* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"yayoi.Piece",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (yayoi::Piece*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_yayoi_Piece_getStatus'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        yayoi::Piece::Param arg0;

        ok &= luaval_to_int32(tolua_S, 2,(int *)&arg0, "yayoi.Piece:getStatus");
        if(!ok)
            return 0;
        int ret = cobj->getStatus(arg0);
        tolua_pushnumber(tolua_S,(lua_Number)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "yayoi.Piece:getStatus",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_yayoi_Piece_getStatus'.",&tolua_err);
#endif

    return 0;
}
int lua_yayoi_Piece_applyDamage(lua_State* tolua_S)
{
    int argc = 0;
    yayoi::Piece* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"yayoi.Piece",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (yayoi::Piece*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_yayoi_Piece_applyDamage'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        int arg0;

        ok &= luaval_to_int32(tolua_S, 2,(int *)&arg0, "yayoi.Piece:applyDamage");
        if(!ok)
            return 0;
        int ret = cobj->applyDamage(arg0);
        tolua_pushnumber(tolua_S,(lua_Number)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "yayoi.Piece:applyDamage",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_yayoi_Piece_applyDamage'.",&tolua_err);
#endif

    return 0;
}
int lua_yayoi_Piece_getTeam(lua_State* tolua_S)
{
    int argc = 0;
    yayoi::Piece* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"yayoi.Piece",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (yayoi::Piece*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_yayoi_Piece_getTeam'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        int ret = (int)cobj->getTeam();
        tolua_pushnumber(tolua_S,(lua_Number)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "yayoi.Piece:getTeam",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_yayoi_Piece_getTeam'.",&tolua_err);
#endif

    return 0;
}
int lua_yayoi_Piece_getJob(lua_State* tolua_S)
{
    int argc = 0;
    yayoi::Piece* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"yayoi.Piece",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (yayoi::Piece*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_yayoi_Piece_getJob'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        int ret = (int)cobj->getJob();
        tolua_pushnumber(tolua_S,(lua_Number)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "yayoi.Piece:getJob",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_yayoi_Piece_getJob'.",&tolua_err);
#endif

    return 0;
}
int lua_yayoi_Piece_getBaseStatus(lua_State* tolua_S)
{
    int argc = 0;
    yayoi::Piece* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"yayoi.Piece",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (yayoi::Piece*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_yayoi_Piece_getBaseStatus'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        yayoi::Piece::Param arg0;

        ok &= luaval_to_int32(tolua_S, 2,(int *)&arg0, "yayoi.Piece:getBaseStatus");
        if(!ok)
            return 0;
        int ret = cobj->getBaseStatus(arg0);
        tolua_pushnumber(tolua_S,(lua_Number)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "yayoi.Piece:getBaseStatus",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_yayoi_Piece_getBaseStatus'.",&tolua_err);
#endif

    return 0;
}
int lua_yayoi_Piece_applyChip(lua_State* tolua_S)
{
    int argc = 0;
    yayoi::Piece* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"yayoi.Piece",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (yayoi::Piece*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_yayoi_Piece_applyChip'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        std::pair<int, int> arg0;

        ok &= luaval_to_ipair(tolua_S, 2, &arg0, "yayoi.Piece:applyChip");
        if(!ok)
            return 0;
        cobj->applyChip(arg0);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "yayoi.Piece:applyChip",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_yayoi_Piece_applyChip'.",&tolua_err);
#endif

    return 0;
}
int lua_yayoi_Piece_getIndividualStatus(lua_State* tolua_S)
{
    int argc = 0;
    yayoi::Piece* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"yayoi.Piece",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (yayoi::Piece*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_yayoi_Piece_getIndividualStatus'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        yayoi::Piece::Param arg0;

        ok &= luaval_to_int32(tolua_S, 2,(int *)&arg0, "yayoi.Piece:getIndividualStatus");
        if(!ok)
            return 0;
        int ret = cobj->getIndividualStatus(arg0);
        tolua_pushnumber(tolua_S,(lua_Number)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "yayoi.Piece:getIndividualStatus",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_yayoi_Piece_getIndividualStatus'.",&tolua_err);
#endif

    return 0;
}
int lua_yayoi_Piece_getHp(lua_State* tolua_S)
{
    int argc = 0;
    yayoi::Piece* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"yayoi.Piece",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (yayoi::Piece*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_yayoi_Piece_getHp'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        int ret = cobj->getHp();
        tolua_pushnumber(tolua_S,(lua_Number)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "yayoi.Piece:getHp",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_yayoi_Piece_getHp'.",&tolua_err);
#endif

    return 0;
}
int lua_yayoi_Piece_isKing(lua_State* tolua_S)
{
    int argc = 0;
    yayoi::Piece* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"yayoi.Piece",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (yayoi::Piece*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_yayoi_Piece_isKing'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        bool ret = cobj->isKing();
        tolua_pushboolean(tolua_S,(bool)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "yayoi.Piece:isKing",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_yayoi_Piece_isKing'.",&tolua_err);
#endif

    return 0;
}
int lua_yayoi_Piece_getPosition(lua_State* tolua_S)
{
    int argc = 0;
    yayoi::Piece* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"yayoi.Piece",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (yayoi::Piece*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_yayoi_Piece_getPosition'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        const std::pair<int, int>& ret = cobj->getPosition();
        ipair_to_luaval(tolua_S, ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "yayoi.Piece:getPosition",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_yayoi_Piece_getPosition'.",&tolua_err);
#endif

    return 0;
}
int lua_yayoi_Piece_constructor(lua_State* tolua_S)
{
    int argc = 0;
    yayoi::Piece* cobj = nullptr;
    bool ok  = true;
#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

    argc = lua_gettop(tolua_S)-1;
    do{
        if (argc == 8) {
            yayoi::Piece::Job arg0;
            ok &= luaval_to_int32(tolua_S, 2,(int *)&arg0, "yayoi.Piece:Piece");

            if (!ok) { break; }
            yayoi::Piece::Color arg1;
            ok &= luaval_to_int32(tolua_S, 3,(int *)&arg1, "yayoi.Piece:Piece");

            if (!ok) { break; }
            std::map<yayoi::Piece::Param, int, std::less<yayoi::Piece::Param>, std::allocator<std::pair<const yayoi::Piece::Param, int> > > arg2;
            cocos2d::ValueMapIntKey vmikarg2;ok &= luaval_to_ccvaluemapintkey(tolua_S, 4, &vmikarg2, "yayoi.Piece:Piece");for (auto e : vmikarg2) { arg2[static_cast<yayoi::Piece::Param>(e.first)] = e.second.asInt(); };

            if (!ok) { break; }
            std::map<yayoi::Piece::Param, int, std::less<yayoi::Piece::Param>, std::allocator<std::pair<const yayoi::Piece::Param, int> > > arg3;
            cocos2d::ValueMapIntKey vmikarg3;ok &= luaval_to_ccvaluemapintkey(tolua_S, 5, &vmikarg3, "yayoi.Piece:Piece");for (auto e : vmikarg3) { arg3[static_cast<yayoi::Piece::Param>(e.first)] = e.second.asInt(); };

            if (!ok) { break; }
            yayoi::Team arg4;
            ok &= luaval_to_int32(tolua_S, 6,(int *)&arg4, "yayoi.Piece:Piece");

            if (!ok) { break; }
            int arg5;
            ok &= luaval_to_int32(tolua_S, 7,(int *)&arg5, "yayoi.Piece:Piece");

            if (!ok) { break; }
            int arg6;
            ok &= luaval_to_int32(tolua_S, 8,(int *)&arg6, "yayoi.Piece:Piece");

            if (!ok) { break; }
            bool arg7;
            ok &= luaval_to_boolean(tolua_S, 9,&arg7, "yayoi.Piece:Piece");

            if (!ok) { break; }
            cobj = new yayoi::Piece(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
            tolua_pushusertype(tolua_S,(void*)cobj,"yayoi.Piece");
            tolua_register_gc(tolua_S,lua_gettop(tolua_S));
            return 1;
        }
    }while(0);
    ok  = true;
    do{
        if (argc == 0) {
            cobj = new yayoi::Piece();
            tolua_pushusertype(tolua_S,(void*)cobj,"yayoi.Piece");
            tolua_register_gc(tolua_S,lua_gettop(tolua_S));
            return 1;
        }
    }while(0);
    ok  = true;
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n",  "yayoi.Piece:Piece",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_error(tolua_S,"#ferror in function 'lua_yayoi_Piece_constructor'.",&tolua_err);
#endif

    return 0;
}

static int lua_yayoi_Piece_finalize(lua_State* tolua_S)
{
    printf("luabindings: finalizing LUA object (Piece)");
#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
    if (
    !tolua_isusertype(tolua_S,1,"Piece",0,&tolua_err) ||
    !tolua_isnoobj(tolua_S,2,&tolua_err)
    )
        goto tolua_lerror;
    else
#endif
    {
        yayoi::Piece* self = (yayoi::Piece*)  tolua_tousertype(tolua_S,1,0);
#if COCOS2D_DEBUG >= 1
        if (!self) tolua_error(tolua_S,"invalid 'self' in function 'delete'", nullptr);
#endif
        delete self;
    }
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'delete'.",&tolua_err);
    return 0;
#endif
    return 0;
}

int lua_register_yayoi_Piece(lua_State* tolua_S)
{
    tolua_usertype(tolua_S,"yayoi.Piece");
    tolua_cclass(tolua_S,"Piece","yayoi.Piece","",lua_yayoi_Piece_finalize);

    tolua_beginmodule(tolua_S,"Piece");
        tolua_function(tolua_S,"new",lua_yayoi_Piece_constructor);
        tolua_function(tolua_S,"getColor",lua_yayoi_Piece_getColor);
        tolua_function(tolua_S,"getStatus",lua_yayoi_Piece_getStatus);
        tolua_function(tolua_S,"applyDamage",lua_yayoi_Piece_applyDamage);
        tolua_function(tolua_S,"getTeam",lua_yayoi_Piece_getTeam);
        tolua_function(tolua_S,"getJob",lua_yayoi_Piece_getJob);
        tolua_function(tolua_S,"getBaseStatus",lua_yayoi_Piece_getBaseStatus);
        tolua_function(tolua_S,"applyChip",lua_yayoi_Piece_applyChip);
        tolua_function(tolua_S,"getIndividualStatus",lua_yayoi_Piece_getIndividualStatus);
        tolua_function(tolua_S,"getHp",lua_yayoi_Piece_getHp);
        tolua_function(tolua_S,"isKing",lua_yayoi_Piece_isKing);
        tolua_function(tolua_S,"getPosition",lua_yayoi_Piece_getPosition);
    tolua_endmodule(tolua_S);
    std::string typeName = typeid(yayoi::Piece).name();
    g_luaType[typeName] = "yayoi.Piece";
    g_typeCast["Piece"] = "yayoi.Piece";
    return 1;
}

int lua_yayoi_Chip_getDir(lua_State* tolua_S)
{
    int argc = 0;
    yayoi::Chip* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"yayoi.Chip",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (yayoi::Chip*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_yayoi_Chip_getDir'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        const std::pair<int, int>& ret = cobj->getDir();
        ipair_to_luaval(tolua_S, ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "yayoi.Chip:getDir",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_yayoi_Chip_getDir'.",&tolua_err);
#endif

    return 0;
}
int lua_yayoi_Chip_constructor(lua_State* tolua_S)
{
    int argc = 0;
    yayoi::Chip* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif



    argc = lua_gettop(tolua_S)-1;
    if (argc == 2) 
    {
        int arg0;
        int arg1;

        ok &= luaval_to_int32(tolua_S, 2,(int *)&arg0, "yayoi.Chip:Chip");

        ok &= luaval_to_int32(tolua_S, 3,(int *)&arg1, "yayoi.Chip:Chip");
        if(!ok)
            return 0;
        cobj = new yayoi::Chip(arg0, arg1);
        tolua_pushusertype(tolua_S,(void*)cobj,"yayoi.Chip");
        tolua_register_gc(tolua_S,lua_gettop(tolua_S));
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "yayoi.Chip:Chip",argc, 2);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_error(tolua_S,"#ferror in function 'lua_yayoi_Chip_constructor'.",&tolua_err);
#endif

    return 0;
}

static int lua_yayoi_Chip_finalize(lua_State* tolua_S)
{
    printf("luabindings: finalizing LUA object (Chip)");
#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
    if (
    !tolua_isusertype(tolua_S,1,"Chip",0,&tolua_err) ||
    !tolua_isnoobj(tolua_S,2,&tolua_err)
    )
        goto tolua_lerror;
    else
#endif
    {
        yayoi::Chip* self = (yayoi::Chip*)  tolua_tousertype(tolua_S,1,0);
#if COCOS2D_DEBUG >= 1
        if (!self) tolua_error(tolua_S,"invalid 'self' in function 'delete'", nullptr);
#endif
        delete self;
    }
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'delete'.",&tolua_err);
    return 0;
#endif
    return 0;
}

int lua_register_yayoi_Chip(lua_State* tolua_S)
{
    tolua_usertype(tolua_S,"yayoi.Chip");
    tolua_cclass(tolua_S,"Chip","yayoi.Chip","",lua_yayoi_Chip_finalize);

    tolua_beginmodule(tolua_S,"Chip");
        tolua_function(tolua_S,"new",lua_yayoi_Chip_constructor);
        tolua_function(tolua_S,"getDir",lua_yayoi_Chip_getDir);
    tolua_endmodule(tolua_S);
    std::string typeName = typeid(yayoi::Chip).name();
    g_luaType[typeName] = "yayoi.Chip";
    g_typeCast["Chip"] = "yayoi.Chip";
    return 1;
}

int lua_yayoi_Match_fillDeck(lua_State* tolua_S)
{
    int argc = 0;
    yayoi::Match* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"yayoi.Match",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (yayoi::Match*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_yayoi_Match_fillDeck'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 2) 
    {
        yayoi::Team arg0;
        std::map<yayoi::Chip, int, std::less<yayoi::Chip>, std::allocator<std::pair<const yayoi::Chip, int> > > arg1;

        ok &= luaval_to_int32(tolua_S, 2,(int *)&arg0, "yayoi.Match:fillDeck");

        ok &= luaval_to_usertypemap(tolua_S, 3, &arg1, "yayoi.Chip");
        if(!ok)
            return 0;
        cobj->fillDeck(arg0, arg1);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "yayoi.Match:fillDeck",argc, 2);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_yayoi_Match_fillDeck'.",&tolua_err);
#endif

    return 0;
}
int lua_yayoi_Match_getCol(lua_State* tolua_S)
{
    int argc = 0;
    yayoi::Match* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"yayoi.Match",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (yayoi::Match*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_yayoi_Match_getCol'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        int ret = cobj->getCol();
        tolua_pushnumber(tolua_S,(lua_Number)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "yayoi.Match:getCol",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_yayoi_Match_getCol'.",&tolua_err);
#endif

    return 0;
}
int lua_yayoi_Match_getRow(lua_State* tolua_S)
{
    int argc = 0;
    yayoi::Match* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"yayoi.Match",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (yayoi::Match*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_yayoi_Match_getRow'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        int ret = cobj->getRow();
        tolua_pushnumber(tolua_S,(lua_Number)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "yayoi.Match:getRow",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_yayoi_Match_getRow'.",&tolua_err);
#endif

    return 0;
}
int lua_yayoi_Match_getDeck(lua_State* tolua_S)
{
    int argc = 0;
    yayoi::Match* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"yayoi.Match",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (yayoi::Match*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_yayoi_Match_getDeck'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        yayoi::Team arg0;

        ok &= luaval_to_int32(tolua_S, 2,(int *)&arg0, "yayoi.Match:getDeck");
        if(!ok)
            return 0;
        const std::list<yayoi::Chip *, std::allocator<yayoi::Chip *> >& ret = cobj->getDeck(arg0);
        cclist_usertype_to_luaval(tolua_S, ret, "yayoi.Chip");
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "yayoi.Match:getDeck",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_yayoi_Match_getDeck'.",&tolua_err);
#endif

    return 0;
}
int lua_yayoi_Match_applyChip(lua_State* tolua_S)
{
    int argc = 0;
    yayoi::Match* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"yayoi.Match",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (yayoi::Match*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_yayoi_Match_applyChip'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 2) 
    {
        yayoi::Piece* arg0;
        int arg1;

        ok &= luaval_to_object<yayoi::Piece>(tolua_S, 2, "yayoi.Piece",&arg0);

        ok &= luaval_to_int32(tolua_S, 3,(int *)&arg1, "yayoi.Match:applyChip");
        if(!ok)
            return 0;
        cobj->applyChip(arg0, arg1);
        return 0;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "yayoi.Match:applyChip",argc, 2);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_yayoi_Match_applyChip'.",&tolua_err);
#endif

    return 0;
}
int lua_yayoi_Match_getPieces(lua_State* tolua_S)
{
    int argc = 0;
    yayoi::Match* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"yayoi.Match",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (yayoi::Match*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_yayoi_Match_getPieces'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        const std::vector<yayoi::Piece *, std::allocator<yayoi::Piece *> >& ret = cobj->getPieces();
        ccvector_usertype_to_luaval(tolua_S, ret, "yayoi.Piece");
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "yayoi.Match:getPieces",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_yayoi_Match_getPieces'.",&tolua_err);
#endif

    return 0;
}
int lua_yayoi_Match_wonTeam(lua_State* tolua_S)
{
    int argc = 0;
    yayoi::Match* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"yayoi.Match",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (yayoi::Match*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_yayoi_Match_wonTeam'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        int ret = (int)cobj->wonTeam();
        tolua_pushnumber(tolua_S,(lua_Number)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "yayoi.Match:wonTeam",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_yayoi_Match_wonTeam'.",&tolua_err);
#endif

    return 0;
}
int lua_yayoi_Match_calcDamage(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"yayoi.Match",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 2)
    {
        yayoi::Piece* arg0;
        yayoi::Piece* arg1;
        ok &= luaval_to_object<yayoi::Piece>(tolua_S, 2, "yayoi.Piece",&arg0);
        ok &= luaval_to_object<yayoi::Piece>(tolua_S, 3, "yayoi.Piece",&arg1);
        if(!ok)
            return 0;
        int ret = yayoi::Match::calcDamage(arg0, arg1);
        tolua_pushnumber(tolua_S,(lua_Number)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d\n ", "yayoi.Match:calcDamage",argc, 2);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_yayoi_Match_calcDamage'.",&tolua_err);
#endif
    return 0;
}
int lua_yayoi_Match_constructor(lua_State* tolua_S)
{
    int argc = 0;
    yayoi::Match* cobj = nullptr;
    bool ok  = true;
#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

    argc = lua_gettop(tolua_S)-1;
    do{
        if (argc == 5) {
            int arg0;
            ok &= luaval_to_int32(tolua_S, 2,(int *)&arg0, "yayoi.Match:Match");

            if (!ok) { break; }
            std::vector<yayoi::Piece *, std::allocator<yayoi::Piece *> > arg1;
            ok &= luaval_to_std_vector_usertype(tolua_S, 3, &arg1, "yayoi.Match:Match");

            if (!ok) { break; }
            int arg2;
            ok &= luaval_to_int32(tolua_S, 4,(int *)&arg2, "yayoi.Match:Match");

            if (!ok) { break; }
            int arg3;
            ok &= luaval_to_int32(tolua_S, 5,(int *)&arg3, "yayoi.Match:Match");

            if (!ok) { break; }
            std::map<yayoi::Chip, int, std::less<yayoi::Chip>, std::allocator<std::pair<const yayoi::Chip, int> > > arg4;
            ok &= luaval_to_usertypemap(tolua_S, 6, &arg4, "yayoi.Chip");

            if (!ok) { break; }
            cobj = new yayoi::Match(arg0, arg1, arg2, arg3, arg4);
            tolua_pushusertype(tolua_S,(void*)cobj,"yayoi.Match");
            tolua_register_gc(tolua_S,lua_gettop(tolua_S));
            return 1;
        }
    }while(0);
    ok  = true;
    do{
        if (argc == 0) {
            cobj = new yayoi::Match();
            tolua_pushusertype(tolua_S,(void*)cobj,"yayoi.Match");
            tolua_register_gc(tolua_S,lua_gettop(tolua_S));
            return 1;
        }
    }while(0);
    ok  = true;
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n",  "yayoi.Match:Match",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_error(tolua_S,"#ferror in function 'lua_yayoi_Match_constructor'.",&tolua_err);
#endif

    return 0;
}

static int lua_yayoi_Match_finalize(lua_State* tolua_S)
{
    printf("luabindings: finalizing LUA object (Match)");
#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
    if (
    !tolua_isusertype(tolua_S,1,"Match",0,&tolua_err) ||
    !tolua_isnoobj(tolua_S,2,&tolua_err)
    )
        goto tolua_lerror;
    else
#endif
    {
        yayoi::Match* self = (yayoi::Match*)  tolua_tousertype(tolua_S,1,0);
#if COCOS2D_DEBUG >= 1
        if (!self) tolua_error(tolua_S,"invalid 'self' in function 'delete'", nullptr);
#endif
        delete self;
    }
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'delete'.",&tolua_err);
    return 0;
#endif
    return 0;
}

int lua_register_yayoi_Match(lua_State* tolua_S)
{
    tolua_usertype(tolua_S,"yayoi.Match");
    tolua_cclass(tolua_S,"Match","yayoi.Match","",lua_yayoi_Match_finalize);

    tolua_beginmodule(tolua_S,"Match");
        tolua_function(tolua_S,"new",lua_yayoi_Match_constructor);
        tolua_function(tolua_S,"fillDeck",lua_yayoi_Match_fillDeck);
        tolua_function(tolua_S,"getCol",lua_yayoi_Match_getCol);
        tolua_function(tolua_S,"getRow",lua_yayoi_Match_getRow);
        tolua_function(tolua_S,"getDeck",lua_yayoi_Match_getDeck);
        tolua_function(tolua_S,"applyChip",lua_yayoi_Match_applyChip);
        tolua_function(tolua_S,"getPieces",lua_yayoi_Match_getPieces);
        tolua_function(tolua_S,"wonTeam",lua_yayoi_Match_wonTeam);
        tolua_function(tolua_S,"calcDamage", lua_yayoi_Match_calcDamage);
    tolua_endmodule(tolua_S);
    std::string typeName = typeid(yayoi::Match).name();
    g_luaType[typeName] = "yayoi.Match";
    g_typeCast["Match"] = "yayoi.Match";
    return 1;
}
TOLUA_API int register_all_yayoi(lua_State* tolua_S)
{
	tolua_open(tolua_S);
	
	tolua_module(tolua_S,"yayoi",0);
	tolua_beginmodule(tolua_S,"yayoi");

	lua_register_yayoi_Chip(tolua_S);
	lua_register_yayoi_Piece(tolua_S);
	lua_register_yayoi_Match(tolua_S);

	tolua_endmodule(tolua_S);
	return 1;
}

