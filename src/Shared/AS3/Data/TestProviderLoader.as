// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//Shared.AS3.Data.TestProviderLoader

package Shared.AS3.Data
{
    import flash.net.URLLoader;
    import flash.net.URLRequest;

    public class TestProviderLoader extends URLLoader 
    {

        private var m_ProviderName:String;
        private var m_FromClient:UIDataFromClient;

        public function TestProviderLoader(_arg_1:String, _arg_2:UIDataFromClient)
        {
            data = new Object();
            this.m_ProviderName = _arg_1;
            this.m_FromClient = _arg_2;
        }

        override public function load(_arg_1:URLRequest):void
        {
            super.load(_arg_1);
        }

        public function get providerName():String
        {
            return (this.m_ProviderName);
        }

        public function get fromClient():UIDataFromClient
        {
            return (this.m_FromClient);
        }


    }
}//package Shared.AS3.Data

