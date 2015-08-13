#include "AppDelegate.h"
#include "CCLuaEngine.h"
#include "SimpleAudioEngine.h"
#include "cocos2d.h"
#include "lua_module_register.h"
#include "lua_cocos2dx_lilith_auto.hpp"
#include "lilith/lua_cocos2dx_lilith_manual.h"

extern "C" {
	int luaopen_struct (lua_State *L);
	int luaopen_bit(lua_State *L);
	int luaopen_lpeg (lua_State *L);
	int luaopen_mycrypto(lua_State *L);
}

#if (CC_TARGET_PLATFORM != CC_PLATFORM_LINUX)
#include "ide-support/CodeIDESupport.h"
#endif

#if (COCOS2D_DEBUG > 0) && (CC_CODE_IDE_DEBUG_SUPPORT > 0)
#include "runtime/Runtime.h"
#endif


using namespace CocosDenshion;

USING_NS_CC;
using namespace std;

AppDelegate::AppDelegate()
{
}

AppDelegate::~AppDelegate()
{
    SimpleAudioEngine::end();

#if (COCOS2D_DEBUG > 0) && (CC_CODE_IDE_DEBUG_SUPPORT > 0)
    // NOTE:Please don't remove this call if you want to debug with Cocos Code IDE
    RuntimeEngine::getInstance()->end();
#endif
}

//if you want a different context,just modify the value of glContextAttrs
//it will takes effect on all platforms
void AppDelegate::initGLContextAttrs()
{
    //set OpenGL context attributions,now can only set six attributions:
    //red,green,blue,alpha,depth,stencil
    GLContextAttrs glContextAttrs = {8, 8, 8, 8, 24, 8};

    GLView::setGLContextAttrs(glContextAttrs);
}

bool AppDelegate::applicationDidFinishLaunching()
{
    // set default FPS
    Director::getInstance()->setAnimationInterval(1.0 / 60.0f);
   
    // register lua module
    auto engine = LuaEngine::getInstance();
    ScriptEngineManager::getInstance()->setScriptEngine(engine);
    lua_State* L = engine->getLuaStack()->getLuaState();
    lua_module_register(L);

    // If you want to use Quick-Cocos2d-X, please uncomment below code
    // register_all_quick_manual(L);

    LuaStack* stack = engine->getLuaStack();
    stack->setXXTEAKeyAndSign("2dxLua", strlen("2dxLua"), "XXTEA", strlen("XXTEA"));
    
    //register custom function
    //LuaStack* stack = engine->getLuaStack();
    //register_custom_function(stack->getLuaState());

	if (L)
	{
		lua_getglobal(L, "_G");
		register_all_cocos2dx_lilith(L);
		register_all_cocos2dx_lilith_manual(L);
		register_global_interface(L);
        luaopen_struct(L);//add
        luaopen_bit(L);//add
        luaopen_lpeg(L);//add
        luaopen_mycrypto(L);//add
		lua_settop(L, 0);
	}
    
#if (COCOS2D_DEBUG > 0) && (CC_CODE_IDE_DEBUG_SUPPORT > 0)
    // NOTE:Please don't remove this call if you want to debug with Cocos Code IDE
    RuntimeEngine::getInstance()->start();
    cocos2d::log("iShow!");
#else
    if (engine->executeScriptFile("src/main.lua"))
    {
        return false;
    }
#endif
    
    return true;
}

void register_global_interface(lua_State* L)
{
    lua_pushcfunction(L , lua_add_notification);
    lua_setglobal(L , "EDAddNotification");
    lua_pushcfunction(L , lua_cancel_notification);
    lua_setglobal(L , "EDCancelNotification");
}

static int lua_add_notification(lua_State* L)
{
    const char* key = luaL_checkstring(L , 1);
    const char* text = luaL_checkstring(L , 2);
    const char* tag = luaL_checkstring(L , 3);
    long date = luaL_checklong(L , 4);
    
#if CC_TARGET_PLATFORM == CC_PLATFORM_IOS
    NativeTools::AddNotification(key , text , tag , date);
#endif
    
    return 0;
}

static int lua_cancel_notification(lua_State* L)
{
    const char* key = luaL_checkstring(L , 1);
    
#if CC_TARGET_PLATFORM == CC_PLATFORM_IOS
    NativeTools::CancelNotification(key);
#endif
    
    return 0;
}


// This function will be called when the app is inactive. When comes a phone call,it's be invoked too
void AppDelegate::applicationDidEnterBackground()
{
    Director::getInstance()->stopAnimation();

    SimpleAudioEngine::getInstance()->pauseBackgroundMusic();

	Director::getInstance()->pause();
}

// this function will be called when the app is active again
void AppDelegate::applicationWillEnterForeground()
{
    Director::getInstance()->startAnimation();

    SimpleAudioEngine::getInstance()->resumeBackgroundMusic();

	Director::getInstance()->resume();
}
