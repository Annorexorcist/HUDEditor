// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//Shared.AS3.Events.MenuActionEvent

package Shared.AS3.Events
{
    import flash.events.Event;

    public class MenuActionEvent extends Event 
    {

        public static const MENU_HOVER:String = "MenuHover";
        public static const MENU_ACCEPT:String = "MenuAccept";
        public static const MENU_CANCEL:String = "MenuCancel";
        public static const ACTION_MULTIACTION:String = "MultiAction";
        public static const ACTION_OPENSUBMENU:String = "OpenSubMenu";
        public static const ACTION_OPENSECONDARYSUBMENU:String = "OpenSecondarySubMenu";
        public static const ACTION_OPENWORLDCARD:String = "OpenWorldCard";
        public static const ACTION_JOINFRIENDWORLD:String = "JoinFriendWorld";
        public static const ACTION_SENDEVENT:String = "Event";
        public static const ACTION_PREVIEWFRIENDLIST:String = "PreviewFriendList";
        public static const ACTION_OPENPARTYDROPOUTMENU:String = "OpenPartyDropoutMenu";
        public static const ACTION_OPENFRIENDLIST:String = "OpenFriendList";
        public static const ACTION_OPENSERVERLIST:String = "OpenServerList";
        public static const ACTION_OPENDEBUGBOX:String = "OpenDebugBox";
        public static const ACTION_SELECTCHARACTER:String = "CharacterMenu::SelectCharacter";
        public static const ACTION_DELETECHARACTER:String = "CharacterMenu::Delete";
        public static const ACTION_DELETECHARACTERCONFIRM:String = "CharacterMenu::ConfirmDelete";
        public static const ACTION_HOVERCHARACTER:String = "HoverCharacter";
        public static const ACTION_OPENQUICKPLAY:String = "OpenQuickPlay";
        public static const ACTION_OPENPLAYMODESMENU:String = "OpenPlayModesMenu";
        public static const ACTION_OPENCHARACTERMENU:String = "OpenCharacterMenu";
        public static const ACTION_OPENSTORE:String = "OpenStore";
        public static const ACTION_OPENSEASONMENU:String = "OpenSeasonMenu";
        public static const ACTION_OPENPHOTOMODE:String = "OpenPhotoMode";
        public static const ACTION_OPENPHOTOGALLERY:String = "OpenPhotoGallery";
        public static const ACTION_CHANGEAPPEARANCE:String = "ChangeAppearance";
        public static const ACTION_OPENSOCIALMENU:String = "OpenSocial";
        public static const ACTION_OPENCHALLENGESMENU:String = "OpenChallengesMenu";
        public static const ACTION_NEEDATOMSFORITEM:String = "NeedAtomsForItem";
        public static const ACTION_NEEDATOMSFORITEMCONFIRM:String = "NeedAtomsForItemConfirm";
        public static const SHOW_SETTINGS:String = "ShowSettings";

        private var _action:String = "";
        private var _data:String = "";
        private var _index:Number = 0;
        private var _tooltip:String = "";
        private var _entryObject:Object = "";

        public function MenuActionEvent(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:Number=0, _arg_5:String="", _arg_6:Object=null, _arg_7:Boolean=false, _arg_8:Boolean=false)
        {
            this._action = _arg_2;
            this._data = _arg_3;
            this._index = _arg_4;
            this._tooltip = _arg_5;
            this._entryObject = _arg_6;
            super(_arg_1, _arg_7, _arg_8);
        }

        public function get Action():*
        {
            return (this._action);
        }

        public function set Action(_arg_1:String):*
        {
            this._action = _arg_1;
        }

        public function get Data():*
        {
            return (this._data);
        }

        public function set Data(_arg_1:String):*
        {
            this._data = _arg_1;
        }

        public function get Index():*
        {
            return (this._index);
        }

        public function set Index(_arg_1:Number):*
        {
            this._index = _arg_1;
        }

        public function get Tooltip():*
        {
            return (this._tooltip);
        }

        public function set Tooltip(_arg_1:String):*
        {
            this._tooltip = _arg_1;
        }

        public function get EntryObject():*
        {
            return (this._entryObject);
        }

        public function set EntryObject(_arg_1:Object):*
        {
            this._entryObject = _arg_1;
        }

        override public function clone():Event
        {
            return (new MenuActionEvent(type, this._action, this._data, this._index, this._tooltip, this._entryObject, bubbles, cancelable));
        }


    }
}//package Shared.AS3.Events

