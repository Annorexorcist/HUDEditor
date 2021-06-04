// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//Shared.AS3.Data.UsesEventDispatcherBackend

package Shared.AS3.Data
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import __AS3__.vec.Vector;
    import flash.events.Event;
    import __AS3__.vec.*;

    public class UsesEventDispatcherBackend implements IEventDispatcher 
    {

        private var m_Dispatcher:EventDispatcher;
        private var _eventDispatcherBackend:BSUIEventDispatcherBackend;
        private var _cachedEvents:Vector.<Event>;

        public function UsesEventDispatcherBackend()
        {
            this.m_Dispatcher = new EventDispatcher();
            this._cachedEvents = new Vector.<Event>();
        }

        protected function get eventDispatcherBackend():BSUIEventDispatcherBackend
        {
            return (this._eventDispatcherBackend);
        }

        protected function set eventDispatcherBackend(_arg_1:BSUIEventDispatcherBackend):void
        {
            this._eventDispatcherBackend = _arg_1;
            this.SendCachedEvents();
        }

        private function SendCachedEvents():*
        {
            while (this._cachedEvents.length > 0)
            {
                this.eventDispatcherBackend.DispatchEventToGame(this._cachedEvents.shift());
            };
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            this.m_Dispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            this.m_Dispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            var _local_2:Boolean;
            if ((this.eventDispatcherBackend is BSUIEventDispatcherBackend))
            {
                this.eventDispatcherBackend.DispatchEventToGame(_arg_1);
            }
            else
            {
                this._cachedEvents.push(_arg_1.clone());
            };
            return (this.m_Dispatcher.dispatchEvent(_arg_1));
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (this.m_Dispatcher.hasEventListener(_arg_1));
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (this.m_Dispatcher.willTrigger(_arg_1));
        }


    }
}//package Shared.AS3.Data

