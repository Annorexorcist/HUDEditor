// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//Shared.AS3.MenuComponent

package Shared.AS3
{
    import __AS3__.vec.Vector;
    import Shared.AS3.Events.MenuComponentLoadedEvent;
    import flash.events.Event;
    import __AS3__.vec.*;

    public dynamic class MenuComponent extends BSUIComponent 
    {

        private var _ButtonData:Vector.<BSButtonHintData>;
        private var _ButtonHintBar:BSButtonHintBar;
        protected var _active:Boolean = false;
        private var _targetButtonHintBar:Object;

        public function MenuComponent()
        {
            this._ButtonData = new Vector.<BSButtonHintData>();
            super();
            this.buttonHintBarTarget_Inspectable = "ButtonHintBar_mc";
        }

        public function get Active():Boolean
        {
            return (this._active);
        }

        public function set Active(_arg_1:*):void
        {
            this._active = _arg_1;
            this.connectButtonBar();
        }

        public function get buttonHintBar():BSButtonHintBar
        {
            return (this._ButtonHintBar);
        }

        public function set buttonHintBar(_arg_1:BSButtonHintBar):*
        {
            this._ButtonHintBar = _arg_1;
        }

        public function get buttonData():Vector.<BSButtonHintData>
        {
            return (this._ButtonData);
        }

        public function set buttonData(_arg_1:Vector.<BSButtonHintData>):void
        {
            this._ButtonData = _arg_1;
        }

        private function onEnterFrame(_arg_1:Event):*
        {
            stage.dispatchEvent(new MenuComponentLoadedEvent(this));
            removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
        }

        override public function onAddedToStage():void
        {
            super.onAddedToStage();
            addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
        }

        public function SetParentMenu(_arg_1:IMenu):*
        {
            this.buttonHintBar = _arg_1.buttonHintBar;
            this.connectButtonBar();
        }

        public function get buttonHintBarTarget_Inspectable():Object
        {
            return (this._targetButtonHintBar);
        }

        public function set buttonHintBarTarget_Inspectable(_arg_1:Object):void
        {
            var _local_2:* = Object;
            if ((_arg_1 is String))
            {
                if (((_arg_1.toString() == "") || (parent == null)))
                {
                    return;
                };
                _local_2 = (parent.getChildByName(_arg_1.toString()) as Object);
                if (_local_2 == null)
                {
                    if (parent.parent)
                    {
                        _local_2 = parent.parent.getChildByName(_arg_1.toString());
                        if (_local_2 == null)
                        {
                            return;
                        };
                    };
                };
            }
            else
            {
                _local_2 = _arg_1;
            };
            this._targetButtonHintBar = _local_2;
            this.buttonHintBar = (this._targetButtonHintBar as BSButtonHintBar);
        }

        public function AddButtonHintData(_arg_1:BSButtonHintData):void
        {
            if (!this.HasButtonHintData(_arg_1))
            {
                this.buttonData.splice(0, 0, _arg_1);
            };
        }

        public function RemoveButtonHintData(_arg_1:BSButtonHintData):*
        {
            var _local_2:uint;
            while (_local_2 < this.buttonData.length)
            {
                if (this.buttonData[_local_2] == _arg_1)
                {
                    this.buttonData.splice(_local_2, 1);
                    return;
                };
                _local_2++;
            };
        }

        public function HasButtonHintData(_arg_1:BSButtonHintData):Boolean
        {
            var _local_2:uint;
            while (_local_2 < this.buttonData.length)
            {
                if (this.buttonData[_local_2] == _arg_1)
                {
                    return (true);
                };
                _local_2++;
            };
            return (false);
        }

        public function connectButtonBar():*
        {
            if ((((!(this.buttonHintBar == null)) && (!(this.buttonData == null))) && (this._active)))
            {
                this.buttonHintBar.SetButtonHintData(this.buttonData);
            };
        }

        public function ProcessUserEvent(_arg_1:String, _arg_2:Boolean):Boolean
        {
            return (false);
        }


    }
}//package Shared.AS3

