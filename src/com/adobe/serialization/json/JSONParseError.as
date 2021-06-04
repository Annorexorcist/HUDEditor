// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//com.adobe.serialization.json.JSONParseError

package com.adobe.serialization.json
{
    public class JSONParseError extends Error 
    {

        private var _location:int;
        private var _text:String;

        public function JSONParseError(_arg_1:String="", _arg_2:int=0, _arg_3:String="")
        {
            super(_arg_1);
            name = "JSONParseError";
            this._location = _arg_2;
            this._text = _arg_3;
        }

        public function get location():int
        {
            return (this._location);
        }

        public function get text():String
        {
            return (this._text);
        }


    }
}//package com.adobe.serialization.json

