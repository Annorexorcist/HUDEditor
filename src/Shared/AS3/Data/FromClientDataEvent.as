// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//Shared.AS3.Data.FromClientDataEvent

package Shared.AS3.Data
{
    import flash.events.Event;

    public final class FromClientDataEvent extends Event 
    {

        private var m_FromClient:UIDataFromClient;

        public function FromClientDataEvent(_arg_1:UIDataFromClient)
        {
            super(Event.CHANGE);
            this.m_FromClient = _arg_1;
        }

        public function get fromClient():Object
        {
            return (this.m_FromClient);
        }

        public function get data():Object
        {
            return (this.m_FromClient.data);
        }


    }
}//package Shared.AS3.Data

