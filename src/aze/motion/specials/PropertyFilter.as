// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//aze.motion.specials.PropertyFilter

package aze.motion.specials
{
    import flash.filters.BitmapFilter;
    import flash.display.DisplayObject;
    import aze.motion.EazeTween;
    import flash.filters.BlurFilter;
    import flash.filters.GlowFilter;
    import flash.filters.DropShadowFilter;

    public class PropertyFilter extends EazeSpecial 
    {

        public static var fixedProp:Object = {
            "quality":true,
            "color":true
        };

        private var properties:Array;
        private var fvalue:BitmapFilter;
        private var start:Object;
        private var delta:Object;
        private var fColor:Object;
        private var startColor:Object;
        private var deltaColor:Object;
        private var removeWhenComplete:Boolean;
        private var isNewFilter:Boolean;
        private var filterClass:Class;

        public function PropertyFilter(_arg_1:Object, _arg_2:*, _arg_3:*, _arg_4:EazeSpecial)
        {
            var _local_7:String;
            var _local_8:*;
            super(_arg_1, _arg_2, _arg_3, _arg_4);
            this.filterClass = this.resolveFilterClass(_arg_2);
            var _local_5:DisplayObject = DisplayObject(_arg_1);
            var _local_6:BitmapFilter = PropertyFilter.getCurrentFilter(this.filterClass, _local_5, false);
            if (!_local_6)
            {
                this.isNewFilter = true;
                _local_6 = new this.filterClass();
            };
            this.properties = [];
            this.fvalue = _local_6.clone();
            for (_local_7 in _arg_3)
            {
                _local_8 = _arg_3[_local_7];
                if (_local_7 == "remove")
                {
                    this.removeWhenComplete = _local_8;
                }
                else
                {
                    if (((_local_7 == "color") && (!(this.isNewFilter))))
                    {
                        this.fColor = {
                            "r":((_local_8 >> 16) & 0xFF),
                            "g":((_local_8 >> 8) & 0xFF),
                            "b":(_local_8 & 0xFF)
                        };
                    };
                    this.fvalue[_local_7] = _local_8;
                    this.properties.push(_local_7);
                };
            };
        }

        public static function register():void
        {
            EazeTween.specialProperties["blurFilter"] = PropertyFilter;
            EazeTween.specialProperties["glowFilter"] = PropertyFilter;
            EazeTween.specialProperties["dropShadowFilter"] = PropertyFilter;
            EazeTween.specialProperties[BlurFilter] = PropertyFilter;
            EazeTween.specialProperties[GlowFilter] = PropertyFilter;
            EazeTween.specialProperties[DropShadowFilter] = PropertyFilter;
        }

        public static function getCurrentFilter(_arg_1:Class, _arg_2:DisplayObject, _arg_3:Boolean):BitmapFilter
        {
            var _local_4:int;
            var _local_5:Array;
            var _local_6:BitmapFilter;
            if (_arg_2.filters)
            {
                _local_5 = _arg_2.filters;
                _local_4 = 0;
                while (_local_4 < _local_5.length)
                {
                    if ((_local_5[_local_4] is _arg_1))
                    {
                        if (_arg_3)
                        {
                            _local_6 = _local_5.splice(_local_4, 1)[0];
                            _arg_2.filters = _local_5;
                            return (_local_6);
                        };
                        return (_local_5[_local_4]);
                    };
                    _local_4++;
                };
            };
            return (null);
        }

        public static function addFilter(_arg_1:DisplayObject, _arg_2:BitmapFilter):void
        {
            var _local_3:Array = ((_arg_1.filters) || ([]));
            _local_3.push(_arg_2);
            _arg_1.filters = _local_3;
        }


        private function resolveFilterClass(_arg_1:*):Class
        {
            if ((_arg_1 is Class))
            {
                return (_arg_1);
            };
            switch (_arg_1)
            {
                case "blurFilter":
                    return (BlurFilter);
                case "glowFilter":
                    return (GlowFilter);
                case "dropShadowFilter":
                    return (DropShadowFilter);
            };
            return (BlurFilter);
        }

        override public function init(_arg_1:Boolean):void
        {
            var _local_4:BitmapFilter;
            var _local_5:BitmapFilter;
            var _local_6:Object;
            var _local_7:Object;
            var _local_8:*;
            var _local_10:String;
            var _local_2:DisplayObject = DisplayObject(target);
            var _local_3:BitmapFilter = PropertyFilter.getCurrentFilter(this.filterClass, _local_2, true);
            if (!_local_3)
            {
                _local_3 = new this.filterClass();
            };
            if (this.fColor)
            {
                _local_8 = _local_3["color"];
                _local_6 = {
                    "r":((_local_8 >> 16) & 0xFF),
                    "g":((_local_8 >> 8) & 0xFF),
                    "b":(_local_8 & 0xFF)
                };
            };
            if (_arg_1)
            {
                _local_4 = this.fvalue;
                _local_5 = _local_3;
                this.startColor = this.fColor;
                _local_7 = _local_6;
            }
            else
            {
                _local_4 = _local_3;
                _local_5 = this.fvalue;
                this.startColor = _local_6;
                _local_7 = this.fColor;
            };
            this.start = {};
            this.delta = {};
            var _local_9:int;
            for (;_local_9 < this.properties.length;_local_9++)
            {
                _local_10 = this.properties[_local_9];
                _local_8 = this.fvalue[_local_10];
                if ((_local_8 is Boolean))
                {
                    _local_3[_local_10] = _local_8;
                    this.properties[_local_9] = null;
                }
                else
                {
                    if (this.isNewFilter)
                    {
                        if ((_local_10 in fixedProp))
                        {
                            _local_3[_local_10] = _local_8;
                            this.properties[_local_9] = null;
                            continue;
                        };
                        _local_3[_local_10] = 0;
                    }
                    else
                    {
                        if (((_local_10 == "color") && (this.fColor)))
                        {
                            this.deltaColor = {
                                "r":(_local_7.r - this.startColor.r),
                                "g":(_local_7.g - this.startColor.g),
                                "b":(_local_7.b - this.startColor.b)
                            };
                            this.properties[_local_9] = null;
                            continue;
                        };
                    };
                    this.start[_local_10] = _local_4[_local_10];
                    this.delta[_local_10] = (_local_5[_local_10] - this.start[_local_10]);
                };
            };
            this.fvalue = null;
            this.fColor = null;
            PropertyFilter.addFilter(_local_2, _local_4);
        }

        override public function update(_arg_1:Number, _arg_2:Boolean):void
        {
            var _local_6:String;
            var _local_3:DisplayObject = DisplayObject(target);
            var _local_4:BitmapFilter = PropertyFilter.getCurrentFilter(this.filterClass, _local_3, true);
            if (((this.removeWhenComplete) && (_arg_2)))
            {
                _local_3.filters = _local_3.filters;
                return;
            };
            if (!_local_4)
            {
                _local_4 = new this.filterClass();
            };
            var _local_5:int;
            while (_local_5 < this.properties.length)
            {
                _local_6 = this.properties[_local_5];
                if (_local_6)
                {
                    _local_4[_local_6] = (this.start[_local_6] + (_arg_1 * this.delta[_local_6]));
                };
                _local_5++;
            };
            if (this.startColor)
            {
                _local_4["color"] = ((((this.startColor.r + (_arg_1 * this.deltaColor.r)) << 16) | ((this.startColor.g + (_arg_1 * this.deltaColor.g)) << 8)) | (this.startColor.b + (_arg_1 * this.deltaColor.b)));
            };
            PropertyFilter.addFilter(_local_3, _local_4);
        }

        override public function dispose():void
        {
            this.filterClass = null;
            this.start = (this.delta = null);
            this.startColor = (this.deltaColor = null);
            this.fvalue = null;
            this.fColor = null;
            this.properties = null;
            super.dispose();
        }


    }
}//package aze.motion.specials

