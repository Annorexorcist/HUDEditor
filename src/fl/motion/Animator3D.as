// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//fl.motion.Animator3D

package fl.motion
{
    import flash.geom.Matrix;
    import flash.geom.Vector3D;
    import flash.geom.Matrix3D;
    import flash.geom.Point;
    import flash.display.DisplayObject;
    import __AS3__.vec.Vector;
    import flash.display.MovieClip;
    import __AS3__.vec.*;

    public class Animator3D extends AnimatorBase 
    {

        private static var IDENTITY_MATRIX:Matrix = new Matrix();
        protected static const EPSILON:Number = 1E-8;

        private var _initialPosition:Vector3D;
        private var _initialMatrixOfTarget:Matrix3D;

        public function Animator3D(_arg_1:XML=null, _arg_2:DisplayObject=null)
        {
            super(_arg_1, _arg_2);
            this.transformationPoint = new Point(0, 0);
            this._initialPosition = null;
            this._initialMatrixOfTarget = null;
            this._isAnimator3D = true;
        }

        protected static function getSign(_arg_1:Number):int
        {
            return ((_arg_1 < -(EPSILON)) ? -1 : ((_arg_1 > EPSILON) ? 1 : 0));
        }

        protected static function convertMatrixToMatrix3D(_arg_1:Matrix):Matrix3D
        {
            var _local_2:Vector.<Number> = new Vector.<Number>(16);
            _local_2[0] = _arg_1.a;
            _local_2[1] = _arg_1.b;
            _local_2[2] = 0;
            _local_2[3] = 0;
            _local_2[4] = _arg_1.c;
            _local_2[5] = _arg_1.d;
            _local_2[6] = 0;
            _local_2[7] = 0;
            _local_2[8] = 0;
            _local_2[9] = 0;
            _local_2[10] = 1;
            _local_2[11] = 0;
            _local_2[12] = _arg_1.tx;
            _local_2[13] = _arg_1.ty;
            _local_2[14] = 0;
            _local_2[15] = 1;
            return (new Matrix3D(_local_2));
        }

        protected static function matrices3DEqual(_arg_1:Matrix3D, _arg_2:Matrix3D):Boolean
        {
            var _local_3:Vector.<Number> = _arg_1.rawData;
            var _local_4:Vector.<Number> = _arg_2.rawData;
            if (((((_local_3 == null) || (!(_local_3.length == 16))) || (_local_4 == null)) || (!(_local_4.length == 16))))
            {
                return (false);
            };
            var _local_5:int;
            while (_local_5 < 16)
            {
                if (_local_3[_local_5] != _local_4[_local_5])
                {
                    return (false);
                };
                _local_5++;
            };
            return (true);
        }


        override public function set initialPosition(_arg_1:Array):void
        {
            if (_arg_1.length == 3)
            {
                this._initialPosition = new Vector3D();
                this._initialPosition.x = _arg_1[0];
                this._initialPosition.y = _arg_1[1];
                this._initialPosition.z = _arg_1[2];
            };
        }

        override protected function setTargetState():void
        {
            if (((!(motionArray)) && (!(this._target.transform.matrix == null))))
            {
                this._initialMatrixOfTarget = convertMatrixToMatrix3D(this._target.transform.matrix);
            };
        }

        override protected function setTime3D(_arg_1:int, _arg_2:MotionBase):Boolean
        {
            var _local_4:Matrix3D;
            var _local_5:Matrix3D;
            var _local_6:Number;
            var _local_7:Number;
            var _local_8:Number;
            var _local_9:Number;
            var _local_10:Number;
            var _local_11:Number;
            var _local_12:Matrix;
            var _local_13:Matrix3D;
            var _local_3:Matrix3D = (_arg_2.getMatrix3D(_arg_1) as Matrix3D);
            if (((motionArray) && (!(_arg_2 == _lastMotionUsed))))
            {
                this.transformationPoint = ((_arg_2.motion_internal::transformationPoint) ? _arg_2.motion_internal::transformationPoint : new Point(0, 0));
                if (_arg_2.motion_internal::initialPosition)
                {
                    this.initialPosition = _arg_2.motion_internal::initialPosition;
                }
                else
                {
                    this._initialPosition = null;
                };
                _lastMotionUsed = _arg_2;
            };
            if (_local_3)
            {
                if ((((!(motionArray)) || (!(_lastMatrix3DApplied))) || (!(matrices3DEqual(_local_3, Matrix3D(_lastMatrix3DApplied))))))
                {
                    _local_4 = _local_3.clone();
                    if (this._initialMatrixOfTarget)
                    {
                        _local_4.append(this._initialMatrixOfTarget);
                    };
                    this._target.transform.matrix3D = _local_4;
                    _lastMatrix3DApplied = _local_3;
                };
                return (true);
            };
            if (_arg_2.is3D)
            {
                _local_5 = new Matrix3D();
                _local_6 = ((_arg_2.getValue(_arg_1, Tweenables.ROTATION_X) * Math.PI) / 180);
                _local_7 = ((_arg_2.getValue(_arg_1, Tweenables.ROTATION_Y) * Math.PI) / 180);
                _local_8 = ((_arg_2.getValue(_arg_1, Tweenables.ROTATION_CONCAT) * Math.PI) / 180);
                _local_5.prepend(MatrixTransformer3D.rotateAboutAxis(_local_8, MatrixTransformer3D.AXIS_Z));
                _local_5.prepend(MatrixTransformer3D.rotateAboutAxis(_local_7, MatrixTransformer3D.AXIS_Y));
                _local_5.prepend(MatrixTransformer3D.rotateAboutAxis(_local_6, MatrixTransformer3D.AXIS_X));
                _local_9 = _arg_2.getValue(_arg_1, Tweenables.X);
                _local_10 = _arg_2.getValue(_arg_1, Tweenables.Y);
                _local_11 = _arg_2.getValue(_arg_1, Tweenables.Z);
                if ((((!(getSign(_local_9) == 0)) || (!(getSign(_local_10) == 0))) || (!(getSign(_local_11) == 0))))
                {
                    _local_5.appendTranslation(_local_9, _local_10, _local_11);
                };
                _local_5.prependTranslation(-(this.transformationPoint.x), -(this.transformationPoint.y), -(this.transformationPointZ));
                if (this._initialPosition)
                {
                    _local_5.appendTranslation(this._initialPosition.x, this._initialPosition.y, this._initialPosition.z);
                };
                _local_12 = this.getScaleSkewMatrix(_arg_2, _arg_1, this.transformationPoint.x, this.transformationPoint.y);
                _local_13 = convertMatrixToMatrix3D(_local_12);
                _local_5.prepend(_local_13);
                if (this._initialMatrixOfTarget)
                {
                    _local_5.append(this._initialMatrixOfTarget);
                };
                if ((((!(motionArray)) || (!(_lastMatrix3DApplied))) || (!(matrices3DEqual(_local_5, Matrix3D(_lastMatrix3DApplied))))))
                {
                    this._target.transform.matrix3D = _local_5;
                    _lastMatrix3DApplied = _local_5;
                };
            };
            return (false);
        }

        override protected function removeChildTarget(_arg_1:MovieClip, _arg_2:DisplayObject, _arg_3:String):void
        {
            super.removeChildTarget(_arg_1, _arg_2, _arg_3);
            if (_arg_2.transform.matrix3D != null)
            {
                _arg_2.transform.matrix = IDENTITY_MATRIX;
            };
        }

        private function getScaleSkewMatrix(_arg_1:MotionBase, _arg_2:int, _arg_3:Number, _arg_4:Number):Matrix
        {
            var _local_5:Number = _arg_1.getValue(_arg_2, Tweenables.SCALE_X);
            var _local_6:Number = _arg_1.getValue(_arg_2, Tweenables.SCALE_Y);
            var _local_7:Number = _arg_1.getValue(_arg_2, Tweenables.SKEW_X);
            var _local_8:Number = _arg_1.getValue(_arg_2, Tweenables.SKEW_Y);
            var _local_9:Matrix = new Matrix();
            _local_9.translate(-(_arg_3), -(_arg_4));
            var _local_10:Matrix = new Matrix();
            _local_10.scale(_local_5, _local_6);
            _local_9.concat(_local_10);
            var _local_11:Matrix = new Matrix();
            _local_11.a = Math.cos((_local_8 * (Math.PI / 180)));
            _local_11.b = Math.sin((_local_8 * (Math.PI / 180)));
            _local_11.c = -(Math.sin((_local_7 * (Math.PI / 180))));
            _local_11.d = Math.cos((_local_7 * (Math.PI / 180)));
            _local_9.concat(_local_11);
            _local_9.translate(_arg_3, _arg_4);
            return (_local_9);
        }


    }
}//package fl.motion

