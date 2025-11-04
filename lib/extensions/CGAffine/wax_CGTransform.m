//
//  wax_CGAffine.m
//  EmpireState
//
//  Created by Corey Johnson on 10/6/09.
//  Copyright 2009 Probably Interactive. All rights reserved.
//

#import "wax_CGTransform.h"

#import "wax_instance.h"
#import "wax_helpers.h"

#import <lua_ios/lua.h>
#import <lua_ios/lauxlib.h>
#import <CoreGraphics/CoreGraphics.h>

#define METATABLE_NAME "wax.CGTransform"

static int identity(lua_State *L) {
    CGAffineTransform identity = CGAffineTransformIdentity;
    wax_fromObjc(L, @encode(CGAffineTransform), &identity);
    
    return 1;
}


// wax.CGTransform.scale(transform, 2, 2) -- Returns new transform
static int scale(lua_State *L) {
    void *value = wax_copyToObjc(L, @encode(CGAffineTransform), 1, nil);
    CGAffineTransform transform = *(CGAffineTransform *)value;
    free(value);
    transform = CGAffineTransformScale(transform, luaL_checknumber(L, 2), luaL_checknumber(L, 3));
    wax_fromObjc(L, @encode(CGAffineTransform), &transform);
    
    return 1;
}

// wax.CGTransform.translate(transform, 2, 2) -- Returns new transform
static int translate(lua_State *L) {
    void *value = wax_copyToObjc(L, @encode(CGAffineTransform), 1, nil);
    CGAffineTransform transform = *(CGAffineTransform *)value;
    free(value);
    transform = CGAffineTransformTranslate(transform, luaL_checknumber(L, 2), luaL_checknumber(L, 3));
    wax_fromObjc(L, @encode(CGAffineTransform), &transform);
    
    return 1;
}

// wax.CGTransform.rotate(transform, angle) -- Returns new transform
static int rotate(lua_State *L) {
    void *value = wax_copyToObjc(L, @encode(CGAffineTransform), 1, nil);
    CGAffineTransform transform = *(CGAffineTransform *)value;
    free(value);
    transform = CGAffineTransformRotate(transform, luaL_checknumber(L, 2));
    wax_fromObjc(L, @encode(CGAffineTransform), &transform);


    
    return 1;
}

static const struct luaL_Reg metaFunctions[] = {
    {NULL, NULL}
};

static const struct luaL_Reg functions[] = {
    {"identity", identity},
    {"scale", scale},
    {"translate", translate},
    {"rotate", rotate},
    
    {NULL, NULL}
};

//int luaopen_wax_CGTransform(lua_State *L) {
//    BEGIN_STACK_MODIFY(L);
//    
//    luaL_newmetatable(L, METATABLE_NAME);        
//    luaL_register(L, NULL, metaFunctions);
//    luaL_register(L, METATABLE_NAME, functions);    
//    
//    END_STACK_MODIFY(L, 0)
//    
//    return 1;
//}

int luaopen_wax_CGTransform(lua_State *L) {
    BEGIN_STACK_MODIFY(L);

    luaL_newmetatable(L, METATABLE_NAME);

    // Register metamethods for this metatable
    luaL_setfuncs(L, metaFunctions, 0);

    // Create module table for “functions”
    lua_newtable(L);
    luaL_setfuncs(L, functions, 0);

    // Set module’s metatable so module methods fall back to instance metatable
    luaL_getmetatable(L, METATABLE_NAME);
    lua_setmetatable(L, -2);

    END_STACK_MODIFY(L, 1);

    return 1;
}
