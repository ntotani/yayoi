#include "lua_yayoi.hpp"
#include "Piece.h"
#include "tolua_fix.h"
#include "LuaBasicConversions.h"



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
    tolua_cclass(tolua_S,"Piece","yayoi.Piece","",nullptr);

    tolua_beginmodule(tolua_S,"Piece");
        tolua_function(tolua_S,"getIndividualStatus",lua_yayoi_Piece_getIndividualStatus);
        tolua_function(tolua_S,"getColor",lua_yayoi_Piece_getColor);
        tolua_function(tolua_S,"getJob",lua_yayoi_Piece_getJob);
        tolua_function(tolua_S,"getBaseStatus",lua_yayoi_Piece_getBaseStatus);
        tolua_function(tolua_S,"getStatus",lua_yayoi_Piece_getStatus);
    tolua_endmodule(tolua_S);
    std::string typeName = typeid(yayoi::Piece).name();
    g_luaType[typeName] = "yayoi.Piece";
    g_typeCast["Piece"] = "yayoi.Piece";
    return 1;
}
TOLUA_API int register_all_yayoi(lua_State* tolua_S)
{
	tolua_open(tolua_S);
	
	tolua_module(tolua_S,"yayoi",0);
	tolua_beginmodule(tolua_S,"yayoi");

	lua_register_yayoi_Piece(tolua_S);

	tolua_endmodule(tolua_S);
	return 1;
}

