// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//aze.motion.specials.PropertyTint

package aze.motion.specials
{
    import flash.geom.ColorTransform;
    import aze.motion.EazeTween;

    public class PropertyTint extends EazeSpecial 
    {

        private var start:ColorTransform;
        private var tvalue:ColorTransform;
        private var delta:ColorTransform;

        public function PropertyTint(_arg_1:Object, _arg_2:*, _arg_3:*, _arg_4:EazeSpecial)
        {
            var _local_5:Number;
            var _local_6:Number;
            var _local_7:uint;
            var _local_8:Array;
            super(_arg_1, _arg_2, _arg_3, _arg_4);
            if (_arg_3 === null)
            {
                this.tvalue = new ColorTransform();
            }
            else
            {
                _local_5 = 1;
                _local_6 = 0;
                _local_7 = 0;
                _local_8 = ((_arg_3 is Array) ? _arg_3 : [_arg_3]);
                if (_local_8[0] === null)
                {
                    _local_5 = 0;
                    _local_6 = 1;
                }
                else
                {
                    if (_local_8.length > 1)
                    {
                        _local_5 = _local_8[1];
                    };
                    if (_local_8.length > 2)
                    {
                        _local_6 = _local_8[2];
                    }
                    else
                    {
                        _local_6 = (1 - _local_5);
                    };
                    _local_7 = _local_8[0];
                };
                this.tvalue = new ColorTransform();
                this.tvalue.redMultiplier = _local_6;
                this.tvalue.greenMultiplier = _local_6;
                this.tvalue.blueMultiplier = _local_6;
                this.tvalue.redOffset = (_local_5 * ((_local_7 >> 16) & 0xFF));
                this.tvalue.greenOffset = (_local_5 * ((_local_7 >> 8) & 0xFF));
                this.tvalue.blueOffset = (_local_5 * (_local_7 & 0xFF));
            };
        }

        public static function register():void
        {
            EazeTween.specialProperties.tint = PropertyTint;
        }


        override public function init(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
                this.start = this.tvalue;
                this.tvalue = target.transform.colorTransform;
            }
            else
            {
                this.start = target.transform.colorTransform;
            };
            this.delta = new ColorTransform((this.tvalue.redMultiplier - this.start.redMultiplier), (this.tvalue.greenMultiplier - this.start.greenMultiplier), (this.tvalue.blueMultiplier - this.start.blueMultiplier), 0, (this.tvalue.redOffset - this.start.redOffset), (this.tvalue.greenOffset - this.start.greenOffset), (this.tvalue.blueOffset - this.start.blueOffset));
            this.tvalue = null;
            if (_arg_1)
            {
                this.update(0, false);
            };
        }

        override public function update(_arg_1:Number, _arg_2:Boolean):void
        {
            var _local_3:ColorTransform = target.transform.colorTransform;
            _local_3.redMultiplier = (this.start.redMultiplier + (this.delta.redMultiplier * _arg_1));
            _local_3.greenMultiplier = (this.start.greenMultiplier + (this.delta.greenMultiplier * _arg_1));
            _local_3.blueMultiplier = (this.start.blueMultiplier + (this.delta.blueMultiplier * _arg_1));
            _local_3.redOffset = (this.start.redOffset + (this.delta.redOffset * _arg_1));
            _local_3.greenOffset = (this.start.greenOffset + (this.delta.greenOffset * _arg_1));
            _local_3.blueOffset = (this.start.blueOffset + (this.delta.blueOffset * _arg_1));
            target.transform.colorTransform = _local_3;
        }

        override public function dispose():void
        {
            this.start = (this.delta = null);
            this.tvalue = null;
            super.dispose();
        }


    }
}//package aze.motion.specials

