// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//fl.motion.AnimatorFactoryBase

package fl.motion
{
    import flash.utils.Dictionary;
    import flash.geom.Point;
    import flash.display.DisplayObject;
    import flash.display.SimpleButton;
    import flash.display.DisplayObjectContainer;
    import flash.utils.getDefinitionByName;
    import flash.display.MovieClip;
    import flash.display.Sprite;

    public class AnimatorFactoryBase 
    {

        private var _motion:MotionBase;
        private var _motionArray:Array;
        private var _animators:Dictionary;
        protected var _transformationPoint:Point;
        protected var _transformationPointZ:int;
        protected var _is3D:Boolean;
        protected var _sceneName:String;

        public function AnimatorFactoryBase(_arg_1:MotionBase, _arg_2:Array=null)
        {
            this._motion = _arg_1;
            this._motionArray = _arg_2;
            this._animators = new Dictionary(true);
            this._transformationPoint = new Point(0.5, 0.5);
            this._transformationPointZ = 0;
            this._is3D = false;
            this._sceneName = "";
        }

        public function get motion():MotionBase
        {
            return (this._motion);
        }

        public function addTarget(_arg_1:DisplayObject, _arg_2:int=0, _arg_3:Boolean=true, _arg_4:int=-1, _arg_5:Boolean=false):AnimatorBase
        {
            if (_arg_1)
            {
                return (this.addTargetInfo(_arg_1.parent, _arg_1.name, _arg_2, _arg_3, _arg_4, _arg_5));
            };
            return (null);
        }

        protected function getNewAnimator():AnimatorBase
        {
            return (null);
        }

        public function addTargetInfo(_arg_1:DisplayObject, _arg_2:String, _arg_3:int=0, _arg_4:Boolean=true, _arg_5:int=-1, _arg_6:Boolean=false, _arg_7:Array=null, _arg_8:int=-1, _arg_9:String=null, _arg_10:Class=null):AnimatorBase
        {
            var _local_14:Class;
            if (((!(_arg_1 is DisplayObjectContainer)) && (!(_arg_1 is SimpleButton))))
            {
                return (null);
            };
            var _local_11:Dictionary = this._animators[_arg_1];
            if (!_local_11)
            {
                _local_11 = new Dictionary();
                this._animators[_arg_1] = _local_11;
            };
            var _local_12:AnimatorBase = _local_11[_arg_2];
            var _local_13:Boolean;
            if (!_local_12)
            {
                _local_12 = this.getNewAnimator();
                _local_14 = (getDefinitionByName("flash.events.Event") as Class);
                if (_local_14.hasOwnProperty("FRAME_CONSTRUCTED"))
                {
                    _local_12.frameEvent = "frameConstructed";
                };
                _local_11[_arg_2] = _local_12;
                _local_13 = true;
            };
            _local_12.motion = this._motion;
            _local_12.motionArray = this._motionArray;
            _local_12.transformationPoint = this._transformationPoint;
            _local_12.transformationPointZ = this._transformationPointZ;
            _local_12.sceneName = this._sceneName;
            if (_local_13)
            {
                if ((_arg_1 is MovieClip))
                {
                    AnimatorBase.registerParentFrameHandler((_arg_1 as MovieClip), _local_12, _arg_5, _arg_3, _arg_6);
                };
            };
            if ((_arg_1 is MovieClip))
            {
                _local_12.targetParent = MovieClip(_arg_1);
                _local_12.targetName = _arg_2;
                _local_12.placeholderName = _arg_9;
                _local_12.instanceFactoryClass = _arg_10;
            }
            else
            {
                if ((_arg_1 is SimpleButton))
                {
                    AnimatorBase.registerButtonState((_arg_1 as SimpleButton), _local_12, _arg_5, _arg_8, _arg_2, _arg_9, _arg_10);
                }
                else
                {
                    if ((_arg_1 is Sprite))
                    {
                        AnimatorBase.registerSpriteParent((_arg_1 as Sprite), _local_12, _arg_2, _arg_9, _arg_10);
                    };
                };
            };
            if (_arg_7)
            {
                _local_12.initialPosition = _arg_7;
            };
            if (_arg_4)
            {
                AnimatorBase.processCurrentFrame((_arg_1 as MovieClip), _local_12, true, true);
            };
            return (_local_12);
        }

        public function set transformationPoint(_arg_1:Point):void
        {
            this._transformationPoint = _arg_1;
        }

        public function set transformationPointZ(_arg_1:int):void
        {
            this._transformationPointZ = _arg_1;
        }

        public function set sceneName(_arg_1:String):void
        {
            this._sceneName = _arg_1;
        }


    }
}//package fl.motion

