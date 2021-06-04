// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//Shared.AS3.Data.UIDataShuttleTestConnector

package Shared.AS3.Data
{
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.net.URLRequest;
    import com.adobe.serialization.json.JSONDecoder;

    public class UIDataShuttleTestConnector extends UIDataShuttleConnector 
    {


        override public function Watch(_arg_1:String, _arg_2:Boolean, _arg_3:UIDataFromClient=null):UIDataFromClient
        {
            var _local_4:UIDataFromClient = new UIDataFromClient(new Object());
            var _local_5:TestProviderLoader = new TestProviderLoader(_arg_1, _local_4);
            _local_5.addEventListener(Event.COMPLETE, this.onLoadComplete);
            _local_5.addEventListener(IOErrorEvent.IO_ERROR, this.onLoadFailedPrimaryLocation);
            _local_5.load(new URLRequest((("Providers/" + _arg_1) + ".json")));
            _local_4.isTest = true;
            return (_local_4);
        }

        internal function onLoadComplete(_arg_1:Event):void
        {
            var _local_6:String;
            var _local_2:TestProviderLoader = (_arg_1.target as TestProviderLoader);
            var _local_3:UIDataFromClient = _local_2.fromClient;
            var _local_4:Object = new JSONDecoder(_local_2.data, true).getValue();
            var _local_5:Object = _local_3.data;
            for (_local_6 in _local_4)
            {
                _local_5[_local_6] = _local_4[_local_6];
            };
            _local_2.fromClient.SetReady(true);
        }

        internal function onLoadFailedPrimaryLocation(_arg_1:IOErrorEvent):*
        {
            var _local_2:TestProviderLoader = (_arg_1.target as TestProviderLoader);
            var _local_3:* = new TestProviderLoader(_local_2.providerName, _local_2.fromClient);
            _local_3.addEventListener(Event.COMPLETE, this.onLoadComplete);
            _local_3.addEventListener(IOErrorEvent.IO_ERROR, this.onLoadFailed);
            _local_3.load(new URLRequest((("../Interface/Providers/" + _local_2.providerName) + ".json")));
        }

        internal function onLoadFailed(_arg_1:IOErrorEvent):*
        {
            var _local_2:TestProviderLoader = TestProviderLoader(_arg_1.target);
            var _local_3:String = _local_2.providerName;
            trace((("WARNING - UIDataShuttleTestConnector.onLoadFailed - TEST PROVIDER: " + _local_3) + " NOT FOUND"));
        }


    }
}//package Shared.AS3.Data

