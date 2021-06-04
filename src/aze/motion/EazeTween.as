// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//aze.motion.EazeTween

package aze.motion
{
    import aze.motion.easing.Quadratic;
    import flash.utils.Dictionary;
    import flash.display.Shape;
    import aze.motion.specials.EazeSpecial;
    import flash.events.Event;
    import flash.utils.getTimer;
    import flash.filters.ColorMatrixFilter;
    import flash.geom.Rectangle;
    import aze.motion.easing.Linear;

    public final class EazeTween 
    {

        public static var defaultEasing:Function = Quadratic.easeOut;
        public static var defaultDuration:Object = {
            "slow":1,
            "normal":0.4,
            "fast":0.2
        };
        public static const specialProperties:Dictionary = new Dictionary();
        private static const running:Dictionary = new Dictionary();
        private static const ticker:Shape = createTicker();
        private static var pauseTime:Number;
        private static var head:EazeTween;
        private static var tweenCount:int = 0;

        private var prev:EazeTween;
        private var next:EazeTween;
        private var rnext:EazeTween;
        private var isDead:Boolean;
        private var target:Object;
        private var reversed:Boolean;
        private var overwrite:Boolean;
        private var autoStart:Boolean;
        private var _configured:Boolean;
        private var _started:Boolean;
        private var _inited:Boolean;
        private var duration:*;
        private var _duration:Number;
        private var _ease:Function;
        private var startTime:Number;
        private var endTime:Number;
        private var properties:EazeProperty;
        private var specials:EazeSpecial;
        private var autoVisible:Boolean;
        private var slowTween:Boolean;
        private var _chain:Array;
        private var _onStart:Function;
        private var _onStartArgs:Array;
        private var _onUpdate:Function;
        private var _onUpdateArgs:Array;
        private var _onComplete:Function;
        private var _onCompleteArgs:Array;

        {
            specialProperties.alpha = true;
            specialProperties.alphaVisible = true;
            specialProperties.scale = true;
        }

        public function EazeTween(_arg_1:Object, _arg_2:Boolean=true)
        {
            if (!_arg_1)
            {
                throw (new ArgumentError("EazeTween: target can not be null"));
            };
            this.target = _arg_1;
            this.autoStart = _arg_2;
            this._ease = defaultEasing;
        }

        public static function killAllTweens():void
        {
            var _local_1:Object;
            for (_local_1 in running)
            {
                killTweensOf(_local_1);
            };
        }

        public static function killTweensOf(_arg_1:Object):void
        {
            var _local_3:EazeTween;
            if (!_arg_1)
            {
                return;
            };
            var _local_2:EazeTween = running[_arg_1];
            while (_local_2)
            {
                _local_2.isDead = true;
                _local_2.dispose();
                if (_local_2.rnext)
                {
                    _local_3 = _local_2;
                    _local_2 = _local_2.rnext;
                    _local_3.rnext = null;
                }
                else
                {
                    _local_2 = null;
                };
            };
            delete running[_arg_1];
        }

        public static function pauseAllTweens():void
        {
            if (ticker.hasEventListener(Event.ENTER_FRAME))
            {
                pauseTime = getTimer();
                ticker.removeEventListener(Event.ENTER_FRAME, tick);
            };
        }

        public static function resumeAllTweens():void
        {
            var _local_1:Number;
            var _local_2:EazeTween;
            if (!ticker.hasEventListener(Event.ENTER_FRAME))
            {
                _local_1 = (getTimer() - pauseTime);
                _local_2 = head;
                while (_local_2)
                {
                    _local_2.startTime = (_local_2.startTime + _local_1);
                    _local_2.endTime = (_local_2.endTime + _local_1);
                    _local_2 = _local_2.next;
                };
                ticker.addEventListener(Event.ENTER_FRAME, tick);
            };
        }

        private static function createTicker():Shape
        {
            var _local_1:Shape = new Shape();
            _local_1.addEventListener(Event.ENTER_FRAME, tick);
            return (_local_1);
        }

        private static function tick(_arg_1:Event):void
        {
            if (head)
            {
                updateTweens(getTimer());
            };
        }

        private static function updateTweens(_arg_1:int):void
        {
            var _local_6:Boolean;
            var _local_7:Number;
            var _local_8:Number;
            var _local_9:Object;
            var _local_10:EazeProperty;
            var _local_11:EazeSpecial;
            var _local_12:EazeTween;
            var _local_13:EazeTween;
            var _local_14:CompleteData;
            var _local_15:int;
            var _local_2:Array = [];
            var _local_3:int;
            var _local_4:EazeTween = head;
            var _local_5:int;
            while (_local_4)
            {
                _local_5++;
                if (_local_4.isDead)
                {
                    _local_6 = true;
                }
                else
                {
                    _local_6 = (_arg_1 >= _local_4.endTime);
                    _local_7 = ((_local_6) ? 1 : ((_arg_1 - _local_4.startTime) / _local_4._duration));
                    _local_8 = _local_4._ease(((_local_7) || (0)));
                    _local_9 = _local_4.target;
                    _local_10 = _local_4.properties;
                    while (_local_10)
                    {
                        _local_9[_local_10.name] = (_local_10.start + (_local_10.delta * _local_8));
                        _local_10 = _local_10.next;
                    };
                    if (_local_4.slowTween)
                    {
                        if (_local_4.autoVisible)
                        {
                            _local_9.visible = (_local_9.alpha > 0.001);
                        };
                        if (_local_4.specials)
                        {
                            _local_11 = _local_4.specials;
                            while (_local_11)
                            {
                                _local_11.update(_local_8, _local_6);
                                _local_11 = _local_11.next;
                            };
                        };
                        if (_local_4._onStart != null)
                        {
                            _local_4._onStart.apply(null, _local_4._onStartArgs);
                            _local_4._onStart = null;
                            _local_4._onStartArgs = null;
                        };
                        if (_local_4._onUpdate != null)
                        {
                            _local_4._onUpdate.apply(null, _local_4._onUpdateArgs);
                        };
                    };
                };
                if (_local_6)
                {
                    if (_local_4._started)
                    {
                        _local_14 = new CompleteData(_local_4._onComplete, _local_4._onCompleteArgs, _local_4._chain, (_local_4.endTime - _arg_1));
                        _local_4._chain = null;
                        _local_2.unshift(_local_14);
                        _local_3++;
                    };
                    _local_4.isDead = true;
                    _local_4.detach();
                    _local_4.dispose();
                    _local_12 = _local_4;
                    _local_13 = _local_4.prev;
                    _local_4 = _local_12.next;
                    if (_local_13)
                    {
                        _local_13.next = _local_4;
                        if (_local_4)
                        {
                            _local_4.prev = _local_13;
                        };
                    }
                    else
                    {
                        head = _local_4;
                        if (_local_4)
                        {
                            _local_4.prev = null;
                        };
                    };
                    _local_12.prev = (_local_12.next = null);
                }
                else
                {
                    _local_4 = _local_4.next;
                };
            };
            if (_local_3)
            {
                _local_15 = 0;
                while (_local_15 < _local_3)
                {
                    _local_2[_local_15].execute();
                    _local_15++;
                };
            };
            tweenCount = _local_5;
        }


        private function configure(_arg_1:*, _arg_2:Object=null, _arg_3:Boolean=false):void
        {
            var _local_4:String;
            var _local_5:*;
            this._configured = true;
            this.reversed = _arg_3;
            this.duration = _arg_1;
            if (_arg_2)
            {
                for (_local_4 in _arg_2)
                {
                    _local_5 = _arg_2[_local_4];
                    if ((_local_4 in specialProperties))
                    {
                        if (_local_4 == "alpha")
                        {
                            this.autoVisible = true;
                            this.slowTween = true;
                        }
                        else
                        {
                            if (_local_4 == "alphaVisible")
                            {
                                _local_4 = "alpha";
                                this.autoVisible = false;
                            }
                            else
                            {
                                if (!(_local_4 in this.target))
                                {
                                    if (_local_4 == "scale")
                                    {
                                        this.configure(_arg_1, {
                                            "scaleX":_local_5,
                                            "scaleY":_local_5
                                        }, _arg_3);
                                        continue;
                                    };
                                    this.specials = new (specialProperties[_local_4])(this.target, _local_4, _local_5, this.specials);
                                    this.slowTween = true;
                                    continue;
                                };
                            };
                        };
                    };
                    if (((_local_5 is Array) && (this.target[_local_4] is Number)))
                    {
                        if (("__bezier" in specialProperties))
                        {
                            this.specials = new (specialProperties["__bezier"])(this.target, _local_4, _local_5, this.specials);
                            this.slowTween = true;
                        };
                    }
                    else
                    {
                        this.properties = new EazeProperty(_local_4, _local_5, this.properties);
                    };
                };
            };
        }

        public function start(_arg_1:Boolean=true, _arg_2:Number=0):void
        {
            if (this._started)
            {
                return;
            };
            if (!this._inited)
            {
                this.init();
            };
            this.overwrite = _arg_1;
            this.startTime = (getTimer() + _arg_2);
            this._duration = (((isNaN(this.duration)) ? this.smartDuration(String(this.duration)) : Number(this.duration)) * 1000);
            this.endTime = (this.startTime + this._duration);
            if (((this.reversed) || (this._duration == 0)))
            {
                this.update(this.startTime);
            };
            if (((this.autoVisible) && (this._duration > 0)))
            {
                this.target.visible = true;
            };
            this._started = true;
            this.attach(this.overwrite);
        }

        private function init():void
        {
            if (this._inited)
            {
                return;
            };
            var _local_1:EazeProperty = this.properties;
            while (_local_1)
            {
                _local_1.init(this.target, this.reversed);
                _local_1 = _local_1.next;
            };
            var _local_2:EazeSpecial = this.specials;
            while (_local_2)
            {
                _local_2.init(this.reversed);
                _local_2 = _local_2.next;
            };
            this._inited = true;
        }

        private function smartDuration(_arg_1:String):Number
        {
            var _local_2:EazeSpecial;
            if ((_arg_1 in defaultDuration))
            {
                return (defaultDuration[_arg_1]);
            };
            if (_arg_1 == "auto")
            {
                _local_2 = this.specials;
                while (_local_2)
                {
                    if (("getPreferredDuration" in _local_2))
                    {
                        return (_local_2["getPreferredDuration"]());
                    };
                    _local_2 = _local_2.next;
                };
            };
            return (defaultDuration.normal);
        }

        public function easing(_arg_1:Function):EazeTween
        {
            this._ease = ((_arg_1) || (defaultEasing));
            return (this);
        }

        public function filter(_arg_1:*, _arg_2:Object, _arg_3:Boolean=false):EazeTween
        {
            if (!_arg_2)
            {
                _arg_2 = {};
            };
            if (_arg_3)
            {
                _arg_2.remove = true;
            };
            this.addSpecial(_arg_1, _arg_1, _arg_2);
            return (this);
        }

        public function tint(_arg_1:*=null, _arg_2:Number=1, _arg_3:Number=NaN):EazeTween
        {
            if (isNaN(_arg_3))
            {
                _arg_3 = (1 - _arg_2);
            };
            this.addSpecial("tint", "tint", [_arg_1, _arg_2, _arg_3]);
            return (this);
        }

        public function colorMatrix(_arg_1:Number=0, _arg_2:Number=0, _arg_3:Number=0, _arg_4:Number=0, _arg_5:uint=0xFFFFFF, _arg_6:Number=0):EazeTween
        {
            var _local_7:Boolean = (((((!(_arg_1)) && (!(_arg_2))) && (!(_arg_3))) && (!(_arg_4))) && (!(_arg_6)));
            return (this.filter(ColorMatrixFilter, {
                "brightness":_arg_1,
                "contrast":_arg_2,
                "saturation":_arg_3,
                "hue":_arg_4,
                "tint":_arg_5,
                "colorize":_arg_6
            }, _local_7));
        }

        public function short(_arg_1:Number, _arg_2:String="rotation", _arg_3:Boolean=false):EazeTween
        {
            this.addSpecial("__short", _arg_2, [_arg_1, _arg_3]);
            return (this);
        }

        public function rect(_arg_1:Rectangle, _arg_2:String="scrollRect"):EazeTween
        {
            this.addSpecial("__rect", _arg_2, _arg_1);
            return (this);
        }

        private function addSpecial(_arg_1:*, _arg_2:*, _arg_3:Object):void
        {
            if (((_arg_1 in specialProperties) && (this.target)))
            {
                if ((((!(this._inited)) || (this._duration == 0)) && (this.autoStart)))
                {
                    EazeSpecial(new (specialProperties[_arg_1])(this.target, _arg_2, _arg_3, null)).init(true);
                }
                else
                {
                    this.specials = new (specialProperties[_arg_1])(this.target, _arg_2, _arg_3, this.specials);
                    if (this._started)
                    {
                        this.specials.init(this.reversed);
                    };
                    this.slowTween = true;
                };
            };
        }

        public function onStart(_arg_1:Function, ... _args):EazeTween
        {
            this._onStart = _arg_1;
            this._onStartArgs = _args;
            this.slowTween = ((((!(this.autoVisible)) || (!(this.specials == null))) || (!(this._onUpdate == null))) || (!(this._onStart == null)));
            return (this);
        }

        public function onUpdate(_arg_1:Function, ... _args):EazeTween
        {
            this._onUpdate = _arg_1;
            this._onUpdateArgs = _args;
            this.slowTween = ((((!(this.autoVisible)) || (!(this.specials == null))) || (!(this._onUpdate == null))) || (!(this._onStart == null)));
            return (this);
        }

        public function onComplete(_arg_1:Function, ... _args):EazeTween
        {
            this._onComplete = _arg_1;
            this._onCompleteArgs = _args;
            return (this);
        }

        public function kill(_arg_1:Boolean=false):void
        {
            if (this.isDead)
            {
                return;
            };
            if (_arg_1)
            {
                this._onUpdate = (this._onComplete = null);
                this.update(this.endTime);
            }
            else
            {
                this.detach();
                this.dispose();
            };
            this.isDead = true;
        }

        public function killTweens():EazeTween
        {
            EazeTween.killTweensOf(this.target);
            return (this);
        }

        public function updateNow():EazeTween
        {
            var _local_1:Number;
            if (this._started)
            {
                _local_1 = Math.max(this.startTime, getTimer());
                this.update(_local_1);
            }
            else
            {
                this.init();
                this.endTime = (this._duration = 1);
                this.update(0);
            };
            return (this);
        }

        private function update(_arg_1:Number):void
        {
            var _local_2:EazeTween = head;
            head = this;
            updateTweens(_arg_1);
            head = _local_2;
        }

        private function attach(_arg_1:Boolean):void
        {
            var _local_2:EazeTween;
            if (_arg_1)
            {
                killTweensOf(this.target);
            }
            else
            {
                _local_2 = running[this.target];
            };
            if (_local_2)
            {
                this.prev = _local_2;
                this.next = _local_2.next;
                if (this.next)
                {
                    this.next.prev = this;
                };
                _local_2.next = this;
                this.rnext = _local_2;
            }
            else
            {
                if (head)
                {
                    head.prev = this;
                };
                this.next = head;
                head = this;
            };
            running[this.target] = this;
        }

        private function detach():void
        {
            var _local_1:EazeTween;
            var _local_2:EazeTween;
            if (((this.target) && (this._started)))
            {
                _local_1 = running[this.target];
                if (_local_1 == this)
                {
                    if (this.rnext)
                    {
                        running[this.target] = this.rnext;
                    }
                    else
                    {
                        delete running[this.target];
                    };
                }
                else
                {
                    if (_local_1)
                    {
                        _local_2 = _local_1;
                        _local_1 = _local_1.rnext;
                        while (_local_1)
                        {
                            if (_local_1 == this)
                            {
                                _local_2.rnext = this.rnext;
                                break;
                            };
                            _local_2 = _local_1;
                            _local_1 = _local_1.rnext;
                        };
                    };
                };
                this.rnext = null;
            };
        }

        private function dispose():void
        {
            var _local_1:EazeTween;
            if (this._started)
            {
                this.target = null;
                this._onComplete = null;
                this._onCompleteArgs = null;
                if (this._chain)
                {
                    for each (_local_1 in this._chain)
                    {
                        _local_1.dispose();
                    };
                    this._chain = null;
                };
            };
            if (this.properties)
            {
                this.properties.dispose();
                this.properties = null;
            };
            this._ease = null;
            this._onStart = null;
            this._onStartArgs = null;
            if (this.slowTween)
            {
                if (this.specials)
                {
                    this.specials.dispose();
                    this.specials = null;
                };
                this.autoVisible = false;
                this._onUpdate = null;
                this._onUpdateArgs = null;
            };
        }

        public function delay(_arg_1:*, _arg_2:Boolean=true):EazeTween
        {
            return (this.add(_arg_1, null, _arg_2));
        }

        public function apply(_arg_1:Object=null, _arg_2:Boolean=true):EazeTween
        {
            return (this.add(0, _arg_1, _arg_2));
        }

        public function play(_arg_1:*=0, _arg_2:Boolean=true):EazeTween
        {
            return (this.add("auto", {"frame":_arg_1}, _arg_2).easing(Linear.easeNone));
        }

        public function to(_arg_1:*, _arg_2:Object=null, _arg_3:Boolean=true):EazeTween
        {
            return (this.add(_arg_1, _arg_2, _arg_3));
        }

        public function from(_arg_1:*, _arg_2:Object=null, _arg_3:Boolean=true):EazeTween
        {
            return (this.add(_arg_1, _arg_2, _arg_3, true));
        }

        private function add(_arg_1:*, _arg_2:Object, _arg_3:Boolean, _arg_4:Boolean=false):EazeTween
        {
            if (this.isDead)
            {
                return (new EazeTween(this.target).add(_arg_1, _arg_2, _arg_3, _arg_4));
            };
            if (this._configured)
            {
                return (this.chain().add(_arg_1, _arg_2, _arg_3, _arg_4));
            };
            this.configure(_arg_1, _arg_2, _arg_4);
            if (this.autoStart)
            {
                this.start(_arg_3);
            };
            return (this);
        }

        public function chain(_arg_1:Object=null):EazeTween
        {
            var _local_2:EazeTween = new EazeTween(((_arg_1) || (this.target)), false);
            if (!this._chain)
            {
                this._chain = [];
            };
            this._chain.push(_local_2);
            return (_local_2);
        }

        public function get isStarted():Boolean
        {
            return (this._started);
        }

        public function get isFinished():Boolean
        {
            return (this.isDead);
        }


    }
}//package aze.motion

import aze.motion.EazeTween;

final class EazeProperty 
{

    public var name:String;
    public var start:Number;
    public var end:Number;
    public var delta:Number;
    public var next:EazeProperty;

    public function EazeProperty(_arg_1:String, _arg_2:Number, _arg_3:EazeProperty)
    {
        this.name = _arg_1;
        this.end = _arg_2;
        this.next = _arg_3;
    }

    public function init(_arg_1:Object, _arg_2:Boolean):void
    {
        if (_arg_2)
        {
            this.start = this.end;
            this.end = _arg_1[this.name];
            _arg_1[this.name] = this.start;
        }
        else
        {
            this.start = _arg_1[this.name];
        };
        this.delta = (this.end - this.start);
    }

    public function dispose():void
    {
        if (this.next)
        {
            this.next.dispose();
        };
        this.next = null;
    }


}

final class CompleteData 
{

    /*private*/ var callback:Function;
    /*private*/ var args:Array;
    /*private*/ var chain:Array;
    /*private*/ var diff:Number;

    public function CompleteData(_arg_1:Function, _arg_2:Array, _arg_3:Array, _arg_4:Number)
    {
        this.callback = _arg_1;
        this.args = _arg_2;
        this.chain = _arg_3;
        this.diff = _arg_4;
    }

    public function execute():void
    {
        var _local_1:int;
        var _local_2:int;
        if (this.callback != null)
        {
            this.callback.apply(null, this.args);
            this.callback = null;
        };
        this.args = null;
        if (this.chain)
        {
            _local_1 = this.chain.length;
            _local_2 = 0;
            while (_local_2 < _local_1)
            {
                EazeTween(this.chain[_local_2]).start(false, this.diff);
                _local_2++;
            };
            this.chain = null;
        };
    }


}


