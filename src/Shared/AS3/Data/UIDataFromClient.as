// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//Shared.AS3.Data.UIDataFromClient

package Shared.AS3.Data
{
    import flash.events.EventDispatcher;

    public class UIDataFromClient extends EventDispatcher 
    {

        private var m_Payload:Object;
        private var m_Ready:Boolean = false;
        private var m_IsTest:Boolean = false;

        public function UIDataFromClient(_arg_1:Object)
        {
            this.m_Ready = false;
            this.m_Payload = _arg_1;
            this.m_IsTest = false;
        }

        public function DispatchChange():void
        {
            dispatchEvent(new FromClientDataEvent(this));
        }

        public function SetReady(_arg_1:Boolean):void
        {
            if (!this.m_Ready)
            {
                this.m_Ready = true;
                if (_arg_1)
                {
                    this.DispatchChange();
                };
            };
        }

        public function get data():Object
        {
            return (this.m_Payload);
        }

        public function get dataReady():Boolean
        {
            return (this.m_Ready);
        }

        public function get isTest():Boolean
        {
            return (this.m_IsTest);
        }

        public function set isTest(_arg_1:Boolean):*
        {
            this.m_IsTest = _arg_1;
        }


    }
}//package Shared.AS3.Data

