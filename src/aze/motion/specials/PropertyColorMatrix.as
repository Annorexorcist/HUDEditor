// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//aze.motion.specials.PropertyColorMatrix

package aze.motion.specials
{
    import aze.motion.EazeTween;
    import flash.filters.ColorMatrixFilter;
    import flash.display.DisplayObject;

    public class PropertyColorMatrix extends EazeSpecial 
    {

        private var removeWhenComplete:Boolean;
        private var colorMatrix:ColorMatrix;
        private var delta:Array;
        private var start:Array;
        private var temp:Array;

        public function PropertyColorMatrix(_arg_1:Object, _arg_2:*, _arg_3:*, _arg_4:EazeSpecial)
        {
            var _local_5:uint;
            super(_arg_1, _arg_2, _arg_3, _arg_4);
            this.colorMatrix = new ColorMatrix();
            if (_arg_3.brightness)
            {
                this.colorMatrix.adjustBrightness((_arg_3.brightness * 0xFF));
            };
            if (_arg_3.contrast)
            {
                this.colorMatrix.adjustContrast(_arg_3.contrast);
            };
            if (_arg_3.hue)
            {
                this.colorMatrix.adjustHue(_arg_3.hue);
            };
            if (_arg_3.saturation)
            {
                this.colorMatrix.adjustSaturation((_arg_3.saturation + 1));
            };
            if (_arg_3.colorize)
            {
                _local_5 = (("tint" in _arg_3) ? uint(_arg_3.tint) : 0xFFFFFF);
                this.colorMatrix.colorize(_local_5, _arg_3.colorize);
            };
            this.removeWhenComplete = _arg_3.remove;
        }

        public static function register():void
        {
            EazeTween.specialProperties["colorMatrixFilter"] = PropertyColorMatrix;
            EazeTween.specialProperties[ColorMatrixFilter] = PropertyColorMatrix;
        }


        override public function init(_arg_1:Boolean):void
        {
            var _local_4:Array;
            var _local_5:Array;
            var _local_2:DisplayObject = DisplayObject(target);
            var _local_3:ColorMatrixFilter = (PropertyFilter.getCurrentFilter(ColorMatrixFilter, _local_2, true) as ColorMatrixFilter);
            if (!_local_3)
            {
                _local_3 = new ColorMatrixFilter();
            };
            if (_arg_1)
            {
                _local_5 = _local_3.matrix;
                _local_4 = this.colorMatrix.matrix;
            }
            else
            {
                _local_5 = this.colorMatrix.matrix;
                _local_4 = _local_3.matrix;
            };
            this.delta = new Array(20);
            var _local_6:int;
            while (_local_6 < 20)
            {
                this.delta[_local_6] = (_local_5[_local_6] - _local_4[_local_6]);
                _local_6++;
            };
            this.start = _local_4;
            this.temp = new Array(20);
            PropertyFilter.addFilter(_local_2, new ColorMatrixFilter(_local_4));
        }

        override public function update(_arg_1:Number, _arg_2:Boolean):void
        {
            var _local_3:DisplayObject = DisplayObject(target);
            (PropertyFilter.getCurrentFilter(ColorMatrixFilter, _local_3, true) as ColorMatrixFilter);
            if (((this.removeWhenComplete) && (_arg_2)))
            {
                _local_3.filters = _local_3.filters;
                return;
            };
            var _local_4:int;
            while (_local_4 < 20)
            {
                this.temp[_local_4] = (this.start[_local_4] + (_arg_1 * this.delta[_local_4]));
                _local_4++;
            };
            PropertyFilter.addFilter(_local_3, new ColorMatrixFilter(this.temp));
        }

        override public function dispose():void
        {
            this.colorMatrix = null;
            this.delta = null;
            this.start = null;
            this.temp = null;
            super.dispose();
        }


    }
}//package aze.motion.specials

import flash.filters.ColorMatrixFilter;

class ColorMatrix 
{

    /*private*/ static const LUMA_R:Number = 0.212671;
    /*private*/ static const LUMA_G:Number = 0.71516;
    /*private*/ static const LUMA_B:Number = 0.072169;
    /*private*/ static const LUMA_R2:Number = 0.3086;
    /*private*/ static const LUMA_G2:Number = 0.6094;
    /*private*/ static const LUMA_B2:Number = 0.082;
    /*private*/ static const ONETHIRD:Number = (1 / 3);//0.333333333333333
    /*private*/ static const IDENTITY:Array = [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0];
    /*private*/ static const RAD:Number = (Math.PI / 180);//0.0174532925199433

    public var matrix:Array;

    public function ColorMatrix(_arg_1:Object=null)
    {
        if ((_arg_1 is ColorMatrix))
        {
            this.matrix = _arg_1.matrix.concat();
        }
        else
        {
            if ((_arg_1 is Array))
            {
                this.matrix = _arg_1.concat();
            }
            else
            {
                this.reset();
            };
        };
    }

    public function reset():void
    {
        this.matrix = IDENTITY.concat();
    }

    public function adjustSaturation(_arg_1:Number):void
    {
        var _local_2:Number;
        var _local_3:Number;
        var _local_4:Number;
        var _local_5:Number;
        _local_2 = (1 - _arg_1);
        _local_3 = (_local_2 * LUMA_R);
        _local_4 = (_local_2 * LUMA_G);
        _local_5 = (_local_2 * LUMA_B);
        this.concat([(_local_3 + _arg_1), _local_4, _local_5, 0, 0, _local_3, (_local_4 + _arg_1), _local_5, 0, 0, _local_3, _local_4, (_local_5 + _arg_1), 0, 0, 0, 0, 0, 1, 0]);
    }

    public function adjustContrast(_arg_1:Number, _arg_2:Number=NaN, _arg_3:Number=NaN):void
    {
        if (isNaN(_arg_2))
        {
            _arg_2 = _arg_1;
        };
        if (isNaN(_arg_3))
        {
            _arg_3 = _arg_1;
        };
        _arg_1 = (_arg_1 + 1);
        _arg_2 = (_arg_2 + 1);
        _arg_3 = (_arg_3 + 1);
        this.concat([_arg_1, 0, 0, 0, (128 * (1 - _arg_1)), 0, _arg_2, 0, 0, (128 * (1 - _arg_2)), 0, 0, _arg_3, 0, (128 * (1 - _arg_3)), 0, 0, 0, 1, 0]);
    }

    public function adjustBrightness(_arg_1:Number, _arg_2:Number=NaN, _arg_3:Number=NaN):void
    {
        if (isNaN(_arg_2))
        {
            _arg_2 = _arg_1;
        };
        if (isNaN(_arg_3))
        {
            _arg_3 = _arg_1;
        };
        this.concat([1, 0, 0, 0, _arg_1, 0, 1, 0, 0, _arg_2, 0, 0, 1, 0, _arg_3, 0, 0, 0, 1, 0]);
    }

    public function adjustHue(_arg_1:Number):void
    {
        _arg_1 = (_arg_1 * RAD);
        var _local_2:Number = Math.cos(_arg_1);
        var _local_3:Number = Math.sin(_arg_1);
        this.concat([((LUMA_R + (_local_2 * (1 - LUMA_R))) + (_local_3 * -(LUMA_R))), ((LUMA_G + (_local_2 * -(LUMA_G))) + (_local_3 * -(LUMA_G))), ((LUMA_B + (_local_2 * -(LUMA_B))) + (_local_3 * (1 - LUMA_B))), 0, 0, ((LUMA_R + (_local_2 * -(LUMA_R))) + (_local_3 * 0.143)), ((LUMA_G + (_local_2 * (1 - LUMA_G))) + (_local_3 * 0.14)), ((LUMA_B + (_local_2 * -(LUMA_B))) + (_local_3 * -0.283)), 0, 0, ((LUMA_R + (_local_2 * -(LUMA_R))) + (_local_3 * -(1 - LUMA_R))), ((LUMA_G + (_local_2 * -(LUMA_G))) + (_local_3 * LUMA_G)), ((LUMA_B + (_local_2 * (1 - LUMA_B))) + (_local_3 * LUMA_B)), 0, 0, 0, 0, 0, 1, 0]);
    }

    public function colorize(_arg_1:int, _arg_2:Number=1):void
    {
        var _local_3:Number;
        var _local_4:Number;
        var _local_5:Number;
        var _local_6:Number;
        _local_3 = (((_arg_1 >> 16) & 0xFF) / 0xFF);
        _local_4 = (((_arg_1 >> 8) & 0xFF) / 0xFF);
        _local_5 = ((_arg_1 & 0xFF) / 0xFF);
        _local_6 = (1 - _arg_2);
        this.concat([(_local_6 + ((_arg_2 * _local_3) * LUMA_R)), ((_arg_2 * _local_3) * LUMA_G), ((_arg_2 * _local_3) * LUMA_B), 0, 0, ((_arg_2 * _local_4) * LUMA_R), (_local_6 + ((_arg_2 * _local_4) * LUMA_G)), ((_arg_2 * _local_4) * LUMA_B), 0, 0, ((_arg_2 * _local_5) * LUMA_R), ((_arg_2 * _local_5) * LUMA_G), (_local_6 + ((_arg_2 * _local_5) * LUMA_B)), 0, 0, 0, 0, 0, 1, 0]);
    }

    public function get filter():ColorMatrixFilter
    {
        return (new ColorMatrixFilter(this.matrix));
    }

    public function concat(_arg_1:Array):void
    {
        var _local_4:int;
        var _local_5:int;
        var _local_2:Array = [];
        var _local_3:int;
        _local_5 = 0;
        while (_local_5 < 4)
        {
            _local_4 = 0;
            while (_local_4 < 5)
            {
                _local_2[int((_local_3 + _local_4))] = (((((Number(_arg_1[_local_3]) * Number(this.matrix[_local_4])) + (Number(_arg_1[int((_local_3 + 1))]) * Number(this.matrix[int((_local_4 + 5))]))) + (Number(_arg_1[int((_local_3 + 2))]) * Number(this.matrix[int((_local_4 + 10))]))) + (Number(_arg_1[int((_local_3 + 3))]) * Number(this.matrix[int((_local_4 + 15))]))) + ((_local_4 == 4) ? Number(_arg_1[int((_local_3 + 4))]) : 0));
                _local_4++;
            };
            _local_3 = (_local_3 + 5);
            _local_5++;
        };
        this.matrix = _local_2;
    }


}


