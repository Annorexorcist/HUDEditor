// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//fl.transitions.Tween

package fl.transitions
{
    import flash.events.EventDispatcher;
    import flash.display.MovieClip;
    import flash.utils.Timer;
    import flash.events.Event;
    import flash.events.TimerEvent;
    import flash.utils.getTimer;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class Tween extends EventDispatcher 
    {

        protected static var _mc:MovieClip = new MovieClip();

        public var isPlaying:Boolean = false;
        public var obj:Object = null;
        public var prop:String = "";
        public var func:Function;
        public var begin:Number = NaN;
        public var change:Number = NaN;
        public var useSeconds:Boolean = false;
        public var prevTime:Number = NaN;
        public var prevPos:Number = NaN;
        public var looping:Boolean = false;
        private var _duration:Number = NaN;
        private var _time:Number = NaN;
        private var _fps:Number = NaN;
        private var _position:Number = NaN;
        private var _startTime:Number = NaN;
        private var _intervalID:uint = 0;
        private var _finish:Number = NaN;
        private var _timer:Timer = null;

        public function Tween(_arg_1:Object, _arg_2:String, _arg_3:Function, _arg_4:Number, _arg_5:Number, _arg_6:Number, _arg_7:Boolean=false)
        {
            this.func = function (_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number):Number
            {
                return (((_arg_3 * _arg_1) / _arg_4) + _arg_2);
            };
            super();
            if (!arguments.length)
            {
                return;
            };
            this.obj = _arg_1;
            this.prop = _arg_2;
            this.begin = _arg_4;
            this.position = _arg_4;
            this.duration = _arg_6;
            this.useSeconds = _arg_7;
            if ((_arg_3 is Function))
            {
                this.func = _arg_3;
            };
            this.finish = _arg_5;
            this._timer = new Timer(100);
            this.start();
        }

        public function get time():Number
        {
            return (this._time);
        }

        public function set time(_arg_1:Number):void
        {
            this.prevTime = this._time;
            if (_arg_1 > this.duration)
            {
                if (this.looping)
                {
                    this.rewind((_arg_1 - this._duration));
                    this.update();
                    this.dispatchEvent(new TweenEvent(TweenEvent.MOTION_LOOP, this._time, this._position));
                }
                else
                {
                    if (this.useSeconds)
                    {
                        this._time = this._duration;
                        this.update();
                    };
                    this.stop();
                    this.dispatchEvent(new TweenEvent(TweenEvent.MOTION_FINISH, this._time, this._position));
                };
            }
            else
            {
                if (_arg_1 < 0)
                {
                    this.rewind();
                    this.update();
                }
                else
                {
                    this._time = _arg_1;
                    this.update();
                };
            };
        }

        public function get duration():Number
        {
            return (this._duration);
        }

        public function set duration(_arg_1:Number):void
        {
            this._duration = ((_arg_1 <= 0) ? Infinity : _arg_1);
        }

        public function get FPS():Number
        {
            return (this._fps);
        }

        public function set FPS(_arg_1:Number):void
        {
            var _local_2:Boolean = this.isPlaying;
            this.stopEnterFrame();
            this._fps = _arg_1;
            if (_local_2)
            {
                this.startEnterFrame();
            };
        }

        public function get position():Number
        {
            return (this.getPosition(this._time));
        }

        public function set position(_arg_1:Number):void
        {
            this.setPosition(_arg_1);
        }

        public function getPosition(_arg_1:Number=NaN):Number
        {
            if (isNaN(_arg_1))
            {
                _arg_1 = this._time;
            };
            return (this.func(_arg_1, this.begin, this.change, this._duration));
        }

        public function setPosition(_arg_1:Number):void
        {
            this.prevPos = this._position;
            if (this.prop.length)
            {
                this.obj[this.prop] = (this._position = _arg_1);
            };
            this.dispatchEvent(new TweenEvent(TweenEvent.MOTION_CHANGE, this._time, this._position));
        }

        public function get finish():Number
        {
            return (this.begin + this.change);
        }

        public function set finish(_arg_1:Number):void
        {
            this.change = (_arg_1 - this.begin);
        }

        public function continueTo(_arg_1:Number, _arg_2:Number):void
        {
            this.begin = this.position;
            this.finish = _arg_1;
            if (!isNaN(_arg_2))
            {
                this.duration = _arg_2;
            };
            this.start();
        }

        public function yoyo():void
        {
            this.continueTo(this.begin, this.time);
        }

        protected function startEnterFrame():void
        {
            var _local_1:Number;
            if (isNaN(this._fps))
            {
                _mc.addEventListener(Event.ENTER_FRAME, this.onEnterFrame, false, 0, true);
            }
            else
            {
                _local_1 = (1000 / this._fps);
                this._timer.delay = _local_1;
                this._timer.addEventListener(TimerEvent.TIMER, this.timerHandler, false, 0, true);
                this._timer.start();
            };
            this.isPlaying = true;
        }

        protected function stopEnterFrame():void
        {
            if (isNaN(this._fps))
            {
                _mc.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            }
            else
            {
                this._timer.stop();
            };
            this.isPlaying = false;
        }

        public function start():void
        {
            this.rewind();
            this.startEnterFrame();
            this.dispatchEvent(new TweenEvent(TweenEvent.MOTION_START, this._time, this._position));
        }

        public function stop():void
        {
            this.stopEnterFrame();
            this.dispatchEvent(new TweenEvent(TweenEvent.MOTION_STOP, this._time, this._position));
        }

        public function resume():void
        {
            this.fixTime();
            this.startEnterFrame();
            this.dispatchEvent(new TweenEvent(TweenEvent.MOTION_RESUME, this._time, this._position));
        }

        public function rewind(_arg_1:Number=0):void
        {
            this._time = _arg_1;
            this.fixTime();
            this.update();
        }

        public function fforward():void
        {
            this.time = this._duration;
            this.fixTime();
        }

        public function nextFrame():void
        {
            if (this.useSeconds)
            {
                this.time = ((getTimer() - this._startTime) / 1000);
            }
            else
            {
                this.time = (this._time + 1);
            };
        }

        protected function onEnterFrame(_arg_1:Event):void
        {
            this.nextFrame();
        }

        protected function timerHandler(_arg_1:TimerEvent):void
        {
            this.nextFrame();
            _arg_1.updateAfterEvent();
        }

        public function prevFrame():void
        {
            if (!this.useSeconds)
            {
                this.time = (this._time - 1);
            };
        }

        private function fixTime():void
        {
            if (this.useSeconds)
            {
                this._startTime = (getTimer() - (this._time * 1000));
            };
        }

        private function update():void
        {
            this.setPosition(this.getPosition(this._time));
        }


    }
}//package fl.transitions

