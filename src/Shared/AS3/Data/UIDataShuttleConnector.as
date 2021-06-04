// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//Shared.AS3.Data.UIDataShuttleConnector

package Shared.AS3.Data
{
    public class UIDataShuttleConnector 
    {

        public var _Watch:Function;
        public var _RemoveWatch:Function;


        public function AttachToDataManager():Boolean
        {
            var _local_1:UIDataShuttleConnector = BSUIDataManager.ConnectDataShuttleConnector(this);
            return (_local_1 == this);
        }

        public function Watch(_arg_1:String, _arg_2:Boolean, _arg_3:UIDataFromClient=null):UIDataFromClient
        {
            var _local_6:String;
            var _local_4:Object = new Object();
            var _local_5:UIDataFromClient = _arg_3;
            if (!_local_5)
            {
                _local_5 = new UIDataFromClient(_local_4);
            }
            else
            {
                _local_4 = _local_5.data;
                for (_local_6 in _local_4)
                {
                    _local_4[_local_6] = undefined;
                };
            };
            if (this._Watch(_arg_1, _local_4))
            {
                _local_5.isTest = false;
                _local_5.SetReady(_arg_2);
                return (_local_5);
            };
            return (null);
        }

        public function onFlush(... _args):void
        {
            BSUIDataManager.Flush(_args);
        }


    }
}//package Shared.AS3.Data

