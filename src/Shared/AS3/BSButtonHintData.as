// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//Shared.AS3.BSButtonHintData

package Shared.AS3
{
    import flash.events.EventDispatcher;
    import Shared.AS3.Data.UIDataFromClient;
    import Shared.AS3.Data.BSUIDataManager;
    import flash.events.Event;
    import Shared.AS3.Data.FromClientDataEvent;
    import Shared.AS3.Events.PlatformChangeEvent;

    public dynamic class BSButtonHintData extends EventDispatcher 
    {

        public static const BUTTON_HINT_DATA_CHANGE:String = "ButtonHintDataChange";
        public static const EVENT_CONTROL_MAP_DATA:String = "ControlMapData";

        private var _strButtonText:String;
        private var _strPCKey:String;
        private var _strPSNButton:String;
        private var _strXenonButton:String;
        private var _uiJustification:uint;
        private var _callbackFunction:Function;
        private var _bButtonDisabled:Boolean;
        private var _bSecondaryButtonDisabled:Boolean;
        private var _bButtonVisible:Boolean;
        private var _bButtonFlashing:Boolean;
        private var _hasSecondaryButton:Boolean;
        private var _strSecondaryPCKey:String;
        private var _strSecondaryXenonButton:String;
        private var _strSecondaryPSNButton:String;
        private var _secondaryButtonCallback:Function;
        private var m_CanHold:Boolean = false;
        private var m_HoldPercent:Number = 0;
        private var m_bIgnorePCKeyMapping:Boolean = false;
        private var m_UserEventMapping:String = "";
        private var _isWarning:Boolean;
        private var _strDynamicMovieClipName:String;
        public var onAnnounceDataChange:Function;
        public var onTextClick:Function;
        public var onSecondaryButtonClick:Function;

        public function BSButtonHintData(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:uint, _arg_6:Function)
        {
            this.onAnnounceDataChange = this.onAnnounceDataChange_Impl;
            this.onTextClick = this.onTextClick_Impl;
            this.onSecondaryButtonClick = this.onSecondaryButtonClick_Impl;
            super();
            this._strPCKey = _arg_2;
            this._strButtonText = _arg_1;
            this._strXenonButton = _arg_4;
            this._strPSNButton = _arg_3;
            this._uiJustification = _arg_5;
            this._callbackFunction = _arg_6;
            this._bButtonDisabled = false;
            this._bButtonVisible = true;
            this._bButtonFlashing = false;
            this._hasSecondaryButton = false;
            this._strSecondaryPCKey = "";
            this._strSecondaryPSNButton = "";
            this._strSecondaryXenonButton = "";
            this._secondaryButtonCallback = null;
            this._strDynamicMovieClipName = "";
            this._isWarning = false;
        }

        public function get PCKey():String
        {
            return (this._strPCKey);
        }

        public function get PSNButton():String
        {
            return (this._strPSNButton);
        }

        public function get XenonButton():String
        {
            return (this._strXenonButton);
        }

        public function get Justification():uint
        {
            return (this._uiJustification);
        }

        public function get SecondaryPCKey():String
        {
            return (this._strSecondaryPCKey);
        }

        public function get SecondaryPSNButton():String
        {
            return (this._strSecondaryPSNButton);
        }

        public function get SecondaryXenonButton():String
        {
            return (this._strSecondaryXenonButton);
        }

        public function get DynamicMovieClipName():String
        {
            return (this._strDynamicMovieClipName);
        }

        public function set DynamicMovieClipName(_arg_1:String):void
        {
            if (this._strDynamicMovieClipName != _arg_1)
            {
                this._strDynamicMovieClipName = _arg_1;
                this.AnnounceDataChange();
            };
        }

        public function get canHold():Boolean
        {
            return (this.m_CanHold);
        }

        public function set canHold(_arg_1:Boolean):void
        {
            if (this.m_CanHold != _arg_1)
            {
                this.m_CanHold = _arg_1;
                this.AnnounceDataChange();
            };
        }

        public function get holdPercent():Number
        {
            return (this.m_HoldPercent);
        }

        public function set holdPercent(_arg_1:Number):void
        {
            if (this.m_HoldPercent != _arg_1)
            {
                this.m_HoldPercent = _arg_1;
                this.AnnounceDataChange();
            };
        }

        public function get ignorePCKeyMapping():Boolean
        {
            return (this.m_bIgnorePCKeyMapping);
        }

        public function set ignorePCKeyMapping(_arg_1:Boolean):void
        {
            if (this.m_bIgnorePCKeyMapping != _arg_1)
            {
                this.m_bIgnorePCKeyMapping = _arg_1;
                this.AnnounceDataChange();
            };
        }

        public function get userEventMapping():String
        {
            return (this.m_UserEventMapping);
        }

        public function set userEventMapping(_arg_1:String):void
        {
            var _local_2:UIDataFromClient;
            if (this.m_UserEventMapping != _arg_1)
            {
                this.m_UserEventMapping = _arg_1;
                if (this.m_UserEventMapping == "")
                {
                    BSUIDataManager.Unsubscribe(EVENT_CONTROL_MAP_DATA, this.onControlMapData);
                }
                else
                {
                    BSUIDataManager.Subscribe(EVENT_CONTROL_MAP_DATA, this.onControlMapData);
                    _local_2 = BSUIDataManager.GetDataFromClient(EVENT_CONTROL_MAP_DATA);
                    if (((((_local_2) && (_local_2.data)) && (_local_2.data.buttonMappings)) && (!(_local_2.data.uiController == null))))
                    {
                        this.updateButtonsFromMapping(_local_2.data.uiController, _local_2.data.buttonMappings);
                    };
                };
                this.AnnounceDataChange();
            };
        }

        public function get ButtonDisabled():Boolean
        {
            return (this._bButtonDisabled);
        }

        public function set ButtonDisabled(_arg_1:Boolean):*
        {
            if (this._bButtonDisabled != _arg_1)
            {
                this._bButtonDisabled = _arg_1;
                this.AnnounceDataChange();
            };
        }

        public function get ButtonEnabled():Boolean
        {
            return (!(this.ButtonDisabled));
        }

        public function set ButtonEnabled(_arg_1:Boolean):void
        {
            this.ButtonDisabled = (!(_arg_1));
        }

        public function get SecondaryButtonDisabled():Boolean
        {
            return (this._bSecondaryButtonDisabled);
        }

        public function set SecondaryButtonDisabled(_arg_1:Boolean):*
        {
            if (this._bSecondaryButtonDisabled != _arg_1)
            {
                this._bSecondaryButtonDisabled = _arg_1;
                this.AnnounceDataChange();
            };
        }

        public function get SecondaryButtonEnabled():Boolean
        {
            return (!(this.SecondaryButtonDisabled));
        }

        public function set SecondaryButtonEnabled(_arg_1:Boolean):void
        {
            this.SecondaryButtonDisabled = (!(_arg_1));
        }

        public function get ButtonText():String
        {
            return (this._strButtonText);
        }

        public function set ButtonText(_arg_1:String):void
        {
            if (this._strButtonText != _arg_1)
            {
                this._strButtonText = _arg_1;
                this.AnnounceDataChange();
            };
        }

        public function get ButtonVisible():Boolean
        {
            return (this._bButtonVisible);
        }

        public function set ButtonVisible(_arg_1:Boolean):void
        {
            if (this._bButtonVisible != _arg_1)
            {
                this._bButtonVisible = _arg_1;
                this.AnnounceDataChange();
            };
        }

        public function get ButtonFlashing():Boolean
        {
            return (this._bButtonFlashing);
        }

        public function set ButtonFlashing(_arg_1:Boolean):void
        {
            if (this._bButtonFlashing != _arg_1)
            {
                this._bButtonFlashing = _arg_1;
                this.AnnounceDataChange();
            };
        }

        public function get hasSecondaryButton():Boolean
        {
            return (this._hasSecondaryButton);
        }

        public function get IsWarning():Boolean
        {
            return (this._isWarning);
        }

        public function set IsWarning(_arg_1:Boolean):void
        {
            if (this._isWarning != _arg_1)
            {
                this._isWarning = _arg_1;
                this.AnnounceDataChange();
            };
        }

        private function AnnounceDataChange():void
        {
            dispatchEvent(new Event(BUTTON_HINT_DATA_CHANGE));
            if ((this.onAnnounceDataChange is Function))
            {
                this.onAnnounceDataChange();
            };
        }

        private function onAnnounceDataChange_Impl():void
        {
        }

        public function SetButtons(_arg_1:String, _arg_2:String, _arg_3:String):*
        {
            var _local_4:Boolean;
            if (this._strPCKey != _arg_1)
            {
                this._strPCKey = _arg_1;
                _local_4 = true;
            };
            if (this._strPSNButton != _arg_2)
            {
                this._strPSNButton = _arg_2;
                _local_4 = true;
            };
            if (this._strXenonButton != _arg_3)
            {
                this._strXenonButton = _arg_3;
                _local_4 = true;
            };
            if (_local_4)
            {
                this.AnnounceDataChange();
            };
        }

        public function SetSecondaryButtons(_arg_1:String, _arg_2:String, _arg_3:String):*
        {
            this._hasSecondaryButton = true;
            var _local_4:Boolean;
            if (this._strSecondaryPCKey != _arg_1)
            {
                this._strSecondaryPCKey = _arg_1;
                _local_4 = true;
            };
            if (this._strSecondaryPSNButton != _arg_2)
            {
                this._strSecondaryPSNButton = _arg_2;
                _local_4 = true;
            };
            if (this._strSecondaryXenonButton != _arg_3)
            {
                this._strSecondaryXenonButton = _arg_3;
                _local_4 = true;
            };
            if (_local_4)
            {
                this.AnnounceDataChange();
            };
        }

        public function set secondaryButtonCallback(_arg_1:Function):*
        {
            this._secondaryButtonCallback = _arg_1;
        }

        private function onTextClick_Impl():void
        {
            if ((this._callbackFunction is Function))
            {
                this._callbackFunction.call();
            };
        }

        private function onSecondaryButtonClick_Impl():void
        {
            if ((this._secondaryButtonCallback is Function))
            {
                this._secondaryButtonCallback.call();
            };
        }

        private function onControlMapData(_arg_1:FromClientDataEvent):void
        {
            if ((((((!(this.userEventMapping == "")) && (_arg_1)) && (_arg_1.data)) && (_arg_1.data.buttonMappings)) && (!(_arg_1.data.uiController == null))))
            {
                this.updateButtonsFromMapping(_arg_1.data.uiController, _arg_1.data.buttonMappings);
            };
        }

        private function updateButtonsFromMapping(_arg_1:uint, _arg_2:Array):void
        {
            var _local_3:String;
            var _local_4:uint;
            if ((((!(_arg_1 == PlatformChangeEvent.PLATFORM_INVALID)) && (!(this.userEventMapping == ""))) && ((!(this.ignorePCKeyMapping)) || (!(_arg_1 == PlatformChangeEvent.PLATFORM_PC_KB_MOUSE)))))
            {
                _local_3 = "";
                _local_4 = 0;
                while (_local_4 < _arg_2.length)
                {
                    if (_arg_2[_local_4].userEventName == this.userEventMapping)
                    {
                        _local_3 = _arg_2[_local_4].buttonName;
                        break;
                    };
                    _local_4++;
                };
                if (_local_3 != "")
                {
                    switch (_arg_1)
                    {
                        case PlatformChangeEvent.PLATFORM_PC_KB_MOUSE:
                            this.SetButtons(_local_3, this.PSNButton, this.XenonButton);
                            return;
                        case PlatformChangeEvent.PLATFORM_PS4:
                            this.SetButtons(this.PCKey, _local_3, this.XenonButton);
                            return;
                        case PlatformChangeEvent.PLATFORM_PC_GAMEPAD:
                        case PlatformChangeEvent.PLATFORM_XB1:
                            this.SetButtons(this.PCKey, this.PSNButton, _local_3);
                            return;
                    };
                };
            };
        }


    }
}//package Shared.AS3

