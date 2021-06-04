// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//Shared.AS3.Data.BSUIDataManager

package Shared.AS3.Data
{
    import flash.events.Event;

    public final class BSUIDataManager extends UsesEventDispatcherBackend 
    {

        private static var _instance:BSUIDataManager;

        private var m_DataShuttleConnector:UIDataShuttleConnector;
        private var m_TestConnector:UIDataShuttleTestConnector;
        private var m_Providers:Object;

        public function BSUIDataManager()
        {
            if (_instance != null)
            {
                throw (new Error((this + " is a Singleton. Access using getInstance()")));
            };
            this.m_TestConnector = new UIDataShuttleTestConnector();
            this.m_Providers = new Object();
        }

        private static function GetInstance():BSUIDataManager
        {
            if (!_instance)
            {
                _instance = new (BSUIDataManager)();
            };
            return (_instance);
        }

        public static function ConnectDataShuttleConnector(_arg_1:UIDataShuttleConnector):UIDataShuttleConnector
        {
            var _local_3:UIDataFromClient;
            var _local_4:String;
            var _local_5:Array;
            var _local_2:BSUIDataManager = GetInstance();
            if (_local_2.m_DataShuttleConnector == null)
            {
                _local_2.m_DataShuttleConnector = _arg_1;
                _local_3 = null;
                _local_5 = new Array();
                for (_local_4 in _local_2.m_Providers)
                {
                    _local_3 = _local_2.m_Providers[_local_4];
                    _arg_1.Watch(_local_4, false, _local_3);
                };
                for (_local_4 in _local_2.m_Providers)
                {
                    _local_3 = _local_2.m_Providers[_local_4];
                    if (!_local_3.isTest)
                    {
                        _local_3.DispatchChange();
                    };
                };
            };
            return (_local_2.m_DataShuttleConnector);
        }

        public static function InitDataManager(_arg_1:BSUIEventDispatcherBackend):void
        {
            GetInstance().eventDispatcherBackend = _arg_1;
        }

        public static function Subscribe(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):Function
        {
            var _local_4:UIDataFromClient = BSUIDataManager.GetDataFromClient(_arg_1, true, _arg_3);
            if (_local_4 != null)
            {
                _local_4.addEventListener(Event.CHANGE, _arg_2);
                return (_arg_2);
            };
            throw (Error(("Couldn't subscribe to data provider: " + _arg_1)));
        }

        public static function Flush(_arg_1:Array):*
        {
            var _local_5:UIDataFromClient;
            var _local_2:Number = _arg_1.length;
            var _local_3:BSUIDataManager = GetInstance();
            var _local_4:uint;
            while (_local_4 < _local_2)
            {
                _local_5 = _local_3.m_Providers[_arg_1[_local_4]];
                _local_5.DispatchChange();
                _local_4++;
            };
        }

        public static function Unsubscribe(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            var _local_4:UIDataFromClient = BSUIDataManager.GetDataFromClient(_arg_1, true, _arg_3);
            if (_local_4 != null)
            {
                _local_4.removeEventListener(Event.CHANGE, _arg_2);
            };
        }

        public static function GetDataFromClient(_arg_1:String, _arg_2:Boolean=true, _arg_3:Boolean=false):UIDataFromClient
        {
            var _local_5:UIDataShuttleConnector;
            var _local_6:UIDataShuttleTestConnector;
            var _local_7:UIDataFromClient;
            var _local_4:BSUIDataManager = GetInstance();
            if (((_local_4.m_Providers[_arg_1] == null) && (_arg_2)))
            {
                _local_5 = _local_4.m_DataShuttleConnector;
                _local_6 = _local_4.m_TestConnector;
                _local_7 = null;
                if (_local_5)
                {
                    _local_7 = _local_5.Watch(_arg_1, true);
                };
                if (!_local_7)
                {
                    if (_arg_3)
                    {
                        _local_7 = _local_6.Watch(_arg_1, true);
                    }
                    else
                    {
                        _local_7 = new UIDataFromClient(new Object());
                        _local_7.isTest = true;
                    };
                };
                _local_4.m_Providers[_arg_1] = _local_7;
            };
            return (_local_4.m_Providers[_arg_1]);
        }

        public static function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            GetInstance().addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public static function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            GetInstance().removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public static function dispatchEvent(_arg_1:Event):Boolean
        {
            return (GetInstance().dispatchEvent(_arg_1));
        }

        public static function hasEventListener(_arg_1:String):Boolean
        {
            return (GetInstance().hasEventListener(_arg_1));
        }

        public static function willTrigger(_arg_1:String):Boolean
        {
            return (GetInstance().willTrigger(_arg_1));
        }


    }
}//package Shared.AS3.Data

