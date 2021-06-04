// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//fl.motion.MotionBase

package fl.motion
{
    import flash.geom.Point;
    import flash.geom.Matrix;
    import flash.geom.ColorTransform;
    import flash.filters.BitmapFilter;
    import flash.utils.getDefinitionByName;
    import flash.filters.*;
    import flash.utils.*;

    use namespace motion_internal;

    public class MotionBase 
    {

        public var keyframes:Array;
        private var _spanStart:int;
        private var _transformationPoint:Point;
        private var _transformationPointZ:int;
        private var _initialPosition:Array;
        private var _initialMatrix:Matrix;
        private var _duration:int = 0;
        private var _is3D:Boolean = false;
        private var _overrideScale:Boolean;
        private var _overrideSkew:Boolean;
        private var _overrideRotate:Boolean;

        public function MotionBase(_arg_1:XML=null)
        {
            var _local_2:KeyframeBase;
            super();
            this.keyframes = [];
            if (this.duration == 0)
            {
                _local_2 = this.getNewKeyframe();
                _local_2.index = 0;
                this.addKeyframe(_local_2);
            };
            this._overrideScale = false;
            this._overrideSkew = false;
            this._overrideRotate = false;
        }

        motion_internal function set spanStart(_arg_1:int):void
        {
            this._spanStart = _arg_1;
        }

        motion_internal function get spanStart():int
        {
            return (this._spanStart);
        }

        motion_internal function set transformationPoint(_arg_1:Point):void
        {
            this._transformationPoint = _arg_1;
        }

        motion_internal function get transformationPoint():Point
        {
            return (this._transformationPoint);
        }

        motion_internal function set transformationPointZ(_arg_1:int):void
        {
            this._transformationPointZ = _arg_1;
        }

        motion_internal function get transformationPointZ():int
        {
            return (this._transformationPointZ);
        }

        motion_internal function set initialPosition(_arg_1:Array):void
        {
            this._initialPosition = _arg_1;
        }

        motion_internal function get initialPosition():Array
        {
            return (this._initialPosition);
        }

        motion_internal function set initialMatrix(_arg_1:Matrix):void
        {
            this._initialMatrix = _arg_1;
        }

        motion_internal function get initialMatrix():Matrix
        {
            return (this._initialMatrix);
        }

        public function get duration():int
        {
            if (this._duration < this.keyframes.length)
            {
                this._duration = this.keyframes.length;
            };
            return (this._duration);
        }

        public function set duration(_arg_1:int):void
        {
            if (_arg_1 < this.keyframes.length)
            {
                _arg_1 = this.keyframes.length;
            };
            this._duration = _arg_1;
        }

        public function get is3D():Boolean
        {
            return (this._is3D);
        }

        public function set is3D(_arg_1:Boolean):void
        {
            this._is3D = _arg_1;
        }

        public function overrideTargetTransform(_arg_1:Boolean=true, _arg_2:Boolean=true, _arg_3:Boolean=true):void
        {
            this._overrideScale = _arg_1;
            this._overrideSkew = _arg_2;
            this._overrideRotate = _arg_3;
        }

        private function indexOutOfRange(_arg_1:int):Boolean
        {
            return (((isNaN(_arg_1)) || (_arg_1 < 0)) || (_arg_1 > (this.duration - 1)));
        }

        public function getCurrentKeyframe(_arg_1:int, _arg_2:String=""):KeyframeBase
        {
            var _local_4:KeyframeBase;
            if ((((isNaN(_arg_1)) || (_arg_1 < 0)) || (_arg_1 > (this.duration - 1))))
            {
                return (null);
            };
            var _local_3:int = _arg_1;
            while (_local_3 > 0)
            {
                _local_4 = this.keyframes[_local_3];
                if (((_local_4) && (_local_4.affectsTweenable(_arg_2))))
                {
                    return (_local_4);
                };
                _local_3--;
            };
            return (this.keyframes[0]);
        }

        public function getNextKeyframe(_arg_1:int, _arg_2:String=""):KeyframeBase
        {
            var _local_4:KeyframeBase;
            if ((((isNaN(_arg_1)) || (_arg_1 < 0)) || (_arg_1 > (this.duration - 1))))
            {
                return (null);
            };
            var _local_3:int = (_arg_1 + 1);
            while (_local_3 < this.keyframes.length)
            {
                _local_4 = this.keyframes[_local_3];
                if (((_local_4) && (_local_4.affectsTweenable(_arg_2))))
                {
                    return (_local_4);
                };
                _local_3++;
            };
            return (null);
        }

        public function setValue(_arg_1:int, _arg_2:String, _arg_3:Number):void
        {
            if (_arg_1 == 0)
            {
                return;
            };
            var _local_4:KeyframeBase = this.keyframes[_arg_1];
            if (!_local_4)
            {
                _local_4 = this.getNewKeyframe();
                _local_4.index = _arg_1;
                this.addKeyframe(_local_4);
            };
            _local_4.setValue(_arg_2, _arg_3);
        }

        public function getColorTransform(_arg_1:int):ColorTransform
        {
            var _local_2:ColorTransform;
            var _local_3:KeyframeBase = this.getCurrentKeyframe(_arg_1, "color");
            if (((!(_local_3)) || (!(_local_3.color))))
            {
                return (null);
            };
            var _local_4:ColorTransform = _local_3.color;
            var _local_5:Number = (_arg_1 - _local_3.index);
            if (_local_5 == 0)
            {
                _local_2 = _local_4;
            };
            return (_local_2);
        }

        public function getMatrix3D(_arg_1:int):Object
        {
            var _local_2:KeyframeBase = this.getCurrentKeyframe(_arg_1, "matrix3D");
            return ((_local_2) ? _local_2.matrix3D : null);
        }

        public function getMatrix(_arg_1:int):Matrix
        {
            var _local_2:KeyframeBase = this.getCurrentKeyframe(_arg_1, "matrix");
            return ((_local_2) ? _local_2.matrix : null);
        }

        public function useRotationConcat(_arg_1:int):Boolean
        {
            var _local_2:KeyframeBase = this.getCurrentKeyframe(_arg_1, "rotationConcat");
            return ((_local_2) ? _local_2.useRotationConcat : false);
        }

        public function getFilters(_arg_1:Number):Array
        {
            var _local_2:Array;
            var _local_3:KeyframeBase = this.getCurrentKeyframe(_arg_1, "filters");
            if (((!(_local_3)) || ((_local_3.filters) && (!(_local_3.filters.length)))))
            {
                return ([]);
            };
            var _local_4:Array = _local_3.filters;
            var _local_5:Number = (_arg_1 - _local_3.index);
            if (_local_5 == 0)
            {
                _local_2 = _local_4;
            };
            return (_local_2);
        }

        protected function findTweenedValue(_arg_1:Number, _arg_2:String, _arg_3:KeyframeBase, _arg_4:Number, _arg_5:Number):Number
        {
            return (NaN);
        }

        public function getValue(_arg_1:Number, _arg_2:String):Number
        {
            var _local_3:Number = NaN;
            var _local_4:KeyframeBase = this.getCurrentKeyframe(_arg_1, _arg_2);
            if (((!(_local_4)) || (_local_4.blank)))
            {
                return (NaN);
            };
            var _local_5:Number = _local_4.getValue(_arg_2);
            if (((isNaN(_local_5)) && (_local_4.index > 0)))
            {
                _local_5 = this.getValue((_local_4.index - 1), _arg_2);
            };
            if (isNaN(_local_5))
            {
                return (NaN);
            };
            var _local_6:Number = (_arg_1 - _local_4.index);
            if (_local_6 == 0)
            {
                return (_local_5);
            };
            return (this.findTweenedValue(_arg_1, _arg_2, _local_4, _local_6, _local_5));
        }

        public function addKeyframe(_arg_1:KeyframeBase):void
        {
            this.keyframes[_arg_1.index] = _arg_1;
            if (this.duration < this.keyframes.length)
            {
                this.duration = this.keyframes.length;
            };
        }

        public function addPropertyArray(_arg_1:String, _arg_2:Array, _arg_3:int=-1, _arg_4:int=-1):void
        {
            var _local_10:KeyframeBase;
            var _local_11:*;
            var _local_12:int;
            var _local_13:*;
            var _local_5:int = _arg_2.length;
            var _local_6:* = null;
            var _local_7:Boolean = true;
            var _local_8:Number = 0;
            if (_local_5 > 0)
            {
                if ((_arg_2[0] is Number))
                {
                    _local_7 = false;
                    if ((_arg_2[0] is Number))
                    {
                        _local_8 = Number(_arg_2[0]);
                    };
                };
            };
            if (this.duration < _local_5)
            {
                this.duration = _local_5;
            };
            if (((_arg_3 == -1) || (_arg_4 == -1)))
            {
                _arg_3 = 0;
                _arg_4 = this.duration;
            };
            var _local_9:int = _arg_3;
            while (_local_9 < _arg_4)
            {
                _local_10 = KeyframeBase(this.keyframes[_local_9]);
                if (_local_10 == null)
                {
                    _local_10 = this.getNewKeyframe();
                    _local_10.index = _local_9;
                    this.addKeyframe(_local_10);
                };
                if (((_local_10.filters) && (_local_10.filters.length == 0)))
                {
                    _local_10.filters = null;
                };
                _local_11 = _local_6;
                _local_12 = (_local_9 - _arg_3);
                if (_local_12 < _arg_2.length)
                {
                    if (((_arg_2[_local_12]) || (!(_local_7))))
                    {
                        _local_11 = _arg_2[_local_12];
                    };
                };
                switch (_arg_1)
                {
                    case "blendMode":
                    case "matrix3D":
                    case "matrix":
                    case "cacheAsBitmap":
                    case "opaqueBackground":
                    case "visible":
                        _local_10[_arg_1] = _local_11;
                        break;
                    case "rotationConcat":
                        _local_10.useRotationConcat = true;
                        if (((!(this._overrideRotate)) && (!(_local_7))))
                        {
                            _local_10.setValue(_arg_1, (((_local_11 - _local_8) * Math.PI) / 180));
                        }
                        else
                        {
                            _local_10.setValue(_arg_1, ((_local_11 * Math.PI) / 180));
                        };
                        break;
                    case "brightness":
                    case "tintMultiplier":
                    case "tintColor":
                    case "alphaMultiplier":
                    case "alphaOffset":
                    case "redMultiplier":
                    case "redOffset":
                    case "greenMultiplier":
                    case "greenOffset":
                    case "blueMultiplier":
                    case "blueOffset":
                        if (_local_10.color == null)
                        {
                            _local_10.color = new Color();
                        };
                        _local_10.color[_arg_1] = _local_11;
                        break;
                    case "rotationZ":
                        _local_10.useRotationConcat = true;
                        this._is3D = true;
                        if (((!(this._overrideRotate)) && (!(_local_7))))
                        {
                            _local_10.setValue("rotationConcat", (_local_11 - _local_8));
                        }
                        else
                        {
                            _local_10.setValue("rotationConcat", _local_11);
                        };
                        break;
                    case "rotationX":
                    case "rotationY":
                    case "z":
                        this._is3D = true;
                    default:
                        _local_13 = _local_11;
                        if (!_local_7)
                        {
                            switch (_arg_1)
                            {
                                case "scaleX":
                                case "scaleY":
                                    if (!this._overrideScale)
                                    {
                                        if (_local_8 == 0)
                                        {
                                            _local_13 = (_local_11 + 1);
                                        }
                                        else
                                        {
                                            _local_13 = (_local_11 / _local_8);
                                        };
                                    };
                                    break;
                                case "skewX":
                                case "skewY":
                                    if (!this._overrideSkew)
                                    {
                                        _local_13 = (_local_11 - _local_8);
                                    };
                                    break;
                                case "rotationX":
                                case "rotationY":
                                    if (!this._overrideRotate)
                                    {
                                        _local_13 = (_local_11 - _local_8);
                                    };
                                    break;
                            };
                        };
                        _local_10.setValue(_arg_1, _local_13);
                };
                _local_6 = _local_11;
                _local_9++;
            };
        }

        public function initFilters(_arg_1:Array, _arg_2:Array, _arg_3:int=-1, _arg_4:int=-1):void
        {
            var _local_6:Class;
            var _local_7:int;
            var _local_8:KeyframeBase;
            var _local_9:BitmapFilter;
            var _local_10:int;
            if (((_arg_3 == -1) || (_arg_4 == -1)))
            {
                _arg_3 = 0;
                _arg_4 = this.duration;
            };
            var _local_5:int;
            while (_local_5 < _arg_1.length)
            {
                _local_6 = (getDefinitionByName(_arg_1[_local_5]) as Class);
                _local_7 = _arg_3;
                while (_local_7 < _arg_4)
                {
                    _local_8 = KeyframeBase(this.keyframes[_local_7]);
                    if (_local_8 == null)
                    {
                        _local_8 = this.getNewKeyframe();
                        _local_8.index = _local_7;
                        this.addKeyframe(_local_8);
                    };
                    if (((_local_8) && (_local_8.filters == null)))
                    {
                        _local_8.filters = new Array();
                    };
                    if (((_local_8) && (_local_8.filters)))
                    {
                        _local_9 = null;
                        switch (_arg_1[_local_5])
                        {
                            case "flash.filters.GradientBevelFilter":
                            case "flash.filters.GradientGlowFilter":
                                _local_10 = _arg_2[_local_5];
                                _local_9 = BitmapFilter(new _local_6(4, 45, new Array(_local_10), new Array(_local_10), new Array(_local_10)));
                                break;
                            default:
                                _local_9 = BitmapFilter(new (_local_6)());
                        };
                        if (_local_9)
                        {
                            _local_8.filters.push(_local_9);
                        };
                    };
                    _local_7++;
                };
                _local_5++;
            };
        }

        public function addFilterPropertyArray(_arg_1:int, _arg_2:String, _arg_3:Array, _arg_4:int=-1, _arg_5:int=-1):void
        {
            var _local_10:KeyframeBase;
            var _local_11:*;
            var _local_12:int;
            var _local_6:int = _arg_3.length;
            var _local_7:* = null;
            var _local_8:Boolean = true;
            if (_local_6 > 0)
            {
                if ((_arg_3[0] is Number))
                {
                    _local_8 = false;
                };
            };
            if (this.duration < _local_6)
            {
                this.duration = _local_6;
            };
            if (((_arg_4 == -1) || (_arg_5 == -1)))
            {
                _arg_4 = 0;
                _arg_5 = this.duration;
            };
            var _local_9:int = _arg_4;
            while (_local_9 < _arg_5)
            {
                _local_10 = KeyframeBase(this.keyframes[_local_9]);
                if (_local_10 == null)
                {
                    _local_10 = this.getNewKeyframe();
                    _local_10.index = _local_9;
                    this.addKeyframe(_local_10);
                };
                _local_11 = _local_7;
                _local_12 = (_local_9 - _arg_4);
                if (_local_12 < _arg_3.length)
                {
                    if (((_arg_3[_local_12]) || (!(_local_8))))
                    {
                        _local_11 = _arg_3[_local_12];
                    };
                };
                switch (_arg_2)
                {
                    case "adjustColorBrightness":
                    case "adjustColorContrast":
                    case "adjustColorSaturation":
                    case "adjustColorHue":
                        _local_10.setAdjustColorProperty(_arg_1, _arg_2, _local_11);
                        break;
                    default:
                        if (_arg_1 < _local_10.filters.length)
                        {
                            _local_10.filters[_arg_1][_arg_2] = _local_11;
                        };
                };
                _local_7 = _local_11;
                _local_9++;
            };
        }

        protected function getNewKeyframe(_arg_1:XML=null):KeyframeBase
        {
            return (new KeyframeBase(_arg_1));
        }


    }
}//package fl.motion

