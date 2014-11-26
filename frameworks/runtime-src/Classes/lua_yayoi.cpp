#include "lua_yayoi.hpp"
#include "Piece.h"
#include "tolua_fix.h"
#include "LuaBasicConversions.h"



int lua_yayoi_Piece_getPieceID(lua_State* tolua_S)
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
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_yayoi_Piece_getPieceID'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        int ret = cobj->getPieceID();
        tolua_pushnumber(tolua_S,(lua_Number)ret);
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "yayoi.Piece:getPieceID",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_yayoi_Piece_getPieceID'.",&tolua_err);
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
    if (argc == 0) 
    {
        if(!ok)
            return 0;
        cobj = new yayoi::Piece();
        tolua_pushusertype(tolua_S,(void*)cobj,"yayoi.Piece");
        tolua_register_gc(tolua_S,lua_gettop(tolua_S));
        return 1;
    }
    CCLOG("%s has wrong number of arguments: %d, was expecting %d \n", "yayoi.Piece:Piece",argc, 0);
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
        tolua_function(tolua_S,"getPieceID",lua_yayoi_Piece_getPieceID);
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

