// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//aze.motion.specials.PropertyBezier

package aze.motion.specials
{
    import aze.motion.EazeTween;

    public class PropertyBezier extends EazeSpecial 
    {

        private var fvalue:Array;
        private var through:Boolean;
        private var length:int;
        private var segments:Array;

        public function PropertyBezier(_arg_1:Object, _arg_2:*, _arg_3:*, _arg_4:EazeSpecial)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
            this.fvalue = _arg_3;
            if ((this.fvalue[0] is Array))
            {
                this.through = true;
                this.fvalue = this.fvalue[0];
            };
        }

        public static function register():void
        {
            EazeTween.specialProperties["__bezier"] = PropertyBezier;
        }


        override public function init(_arg_1:Boolean):void
        {
            var _local_3:Number;
            var _local_4:Number;
            var _local_2:Number = target[property];
            this.fvalue = [_local_2].concat(this.fvalue);
            if (_arg_1)
            {
                this.fvalue.reverse();
            };
            var _local_5:Number = this.fvalue[0];
            var _local_6:int = (this.fvalue.length - 1);
            var _local_7:int = 1;
            var _local_8:Number = NaN;
            this.segments = [];
            this.length = 0;
            while (_local_7 < _local_6)
            {
                _local_3 = _local_5;
                _local_4 = this.fvalue[_local_7];
                _local_5 = this.fvalue[++_local_7];
                if (this.through)
                {
                    if (!this.length)
                    {
                        _local_8 = ((_local_5 - _local_3) / 4);
                        var _local_9:* = this.length++;
                        this.segments[_local_9] = new BezierSegment(_local_3, (_local_4 - _local_8), _local_4);
                    };
                    _local_9 = this.length++;
                    this.segments[_local_9] = new BezierSegment(_local_4, (_local_4 + _local_8), _local_5);
                    _local_8 = (_local_5 - (_local_4 + _local_8));
                }
                else
                {
                    if (_local_7 != _local_6)
                    {
                        _local_5 = ((_local_4 + _local_5) / 2);
                    };
                    _local_9 = this.length++;
                    this.segments[_local_9] = new BezierSegment(_local_3, _local_4, _local_5);
                };
            };
            this.fvalue = null;
            if (_arg_1)
            {
                this.update(0, false);
            };
        }

        override public function update(_arg_1:Number, _arg_2:Boolean):void
        {
            var _local_3:BezierSegment;
            var _local_5:int;
            var _local_4:int = (this.length - 1);
            if (_arg_2)
            {
                _local_3 = this.segments[_local_4];
                target[property] = (_local_3.p0 + _local_3.d2);
            }
            else
            {
                if (this.length == 1)
                {
                    _local_3 = this.segments[0];
                    target[property] = _local_3.calculate(_arg_1);
                }
                else
                {
                    _local_5 = ((_arg_1 * this.length) >> 0);
                    if (_local_5 < 0)
                    {
                        _local_5 = 0;
                    }
                    else
                    {
                        if (_local_5 > _local_4)
                        {
                            _local_5 = _local_4;
                        };
                    };
                    _local_3 = this.segments[_local_5];
                    _arg_1 = (this.length * (_arg_1 - (_local_5 / this.length)));
                    target[property] = _local_3.calculate(_arg_1);
                };
            };
        }

        override public function dispose():void
        {
            this.fvalue = null;
            this.segments = null;
            super.dispose();
        }


    }
}//package aze.motion.specials

class BezierSegment 
{

    public var p0:Number;
    public var d1:Number;
    public var d2:Number;

    public function BezierSegment(_arg_1:Number, _arg_2:Number, _arg_3:Number)
    {
        this.p0 = _arg_1;
        this.d1 = (_arg_2 - _arg_1);
        this.d2 = (_arg_3 - _arg_1);
    }

    public function calculate(_arg_1:Number):Number
    {
        return (this.p0 + (_arg_1 * (((2 * (1 - _arg_1)) * this.d1) + (_arg_1 * this.d2))));
    }


}


