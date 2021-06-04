// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//Shared.AS3.StyleSheet

package Shared.AS3
{
    import flash.utils.getQualifiedClassName;
    import flash.utils.describeType;

    public class StyleSheet 
    {


        private static function aggregateSheetProperties(_arg_1:Object, _arg_2:Object, _arg_3:Object, _arg_4:Boolean=false):*
        {
            var _local_8:XML;
            var _local_9:String;
            var _local_10:String;
            var _local_11:String;
            var _local_5:String = getQualifiedClassName(_arg_2);
            var _local_6:XML = describeType(_arg_2);
            var _local_7:XMLList = _local_6..variable;
            for each (_local_8 in _local_7)
            {
                _local_9 = _local_8.@name;
                _local_10 = typeof(_arg_2[_local_9]);
                _local_11 = typeof(_arg_1[_local_9]);
                if (_arg_1.hasOwnProperty(_local_9))
                {
                    if (_local_10 == "function")
                    {
                        throw (new Error((("StyleSheet:aggregateSheetProperties - Stylesheet " + _local_5) + " contains function parameters (prohibited).")));
                    };
                    if (_local_10 == typeof(_arg_1[_local_9]))
                    {
                        _arg_3[_local_9] = _arg_2[_local_9];
                    }
                    else
                    {
                        if (!_arg_4)
                        {
                            trace(((((((("WARNING: StyleSheet:aggregateSheetProperties - Stylesheet " + _local_5) + " : Type mismatch between source (") + _local_10) + ") and target (") + _local_11) + ") for property ") + _local_9));
                        };
                    };
                }
                else
                {
                    if (!_arg_4)
                    {
                        trace((((("WARNING: SheetSheet:aggregateSheetProperties - Stylesheet " + _local_5) + " contains property ") + _local_9) + " which does not exist on target object."));
                    };
                };
            };
        }

        public static function apply(_arg_1:Object, _arg_2:Boolean=false, ... _args):*
        {
            var _local_6:String;
            var _local_4:Object = new Object();
            var _local_5:* = 0;
            while (_local_5 < _args.length)
            {
                aggregateSheetProperties(_arg_1, _args[_local_5], _local_4, _arg_2);
                _local_5++;
            };
            for (_local_6 in _local_4)
            {
                _arg_1[_local_6] = _local_4[_local_6];
            };
        }


    }
}//package Shared.AS3

