// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//Overlay.PublicTeams.PublicTeamsIcon

package Overlay.PublicTeams
{
    import Shared.AS3.SWFLoaderClip;

    public class PublicTeamsIcon extends SWFLoaderClip 
    {

        private var m_originalWidth:Number;
        private var m_originalHeight:Number;
        private var m_TeamType:uint = 0;

        public function PublicTeamsIcon()
        {
            this.m_originalWidth = this.width;
            this.m_originalHeight = this.height;
        }

        public function setIconType(_arg_1:uint):void
        {
            var _local_2:String;
            if (((!(_arg_1 == this.m_TeamType)) && (PublicTeamsShared.IsValidPublicTeamType(_arg_1))))
            {
                this.m_TeamType = _arg_1;
                _local_2 = PublicTeamsShared.DecideTeamTypeString(this.m_TeamType);
                this.removeChildren();
                this.setContainerIconClip(("IconPT_" + _local_2));
            };
            this.getChildAt(0).width = (this.m_originalWidth / this.scaleX);
            this.getChildAt(0).height = (this.m_originalHeight / this.scaleY);
        }


    }
}//package Overlay.PublicTeams

