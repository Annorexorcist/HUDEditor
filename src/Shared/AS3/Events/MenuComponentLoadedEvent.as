// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//Shared.AS3.Events.MenuComponentLoadedEvent

package Shared.AS3.Events
{
    import flash.events.Event;
    import Shared.AS3.MenuComponent;
    import Shared.AS3.IMenu;

    public final class MenuComponentLoadedEvent extends Event 
    {

        public static const MENU_COMPONENT_LOADED:String = "MenuComponentLoaded";

        private var _sender:MenuComponent;

        public function MenuComponentLoadedEvent(_arg_1:MenuComponent)
        {
            super(MENU_COMPONENT_LOADED, true, false);
            this._sender = _arg_1;
        }

        public function RespondToEvent(_arg_1:IMenu):*
        {
            this._sender.SetParentMenu(_arg_1);
        }

        override public function clone():Event
        {
            return (new MenuComponentLoadedEvent(this._sender));
        }


    }
}//package Shared.AS3.Events

