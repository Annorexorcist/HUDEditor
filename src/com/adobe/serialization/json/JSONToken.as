// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//com.adobe.serialization.json.JSONToken

package com.adobe.serialization.json
{
    public final class JSONToken 
    {

        internal static const token:JSONToken = new (JSONToken)();

        public var type:int;
        public var value:Object;

        public function JSONToken(_arg_1:int=-1, _arg_2:Object=null)
        {
            this.type = _arg_1;
            this.value = _arg_2;
        }

        internal static function create(_arg_1:int=-1, _arg_2:Object=null):JSONToken
        {
            token.type = _arg_1;
            token.value = _arg_2;
            return (token);
        }


    }
}//package com.adobe.serialization.json

