// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//fl.motion.AnimatorBase

package fl.motion
{
    import flash.events.EventDispatcher;
    import flash.display.MovieClip;
    import flash.geom.ColorTransform;
    import flash.geom.Matrix;
    import flash.geom.Point;
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.display.SimpleButton;
    import flash.display.Sprite;
    import flash.events.Event;

    public class AnimatorBase extends EventDispatcher 
    {

        private static var enterFrameBeacon:MovieClip = new MovieClip();

        private var _motion:MotionBase;
        private var _motionArray:Array;
        protected var _lastMotionUsed:MotionBase;
        protected var _lastColorTransformApplied:ColorTransform;
        protected var _filtersApplied:Boolean;
        protected var _lastBlendModeApplied:String;
        protected var _cacheAsBitmapHasBeenApplied:Boolean;
        protected var _lastCacheAsBitmapApplied:Boolean;
        protected var _opaqueBackgroundHasBeenApplied:Boolean;
        protected var _lastOpaqueBackgroundApplied:Object;
        protected var _visibleHasBeenApplied:Boolean;
        protected var _lastVisibleApplied:Boolean;
        protected var _lastMatrixApplied:Matrix;
        protected var _lastMatrix3DApplied:Object;
        protected var _toRemove:Array;
        protected var _lastFrameHandled:int;
        protected var _lastSceneHandled:String;
        protected var _registeredParent:Boolean;
        public var orientToPath:Boolean = false;
        public var transformationPoint:Point;
        public var transformationPointZ:int;
        public var autoRewind:Boolean = false;
        public var positionMatrix:Matrix;
        public var repeatCount:int = 1;
        private var _isPlaying:Boolean = false;
        protected var _target:DisplayObject;
        protected var _lastTarget:DisplayObject;
        private var _lastRenderedTime:int = -1;
        private var _lastRenderedMotion:MotionBase = null;
        private var _time:int = -1;
        private var _targetParent:DisplayObjectContainer = null;
        private var _targetParentBtn:SimpleButton = null;
        private var _targetName:String = "";
        private var targetStateOriginal:Object = null;
        private var _placeholderName:String = null;
        private var _instanceFactoryClass:Class = null;
        private var instanceFactory:Object = null;
        private var _useCurrentFrame:Boolean = false;
        private var _spanStart:int = -1;
        private var _spanEnd:int = -1;
        private var _sceneName:String = "";
        private var _frameEvent:String = "enterFrame";
        private var _targetState3D:Array = null;
        protected var _isAnimator3D:Boolean;
        private var playCount:int = 0;
        protected var targetState:Object;

        public function AnimatorBase(_arg_1:XML=null, _arg_2:DisplayObject=null)
        {
            this.target = _arg_2;
            this._isAnimator3D = false;
            this.transformationPoint = new Point(0.5, 0.5);
            this.transformationPointZ = 0;
            this._sceneName = "";
            this._toRemove = new Array();
            this._lastFrameHandled = -1;
            this._lastSceneHandled = null;
            this._registeredParent = false;
        }

        protected static function colorTransformsEqual(_arg_1:ColorTransform, _arg_2:ColorTransform):Boolean
        {
            return ((((((((_arg_1.alphaMultiplier == _arg_2.alphaMultiplier) && (_arg_1.alphaOffset == _arg_2.alphaOffset)) && (_arg_1.blueMultiplier == _arg_2.blueMultiplier)) && (_arg_1.blueOffset == _arg_2.blueOffset)) && (_arg_1.greenMultiplier == _arg_2.greenMultiplier)) && (_arg_1.greenOffset == _arg_2.greenOffset)) && (_arg_1.redMultiplier == _arg_2.redMultiplier)) && (_arg_1.redOffset == _arg_2.redOffset));
        }

        public static function registerParentFrameHandler(_arg_1:MovieClip, _arg_2:AnimatorBase, _arg_3:int, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            _arg_2._registeredParent = true;
            if (_arg_3 == -1)
            {
                _arg_3 = (_arg_1.currentFrame - 1);
            };
            if (_arg_5)
            {
                _arg_2.useCurrentFrame(true, _arg_3);
            }
            else
            {
                _arg_2.repeatCount = _arg_4;
            };
        }

        public static function processCurrentFrame(_arg_1:MovieClip, _arg_2:AnimatorBase, _arg_3:Boolean, _arg_4:Boolean=false):void
        {
            var _local_5:int;
            var _local_6:int;
            if (((_arg_2) && (_arg_1)))
            {
                if (_arg_2.usingCurrentFrame)
                {
                    _local_5 = (_arg_1.currentFrame - 1);
                    if (_arg_1.scenes.length > 1)
                    {
                        if (_arg_1.currentScene.name != _arg_2.sceneName)
                        {
                            _local_5 = -1;
                        };
                    };
                    if (((_local_5 >= _arg_2.spanStart) && (_local_5 <= _arg_2.spanEnd)))
                    {
                        _local_6 = ((_arg_2.motionArray) ? _local_5 : (_local_5 - _arg_2.spanStart));
                        if (!_arg_2.isPlaying)
                        {
                            _arg_2.play(_local_6, _arg_3);
                        }
                        else
                        {
                            if (!_arg_4)
                            {
                                if (_local_5 == _arg_2.spanEnd)
                                {
                                    _arg_2.handleLastFrame(true, false);
                                }
                                else
                                {
                                    _arg_2.time = _local_6;
                                };
                            };
                        };
                    }
                    else
                    {
                        if (((_arg_2.isPlaying) && (!(_arg_4))))
                        {
                            _arg_2.end(true, false, true);
                        }
                        else
                        {
                            if (((!(_arg_2.isPlaying)) && (_arg_4)))
                            {
                                _arg_2.startFrameEvents();
                            };
                        };
                    };
                }
                else
                {
                    if (((_arg_2.targetParent) && (((_arg_2.targetParent.hasOwnProperty(_arg_2.targetName)) && (_arg_2.targetParent[_arg_2.targetName] == null)) || (_arg_2.targetParent.getChildByName(_arg_2.targetName) == null))))
                    {
                        if (_arg_2.isPlaying)
                        {
                            _arg_2.end(true, false);
                        }
                        else
                        {
                            if (_arg_4)
                            {
                                _arg_2.startFrameEvents();
                            };
                        };
                    }
                    else
                    {
                        if (!_arg_2.isPlaying)
                        {
                            if (_arg_4)
                            {
                                _arg_2.play(0, _arg_3);
                            };
                        }
                        else
                        {
                            if (!_arg_4)
                            {
                                _arg_2.nextFrame(false, false);
                            };
                        };
                    };
                };
            };
        }

        public static function registerButtonState(targetParentBtn:SimpleButton, anim:AnimatorBase, stateFrame:int, zIndex:int=-1, targetName:String=null, placeholderName:String=null, instanceFactoryClass:Class=null):void
        {
            var newTarget:DisplayObject;
            var container:DisplayObjectContainer;
            var target:DisplayObject = targetParentBtn.upState;
            switch (stateFrame)
            {
                case 1:
                    target = targetParentBtn.overState;
                    break;
                case 2:
                    target = targetParentBtn.downState;
                    break;
                case 3:
                    target = targetParentBtn.hitTestState;
                    break;
            };
            if (!target)
            {
                return;
            };
            if (zIndex >= 0)
            {
                try
                {
                    container = DisplayObjectContainer(target);
                    newTarget = container.getChildAt(zIndex);
                }
                catch(e:Error)
                {
                    newTarget = null;
                };
                if (newTarget != null)
                {
                    target = newTarget;
                };
            };
            anim.target = target;
            if (((!(placeholderName == null)) && (!(instanceFactoryClass == null))))
            {
                anim.targetParentButton = targetParentBtn;
                anim.targetName = targetName;
                anim.instanceFactoryClass = instanceFactoryClass;
                anim.useCurrentFrame(true, stateFrame);
                anim.target.addEventListener(anim.frameEvent, anim.placeholderButtonEnterFrameHandler, false, 0, true);
                anim.placeholderButtonEnterFrameHandler(null);
            }
            else
            {
                anim.time = 0;
            };
        }

        public static function registerSpriteParent(_arg_1:Sprite, _arg_2:AnimatorBase, _arg_3:String, _arg_4:String=null, _arg_5:Class=null):void
        {
            var _local_6:DisplayObject;
            if ((((_arg_1 == null) || (_arg_2 == null)) || (_arg_3 == null)))
            {
                return;
            };
            if (((!(_arg_4 == null)) && (!(_arg_5 == null))))
            {
                _local_6 = _arg_1[_arg_4];
                if (_local_6 == null)
                {
                    _local_6 = _arg_1.getChildByName(_arg_4);
                };
                _arg_2.target = _local_6;
                _arg_2.targetParent = _arg_1;
                _arg_2.targetName = _arg_3;
                _arg_2.placeholderName = _arg_4;
                _arg_2.instanceFactoryClass = _arg_5;
                _arg_2.useCurrentFrame(true, 0);
                _arg_2.target.addEventListener(_arg_2.frameEvent, _arg_2.placeholderSpriteEnterFrameHandler, false, 0, true);
                _arg_2.placeholderSpriteEnterFrameHandler(null);
            }
            else
            {
                _local_6 = _arg_1[_arg_3];
                if (_local_6 == null)
                {
                    _local_6 = _arg_1.getChildByName(_arg_3);
                };
                _arg_2.target = _local_6;
                _arg_2.time = 0;
            };
        }


        public function get motion():MotionBase
        {
            return (this._motion);
        }

        public function set motion(_arg_1:MotionBase):void
        {
            this._motion = _arg_1;
            if (_arg_1)
            {
                if (this.motionArray)
                {
                    this._spanStart = (this._spanEnd = -1);
                };
                this.motionArray = null;
            };
        }

        public function get motionArray():Array
        {
            return (this._motionArray);
        }

        public function set motionArray(_arg_1:Array):void
        {
            var _local_2:int;
            this._motionArray = (((_arg_1) && (_arg_1.length > 0)) ? _arg_1 : null);
            if (this._motionArray)
            {
                this.motion = null;
                this._spanStart = this._motionArray[0].motion_internal::spanStart;
                this._spanEnd = (this._spanStart - 1);
                _local_2 = 0;
                while (_local_2 < this._motionArray.length)
                {
                    this._spanEnd = (this._spanEnd + this._motionArray[_local_2].duration);
                    _local_2++;
                };
            };
        }

        public function get isPlaying():Boolean
        {
            return (this._isPlaying);
        }

        public function get target():DisplayObject
        {
            return (this._target);
        }

        public function set target(_arg_1:DisplayObject):void
        {
            if (!_arg_1)
            {
                return;
            };
            this._target = _arg_1;
            if (_arg_1 != this._lastTarget)
            {
                this._lastColorTransformApplied = null;
                this._filtersApplied = false;
                this._lastBlendModeApplied = null;
                this._cacheAsBitmapHasBeenApplied = false;
                this._opaqueBackgroundHasBeenApplied = false;
                this._visibleHasBeenApplied = false;
                this._lastMatrixApplied = null;
                this._lastMatrix3DApplied = null;
                this._toRemove = new Array();
            };
            this._lastTarget = _arg_1;
            var _local_2:Boolean;
            if (((this.targetParent) && (!(this.targetName == ""))))
            {
                if (this.targetStateOriginal)
                {
                    this.targetState = this.targetStateOriginal;
                    return;
                };
                _local_2 = true;
            };
            this.targetState = {};
            this.setTargetState();
            if (_local_2)
            {
                this.targetStateOriginal = this.targetState;
            };
        }

        protected function setTargetState():void
        {
        }

        public function set initialPosition(_arg_1:Array):void
        {
        }

        public function get time():int
        {
            return (this._time);
        }

        public function set time(_arg_1:int):void
        {
            var _local_3:Array;
            var _local_6:DisplayObject;
            var _local_7:int;
            var _local_8:ColorTransform;
            var _local_9:Array;
            if (_arg_1 == this._time)
            {
                return;
            };
            if (this._placeholderName)
            {
                _local_6 = this._targetParent[this._placeholderName];
                if (!_local_6)
                {
                    _local_6 = this._targetParent.getChildByName(this._placeholderName);
                };
                if ((((_local_6) && (_local_6.parent == this._targetParent)) && (this._target.parent == this._targetParent)))
                {
                    this._targetParent.addChildAt(this._target, (this._targetParent.getChildIndex(_local_6) + 1));
                };
            };
            var _local_2:MotionBase = this.motion;
            if (_local_2)
            {
                if (_arg_1 > (_local_2.duration - 1))
                {
                    _arg_1 = (_local_2.duration - 1);
                }
                else
                {
                    if (_arg_1 < 0)
                    {
                        _arg_1 = 0;
                    };
                };
                this._time = _arg_1;
            }
            else
            {
                _local_3 = this.motionArray;
                if (_arg_1 <= this._spanStart)
                {
                    _local_2 = _local_3[0];
                    _arg_1 = this._spanStart;
                }
                else
                {
                    if (_arg_1 >= this._spanEnd)
                    {
                        _local_2 = _local_3[(_local_3.length - 1)];
                        _arg_1 = this._spanEnd;
                    }
                    else
                    {
                        _local_7 = 0;
                        while (_local_7 < _local_3.length)
                        {
                            _local_2 = _local_3[_local_7];
                            if (_arg_1 <= ((_local_2.motion_internal::spanStart + _local_2.duration) - 1)) break;
                            _local_7++;
                        };
                    };
                };
                this._time = _arg_1;
                _arg_1 = (_arg_1 - _local_2.motion_internal::spanStart);
            };
            this.dispatchEvent(new MotionEvent(MotionEvent.TIME_CHANGE));
            var _local_4:KeyframeBase = _local_2.getCurrentKeyframe(_arg_1);
            var _local_5:Boolean = (((_local_4.index == this._lastRenderedTime) && ((!(_local_3)) || (this._lastRenderedMotion == _local_2))) && (!(_local_4.tweensLength)));
            if (_local_5)
            {
                return;
            };
            if (_local_4.blank)
            {
                this._target.visible = false;
            }
            else
            {
                if (this._isAnimator3D)
                {
                    this._lastMatrixApplied = null;
                    this.setTime3D(_arg_1, _local_2);
                }
                else
                {
                    this._lastMatrix3DApplied = null;
                    this.setTimeClassic(_arg_1, _local_2, _local_4);
                };
                _local_8 = _local_2.getColorTransform(_arg_1);
                if (_local_3)
                {
                    if (((!(_local_8)) && (this._lastColorTransformApplied)))
                    {
                        _local_8 = new ColorTransform();
                    };
                    if (((_local_8) && ((!(this._lastColorTransformApplied)) || (!(colorTransformsEqual(_local_8, this._lastColorTransformApplied))))))
                    {
                        this._target.transform.colorTransform = _local_8;
                        this._lastColorTransformApplied = _local_8;
                    };
                }
                else
                {
                    if (_local_8)
                    {
                        this._target.transform.colorTransform = _local_8;
                    };
                };
                _local_9 = _local_2.getFilters(_arg_1);
                if ((((_local_3) && (!(_local_9))) && (this._filtersApplied)))
                {
                    this._target.filters = null;
                    this._filtersApplied = false;
                }
                else
                {
                    if (_local_9)
                    {
                        this._target.filters = _local_9;
                        this._filtersApplied = true;
                    };
                };
                if (((!(_local_3)) || (!(this._lastBlendModeApplied == _local_4.blendMode))))
                {
                    this._target.blendMode = _local_4.blendMode;
                    this._lastBlendModeApplied = _local_4.blendMode;
                };
                if ((((!(_local_3)) || (!(this._lastOpaqueBackgroundApplied == _local_4.opaqueBackground))) || (!(this._opaqueBackgroundHasBeenApplied))))
                {
                    this._target.opaqueBackground = _local_4.opaqueBackground;
                    this._opaqueBackgroundHasBeenApplied = true;
                    this._lastOpaqueBackgroundApplied = _local_4.opaqueBackground;
                };
                if ((((!(_local_3)) || (!(this._lastVisibleApplied == _local_4.visible))) || (!(this._visibleHasBeenApplied))))
                {
                    this._target.visible = _local_4.visible;
                    this._visibleHasBeenApplied = true;
                    this._lastVisibleApplied = _local_4.visible;
                };
            };
            this._lastRenderedTime = _arg_1;
            this._lastRenderedMotion = _local_2;
            this.dispatchEvent(new MotionEvent(MotionEvent.MOTION_UPDATE));
        }

        protected function setTime3D(_arg_1:int, _arg_2:MotionBase):Boolean
        {
            return (false);
        }

        protected function setTimeClassic(_arg_1:int, _arg_2:MotionBase, _arg_3:KeyframeBase):Boolean
        {
            return (false);
        }

        public function get targetParent():DisplayObjectContainer
        {
            return (this._targetParent);
        }

        public function set targetParent(_arg_1:DisplayObjectContainer):void
        {
            this._targetParent = _arg_1;
        }

        public function get targetParentButton():SimpleButton
        {
            return (this._targetParentBtn);
        }

        public function set targetParentButton(_arg_1:SimpleButton):*
        {
            this._targetParentBtn = _arg_1;
        }

        public function get targetName():String
        {
            return (this._targetName);
        }

        public function set targetName(_arg_1:String):void
        {
            this._targetName = _arg_1;
        }

        public function get placeholderName():String
        {
            return (this._placeholderName);
        }

        public function set placeholderName(_arg_1:String):void
        {
            this._placeholderName = _arg_1;
        }

        public function get instanceFactoryClass():Class
        {
            return (this._instanceFactoryClass);
        }

        public function set instanceFactoryClass(f:Class):void
        {
            if (f == this._instanceFactoryClass)
            {
                return;
            };
            this._instanceFactoryClass = f;
            try
            {
                this.instanceFactory = this._instanceFactoryClass["getSingleton"]();
            }
            catch(e:Error)
            {
                instanceFactory = null;
            };
        }

        public function useCurrentFrame(_arg_1:Boolean, _arg_2:int):void
        {
            this._useCurrentFrame = _arg_1;
            if (!this.motionArray)
            {
                this._spanStart = _arg_2;
            };
        }

        public function get usingCurrentFrame():Boolean
        {
            return (this._useCurrentFrame);
        }

        public function get spanStart():int
        {
            return (this._spanStart);
        }

        public function get spanEnd():int
        {
            if (this._spanEnd >= 0)
            {
                return (this._spanEnd);
            };
            if (((this._motion) && (this._motion.duration > 0)))
            {
                return ((this._spanStart + this._motion.duration) - 1);
            };
            return (this._spanStart);
        }

        public function get sceneName():String
        {
            return (this._sceneName);
        }

        public function set sceneName(_arg_1:String):void
        {
            this._sceneName = _arg_1;
        }

        private function handleEnterFrame(_arg_1:Event):void
        {
            var _local_2:MovieClip;
            if (this._registeredParent)
            {
                _local_2 = (this._targetParent as MovieClip);
                if (_local_2 == null)
                {
                    return;
                };
                if (((((!(this.usingCurrentFrame)) || (!(_local_2.currentFrame == this._lastFrameHandled))) || (!(_local_2.currentScene.name == this._lastSceneHandled))) || ((this.target == null) && (!(this.instanceFactoryClass == null)))))
                {
                    processCurrentFrame(_local_2, this, false);
                };
                this.removeChildren();
                this._lastFrameHandled = _local_2.currentFrame;
                this._lastSceneHandled = _local_2.currentScene.name;
            }
            else
            {
                this.nextFrame();
            };
        }

        private function removeChildren():void
        {
            var _local_2:Object;
            var _local_3:MovieClip;
            var _local_1:int;
            while (_local_1 < this._toRemove.length)
            {
                _local_2 = this._toRemove[_local_1];
                if (((_local_2.target == this._target) || (!(_local_2.target.parent == this._targetParent))))
                {
                    this._toRemove.splice(_local_1, 1);
                }
                else
                {
                    _local_3 = MovieClip(this._targetParent);
                    if (((_local_2.currentFrame == _local_3.currentFrame) && ((_local_3.scenes.length <= 1) || (_local_2.currentSceneName == _local_3.currentScene.name))))
                    {
                        _local_1++;
                    }
                    else
                    {
                        this.removeChildTarget(_local_3, _local_2.target, _local_2.target.name);
                        this._toRemove.splice(_local_1, 1);
                    };
                };
            };
        }

        protected function removeChildTarget(_arg_1:MovieClip, _arg_2:DisplayObject, _arg_3:String):void
        {
            _arg_1.removeChild(_arg_2);
            if (((_arg_1.hasOwnProperty(_arg_3)) && (_arg_1[_arg_3] == _arg_2)))
            {
                _arg_1[_arg_3] = null;
            };
            this._lastColorTransformApplied = null;
            this._filtersApplied = false;
            this._lastBlendModeApplied = null;
            this._cacheAsBitmapHasBeenApplied = false;
            this._opaqueBackgroundHasBeenApplied = false;
            this._visibleHasBeenApplied = false;
            this._lastMatrixApplied = null;
            this._lastMatrix3DApplied = null;
        }

        public function get frameEvent():String
        {
            return (this._frameEvent);
        }

        public function set frameEvent(_arg_1:String):void
        {
            this._frameEvent = _arg_1;
        }

        public function get targetState3D():Array
        {
            return (this._targetState3D);
        }

        public function set targetState3D(_arg_1:Array):void
        {
            this._targetState3D = _arg_1;
        }

        public function nextFrame(_arg_1:Boolean=false, _arg_2:Boolean=true):void
        {
            if ((((this.motionArray) && (this.time >= this.spanEnd)) || ((!(this.motionArray)) && (this.time >= (this.motion.duration - 1)))))
            {
                this.handleLastFrame(_arg_1, _arg_2);
            }
            else
            {
                this.time++;
            };
        }

        public function play(_arg_1:int=-1, _arg_2:Boolean=true):void
        {
            var _local_3:DisplayObject;
            var _local_4:DisplayObject;
            var _local_5:DisplayObject;
            if (!this._isPlaying)
            {
                if ((((this._target == null) && (this._targetParent)) && (!(this._targetName == ""))))
                {
                    _local_3 = ((this._targetParent.hasOwnProperty(this._targetName)) ? this._targetParent[this._targetName] : this._targetParent.getChildByName(this._targetName));
                    if (((this.instanceFactory == null) || (this.instanceFactory["isTargetForFrame"](_local_3, _arg_1, this.sceneName))))
                    {
                        this.target = _local_3;
                    };
                    if (!this.target)
                    {
                        _local_3 = this._targetParent.getChildByName(this._targetName);
                        if (((this.instanceFactory == null) || (this.instanceFactory["isTargetForFrame"](_local_3, _arg_1, this.sceneName))))
                        {
                            this.target = _local_3;
                        };
                        if ((((!(this.target)) && (this._placeholderName)) && (this.instanceFactory)))
                        {
                            _local_4 = this.instanceFactory["getInstance"](this._targetParent, this._targetName, _arg_1, this.sceneName);
                            if (_local_4)
                            {
                                _local_4.name = this._targetName;
                                this._targetParent[this._targetName] = _local_4;
                                _local_5 = this._targetParent[this._placeholderName];
                                if (!_local_5)
                                {
                                    _local_5 = this._targetParent.getChildByName(this._placeholderName);
                                };
                                if (_local_5)
                                {
                                    this._targetParent.addChildAt(_local_4, (this._targetParent.getChildIndex(_local_5) + 1));
                                }
                                else
                                {
                                    this._targetParent.addChild(_local_4);
                                };
                                this.target = _local_4;
                            };
                        };
                    };
                };
                if (_arg_2)
                {
                    enterFrameBeacon.addEventListener(this.frameEvent, this.handleEnterFrame, false, 0, true);
                };
                if (!this.target)
                {
                    return;
                };
                this._isPlaying = true;
            };
            this.playCount = 0;
            if (_arg_1 > -1)
            {
                this.time = _arg_1;
            }
            else
            {
                this.rewind();
            };
            this.dispatchEvent(new MotionEvent(MotionEvent.MOTION_START));
        }

        public function end(_arg_1:Boolean=false, _arg_2:Boolean=true, _arg_3:Boolean=false):void
        {
            var _local_4:MovieClip;
            if (_arg_2)
            {
                enterFrameBeacon.removeEventListener(this.frameEvent, this.handleEnterFrame);
            };
            this._isPlaying = false;
            this.playCount = 0;
            if (this.autoRewind)
            {
                this.rewind();
            }
            else
            {
                if (((this.motion) && (!(this.time == (this.motion.duration - 1)))))
                {
                    this.time = (this.motion.duration - 1);
                }
                else
                {
                    if (((this.motionArray) && (!(this.time == this._spanEnd))))
                    {
                        this.time = this._spanEnd;
                    };
                };
            };
            if (_arg_1)
            {
                if (((this._targetParent) && (!(this._targetName == ""))))
                {
                    if (((((this._target) && (this.instanceFactory)) && (this._targetParent is MovieClip)) && (this._targetParent == this._target.parent)))
                    {
                        if (_arg_3)
                        {
                            this.removeChildTarget(MovieClip(this._targetParent), this._target, this._targetName);
                        }
                        else
                        {
                            _local_4 = MovieClip(this._targetParent);
                            this._toRemove.push({
                                "target":this._target,
                                "currentFrame":_local_4.currentFrame,
                                "currentSceneName":_local_4.currentScene.name
                            });
                        };
                    };
                    this._target = null;
                };
                this._lastRenderedTime = -1;
                this._time = -1;
            };
            this.dispatchEvent(new MotionEvent(MotionEvent.MOTION_END));
        }

        public function stop():void
        {
            enterFrameBeacon.removeEventListener(this.frameEvent, this.handleEnterFrame);
            this._isPlaying = false;
            this.playCount = 0;
            this.rewind();
            this.dispatchEvent(new MotionEvent(MotionEvent.MOTION_END));
        }

        public function pause():void
        {
            enterFrameBeacon.removeEventListener(this.frameEvent, this.handleEnterFrame);
            this._isPlaying = false;
        }

        public function resume():void
        {
            enterFrameBeacon.addEventListener(this.frameEvent, this.handleEnterFrame, false, 0, true);
            this._isPlaying = true;
        }

        public function startFrameEvents():void
        {
            enterFrameBeacon.addEventListener(this.frameEvent, this.handleEnterFrame, false, 0, true);
        }

        public function rewind():void
        {
            this.time = ((this.motionArray) ? this._spanStart : 0);
        }

        private function placeholderButtonEnterFrameHandler(_arg_1:Event):void
        {
            var _local_3:DisplayObjectContainer;
            if (((this._targetParentBtn == null) || (this.instanceFactory == null)))
            {
                this._target.removeEventListener(this.frameEvent, this.placeholderButtonEnterFrameHandler);
                return;
            };
            var _local_2:DisplayObject = this.instanceFactory["getInstance"](this._targetParentBtn, this._targetName, this._spanStart);
            if (_local_2 == null)
            {
                return;
            };
            this._target.removeEventListener(this.frameEvent, this.placeholderButtonEnterFrameHandler);
            if (((this._target.parent == null) || (DisplayObject(this._target.parent) == this._targetParentBtn)))
            {
                switch (this._spanStart)
                {
                    case 1:
                        this._targetParentBtn.overState = _local_2;
                        break;
                    case 2:
                        this._targetParentBtn.downState = _local_2;
                        break;
                    case 3:
                        this._targetParentBtn.hitTestState = _local_2;
                        break;
                    default:
                        this._targetParentBtn.upState = _local_2;
                };
            }
            else
            {
                _local_3 = (this._target.parent as DisplayObjectContainer);
                if (_local_3 != null)
                {
                    _local_3.addChildAt(_local_2, (_local_3.getChildIndex(this._target) + 1));
                    _local_3.removeChild(this._target);
                };
            };
            this.target = _local_2;
            this.time = 0;
        }

        private function placeholderSpriteEnterFrameHandler(_arg_1:Event):void
        {
            if (((this._targetParent == null) || (this.instanceFactory == null)))
            {
                this._target.removeEventListener(this.frameEvent, this.placeholderSpriteEnterFrameHandler);
                return;
            };
            var _local_2:DisplayObject = this.instanceFactory["getInstance"](this._targetParent, this._targetName, 0);
            if (_local_2 == null)
            {
                return;
            };
            _local_2.name = this._targetName;
            this._targetParent[this._targetName] = _local_2;
            this._target.removeEventListener(this.frameEvent, this.placeholderSpriteEnterFrameHandler);
            this._targetParent[this._placeholderName] = null;
            this._targetParent.addChildAt(_local_2, (this._targetParent.getChildIndex(this._target) + 1));
            this._targetParent.removeChild(this._target);
            this.target = _local_2;
            this.time = 0;
        }

        private function handleLastFrame(_arg_1:Boolean=false, _arg_2:Boolean=true):void
        {
            this.playCount++;
            if (((this.repeatCount == 0) || (this.playCount < this.repeatCount)))
            {
                this.rewind();
            }
            else
            {
                this.end(_arg_1, _arg_2, false);
            };
        }


    }
}//package fl.motion

