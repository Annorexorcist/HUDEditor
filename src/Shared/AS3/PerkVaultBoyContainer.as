// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//Shared.AS3.PerkVaultBoyContainer

package Shared.AS3
{
    import flash.display.MovieClip;
    import Shared.AS3.Data.BSUIDataManager;
    import Shared.AS3.Events.CustomEvent;
    import flash.events.Event;
    import flash.utils.getDefinitionByName;

    public class PerkVaultBoyContainer extends BSDisplayObject 
    {

        private static const ANIM_FRAME_NAME:String = "animated";
        private static const STATIC_FRAME_NAME:String = "static";
        private static const ANIM_END_AS_EVENT:String = "AnimComplete";
        private static const ANIM_END_NATIVE_EVENT:String = "PerkVaultBoyAnimComplete";

        private var CurrentClip:MovieClip = null;
        private var Loop:Boolean = false;
        private var RemoveOnComplete:Boolean = true;
        private var _defaultVaultBoyName:String = "Default";

        public function PerkVaultBoyContainer()
        {
            addEventListener(ANIM_END_AS_EVENT, this.OnAnimComplete);
        }

        public function get DefaultBoySwfName_Inspectable():String
        {
            return (this._defaultVaultBoyName);
        }

        public function set DefaultBoySwfName_Inspectable(_arg_1:String):*
        {
            this._defaultVaultBoyName = _arg_1;
        }

        private function OnAnimComplete(_arg_1:Event):*
        {
            if (!this.Loop)
            {
                this.CurrentClip.stop();
                if (this.RemoveOnComplete)
                {
                    removeChild(this.CurrentClip);
                    this.CurrentClip = null;
                };
                BSUIDataManager.dispatchEvent(new CustomEvent(ANIM_END_NATIVE_EVENT, {}));
            };
        }

        public function DisplayPerkVaultBoy(aPerkName:String, abAnimate:Boolean, abLoop:Boolean, abRemoveOnComplete:Boolean):*
        {
            var clipType:Object;
            var frameName:String;
            var begin:* = (aPerkName.lastIndexOf("/") + 1);
            var end:* = aPerkName.lastIndexOf(".");
            if (((begin > 0) && (end > 0)))
            {
                aPerkName = aPerkName.slice(begin, end);
                aPerkName = aPerkName.replace(/ /gi, "");
            };
            try
            {
                clipType = getDefinitionByName(aPerkName);
            }
            catch(error:Error)
            {
                try
                {
                    clipType = getDefinitionByName(DefaultBoySwfName_Inspectable);
                }
                catch(error:Error)
                {
                    trace((((("Error: Could not find the " + aPerkName) + " class nor the ") + DefaultBoySwfName_Inspectable) + " class in library. Can't display a perk animation."));
                    return;
                };
            };
            var newClip:MovieClip = new (clipType)();
            if (newClip)
            {
                frameName = ((abAnimate) ? ANIM_FRAME_NAME : STATIC_FRAME_NAME);
                newClip.gotoAndStop(frameName);
                if (this.CurrentClip)
                {
                    removeChild(this.CurrentClip);
                };
                addChild(newClip);
                this.Loop = abLoop;
                this.RemoveOnComplete = abRemoveOnComplete;
                this.CurrentClip = newClip;
            };
        }


    }
}//package Shared.AS3

