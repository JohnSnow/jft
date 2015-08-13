//
//  NativeTools.h
//  dgame
//
//  Created by isaacwang on 14-3-19.
//
//

class NativeTools
{
public:
    static void OpenURL(const char* addr);
    static void AddNotification(const char* key , const char* text , const char* tag , long firstDate);
    static void CancelNotification(const char* key);
    
    static void setEVCTextConfig(const char* titleText , const char* buttonText1 , const char* buttonText2 , const char* buttonText3);
    static void pushEvaluateView(const char* appid);
    static double absoluteTimeGetCurrent();
};