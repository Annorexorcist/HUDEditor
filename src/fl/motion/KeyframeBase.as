// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//fl.motion.KeyframeBase

package fl.motion
{
    import flash.geom.Matrix;
    import flash.utils.Dictionary;
    import flash.filters.ColorMatrixFilter;
    import flash.utils.*;

    public class KeyframeBase 
    {

        private var _index:int = -1;
        public var x:Number = NaN;
        public var y:Number = NaN;
        public var scaleX:Number = NaN;
        public var scaleY:Number = NaN;
        public var skewX:Number = NaN;
        public var skewY:Number = NaN;
        public var rotationConcat:Number = NaN;
        public var useRotationConcat:Boolean = false;
        public var filters:Array;
        public var color:Color;
        public var label:String = "";
        public var loop:String;
        public var firstFrame:String;
        public var cacheAsBitmap:Boolean = false;
        public var opaqueBackground:Object = null;
        public var blendMode:String = "normal";
        public var visible:Boolean = true;
        public var rotateDirection:String = "auto";
        public var rotateTimes:uint = 0;
        public var orientToPath:Boolean = false;
        public var blank:Boolean = false;
        public var matrix3D:Object = null;
        public var matrix:Matrix = null;
        public var z:Number = NaN;
        public var rotationX:Number = NaN;
        public var rotationY:Number = NaN;
        public var adjustColorObjects:Dictionary = null;

        public function KeyframeBase(_arg_1:XML=null)
        {
            this.filters = [];
            this.adjustColorObjects = new Dictionary();
        }

        public function get index():int
        {
            return (this._index);
        }

        public function set index(_arg_1:int):void
        {
            this._index = ((_arg_1 < 0) ? 0 : _arg_1);
            if (this._index == 0)
            {
                this.setDefaults();
            };
        }

        public function get rotation():Number
        {
            return (this.skewY);
        }

        public function set rotation(_arg_1:Number):void
        {
            if (((isNaN(this.skewX)) || (isNaN(this.skewY))))
            {
                this.skewX = _arg_1;
            }
            else
            {
                this.skewX = (this.skewX + (_arg_1 - this.skewY));
            };
            this.skewY = _arg_1;
        }

        private function setDefaults():void
        {
            if (isNaN(this.x))
            {
                this.x = 0;
            };
            if (isNaN(this.y))
            {
                this.y = 0;
            };
            if (isNaN(this.z))
            {
                this.z = 0;
            };
            if (isNaN(this.scaleX))
            {
                this.scaleX = 1;
            };
            if (isNaN(this.scaleY))
            {
                this.scaleY = 1;
            };
            if (isNaN(this.skewX))
            {
                this.skewX = 0;
            };
            if (isNaN(this.skewY))
            {
                this.skewY = 0;
            };
            if (isNaN(this.rotationConcat))
            {
                this.rotationConcat = 0;
            };
            if (!this.color)
            {
                this.color = new Color();
            };
        }

        public function getValue(_arg_1:String):Number
        {
            return (Number(this[_arg_1]));
        }

        public function setValue(_arg_1:String, _arg_2:Number):void
        {
            this[_arg_1] = _arg_2;
        }

        protected function hasTween():Boolean
        {
            return (false);
        }

        public function affectsTweenable(_arg_1:String=""):Boolean
        {
            return ((((((((!(_arg_1)) || (!(isNaN(this[_arg_1])))) || ((_arg_1 == "color") && (this.color))) || ((_arg_1 == "filters") && (this.filters.length))) || ((_arg_1 == "matrix3D") && (this.matrix3D))) || ((_arg_1 == "matrix") && (this.matrix))) || (this.blank)) || (this.hasTween()));
        }

        public function setAdjustColorProperty(_arg_1:int, _arg_2:String, _arg_3:*):void
        {
            var _local_5:ColorMatrixFilter;
            var _local_6:Array;
            if (_arg_1 >= this.filters.length)
            {
                return;
            };
            var _local_4:AdjustColor = this.adjustColorObjects[_arg_1];
            if (_local_4 == null)
            {
                _local_4 = new AdjustColor();
                this.adjustColorObjects[_arg_1] = _local_4;
            };
            switch (_arg_2)
            {
                case "adjustColorBrightness":
                    _local_4.brightness = _arg_3;
                    break;
                case "adjustColorContrast":
                    _local_4.contrast = _arg_3;
                    break;
                case "adjustColorSaturation":
                    _local_4.saturation = _arg_3;
                    break;
                case "adjustColorHue":
                    _local_4.hue = _arg_3;
                    break;
            };
            if (_local_4.AllValuesAreSet())
            {
                _local_5 = (this.filters[_arg_1] as ColorMatrixFilter);
                if (_local_5)
                {
                    _local_6 = _local_4.CalculateFinalFlatArray();
                    if (_local_6)
                    {
                        _local_5.matrix = _local_6;
                    };
                };
            };
        }

        public function get tweensLength():int
        {
            return (0);
        }


    }
}//package fl.motion

