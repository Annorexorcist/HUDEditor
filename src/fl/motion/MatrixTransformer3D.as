// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//fl.motion.MatrixTransformer3D

package fl.motion
{
    import __AS3__.vec.Vector;
    import flash.geom.Matrix3D;
    import flash.geom.Vector3D;
    import __AS3__.vec.*;

    public class MatrixTransformer3D 
    {

        public static const AXIS_X:int = 0;
        public static const AXIS_Y:int = 1;
        public static const AXIS_Z:int = 2;


        public static function rotateAboutAxis(_arg_1:Number, _arg_2:int):Matrix3D
        {
            var _local_3:Number = Math.cos(_arg_1);
            var _local_4:Number = Math.sin(_arg_1);
            var _local_5:Vector.<Number> = new Vector.<Number>();
            switch (_arg_2)
            {
                case AXIS_X:
                    _local_5[0] = 1;
                    _local_5[1] = 0;
                    _local_5[2] = 0;
                    _local_5[3] = 0;
                    _local_5[4] = 0;
                    _local_5[5] = _local_3;
                    _local_5[6] = _local_4;
                    _local_5[7] = 0;
                    _local_5[8] = 0;
                    _local_5[9] = -(_local_4);
                    _local_5[10] = _local_3;
                    _local_5[11] = 0;
                    _local_5[12] = 0;
                    _local_5[13] = 0;
                    _local_5[14] = 0;
                    _local_5[15] = 1;
                    break;
                case AXIS_Y:
                    _local_5[0] = _local_3;
                    _local_5[1] = 0;
                    _local_5[2] = -(_local_4);
                    _local_5[3] = 0;
                    _local_5[4] = 0;
                    _local_5[5] = 1;
                    _local_5[6] = 0;
                    _local_5[7] = 0;
                    _local_5[8] = _local_4;
                    _local_5[9] = 0;
                    _local_5[10] = _local_3;
                    _local_5[11] = 0;
                    _local_5[12] = 0;
                    _local_5[13] = 0;
                    _local_5[14] = 0;
                    _local_5[15] = 1;
                    break;
                case AXIS_Z:
                    _local_5[0] = _local_3;
                    _local_5[1] = _local_4;
                    _local_5[2] = 0;
                    _local_5[3] = 0;
                    _local_5[4] = -(_local_4);
                    _local_5[5] = _local_3;
                    _local_5[6] = 0;
                    _local_5[7] = 0;
                    _local_5[8] = 0;
                    _local_5[9] = 0;
                    _local_5[10] = 1;
                    _local_5[11] = 0;
                    _local_5[12] = 0;
                    _local_5[13] = 0;
                    _local_5[14] = 0;
                    _local_5[15] = 1;
                    break;
            };
            return (new Matrix3D(_local_5));
        }

        public static function getVector(_arg_1:Matrix3D, _arg_2:int):Vector3D
        {
            switch (_arg_2)
            {
                case 0:
                    return (new Vector3D(_arg_1.rawData[0], _arg_1.rawData[1], _arg_1.rawData[2], _arg_1.rawData[3]));
                case 1:
                    return (new Vector3D(_arg_1.rawData[4], _arg_1.rawData[5], _arg_1.rawData[6], _arg_1.rawData[7]));
                case 2:
                    return (new Vector3D(_arg_1.rawData[8], _arg_1.rawData[9], _arg_1.rawData[10], _arg_1.rawData[11]));
                case 3:
                    return (new Vector3D(_arg_1.rawData[12], _arg_1.rawData[13], _arg_1.rawData[14], _arg_1.rawData[15]));
            };
            return (new Vector3D(0, 0, 0, 0));
        }

        public static function getMatrix3D(_arg_1:Vector3D, _arg_2:Vector3D, _arg_3:Vector3D, _arg_4:Vector3D):Matrix3D
        {
            var _local_5:Vector.<Number> = new Vector.<Number>();
            _local_5[0] = _arg_1.x;
            _local_5[1] = _arg_1.y;
            _local_5[2] = _arg_1.z;
            _local_5[3] = _arg_1.w;
            _local_5[4] = _arg_2.x;
            _local_5[5] = _arg_2.y;
            _local_5[6] = _arg_2.z;
            _local_5[7] = _arg_2.w;
            _local_5[8] = _arg_3.x;
            _local_5[9] = _arg_3.y;
            _local_5[10] = _arg_3.z;
            _local_5[11] = _arg_3.w;
            _local_5[12] = _arg_4.x;
            _local_5[13] = _arg_4.y;
            _local_5[14] = _arg_4.z;
            _local_5[15] = _arg_4.w;
            return (new Matrix3D(_local_5));
        }

        public static function rotateAxis(_arg_1:Matrix3D, _arg_2:Number, _arg_3:int):Matrix3D
        {
            var _local_7:Vector3D;
            var _local_8:Array;
            var _local_9:int;
            var _local_10:Vector.<Number>;
            var _local_11:Vector3D;
            var _local_4:Matrix3D = new Matrix3D();
            var _local_5:Vector3D = getVector(_arg_1, _arg_3);
            _local_4.prependRotation(((_arg_2 * 180) / Math.PI), _local_5);
            var _local_6:int;
            while (_local_6 < 3)
            {
                if (_local_6 != _arg_3)
                {
                    _local_7 = getVector(_arg_1, _local_6);
                    _local_8 = new Array(3);
                    _local_9 = 0;
                    while (_local_9 < 3)
                    {
                        _local_11 = getVector(_local_4, _local_9);
                        _local_8[_local_9] = _local_7.dotProduct(_local_11);
                        _local_9++;
                    };
                    _local_7.x = _local_8[0];
                    _local_7.y = _local_8[1];
                    _local_7.z = _local_8[2];
                    _local_7.w = 0;
                    _local_7 = normalizeVector(_local_7);
                    _local_10 = Vector.<Number>(getRawDataVector(_arg_1));
                    _local_10[(_local_6 * 4)] = _local_7.x;
                    _local_10[((_local_6 * 4) + 1)] = _local_7.y;
                    _local_10[((_local_6 * 4) + 2)] = _local_7.z;
                    _local_10[((_local_6 * 4) + 3)] = _local_7.w;
                    _arg_1 = new Matrix3D(Vector.<Number>(_local_10));
                };
                _local_6++;
            };
            return (_arg_1);
        }

        public static function normalizeVector(_arg_1:Vector3D):Vector3D
        {
            var _local_2:Number = (1 / _arg_1.length);
            var _local_3:Vector3D = new Vector3D();
            _local_3.x = (_arg_1.x * _local_2);
            _local_3.y = (_arg_1.y * _local_2);
            _local_3.z = (_arg_1.z * _local_2);
            _local_3.w = _arg_1.w;
            return (_local_3);
        }

        public static function getRawDataVector(_arg_1:Matrix3D):Vector.<Number>
        {
            var _local_2:Vector.<Number> = new Vector.<Number>();
            _local_2[0] = _arg_1.rawData[0];
            _local_2[1] = _arg_1.rawData[1];
            _local_2[2] = _arg_1.rawData[2];
            _local_2[3] = _arg_1.rawData[3];
            _local_2[4] = _arg_1.rawData[4];
            _local_2[5] = _arg_1.rawData[5];
            _local_2[6] = _arg_1.rawData[6];
            _local_2[7] = _arg_1.rawData[7];
            _local_2[8] = _arg_1.rawData[8];
            _local_2[9] = _arg_1.rawData[9];
            _local_2[10] = _arg_1.rawData[10];
            _local_2[11] = _arg_1.rawData[11];
            _local_2[12] = _arg_1.rawData[12];
            _local_2[13] = _arg_1.rawData[13];
            _local_2[14] = _arg_1.rawData[14];
            _local_2[15] = _arg_1.rawData[15];
            return (_local_2);
        }


    }
}//package fl.motion

