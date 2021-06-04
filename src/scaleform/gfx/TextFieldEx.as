// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//scaleform.gfx.TextFieldEx

package scaleform.gfx
{
    import flash.text.TextField;
    import flash.display.BitmapData;

    public final class TextFieldEx extends InteractiveObjectEx 
    {

        public static const VALIGN_NONE:String = "none";
        public static const VALIGN_TOP:String = "top";
        public static const VALIGN_CENTER:String = "center";
        public static const VALIGN_BOTTOM:String = "bottom";
        public static const TEXTAUTOSZ_NONE:String = "none";
        public static const TEXTAUTOSZ_SHRINK:String = "shrink";
        public static const TEXTAUTOSZ_FIT:String = "fit";
        public static const VAUTOSIZE_NONE:String = "none";
        public static const VAUTOSIZE_TOP:String = "top";
        public static const VAUTOSIZE_CENTER:String = "center";
        public static const VAUTOSIZE_BOTTOM:String = "bottom";


        public static function appendHtml(_arg_1:TextField, _arg_2:String):void
        {
        }

        public static function setIMEEnabled(_arg_1:TextField, _arg_2:Boolean):void
        {
        }

        public static function setVerticalAlign(_arg_1:TextField, _arg_2:String):void
        {
        }

        public static function getVerticalAlign(_arg_1:TextField):String
        {
            return ("none");
        }

        public static function setVerticalAutoSize(_arg_1:TextField, _arg_2:String):void
        {
        }

        public static function getVerticalAutoSize(_arg_1:TextField):String
        {
            return ("none");
        }

        public static function setTextAutoSize(_arg_1:TextField, _arg_2:String):void
        {
        }

        public static function getTextAutoSize(_arg_1:TextField):String
        {
            return ("none");
        }

        public static function setImageSubstitutions(_arg_1:TextField, _arg_2:Object):void
        {
        }

        public static function updateImageSubstitution(_arg_1:TextField, _arg_2:String, _arg_3:BitmapData):void
        {
        }

        public static function setNoTranslate(_arg_1:TextField, _arg_2:Boolean):void
        {
        }

        public static function getNoTranslate(_arg_1:TextField):Boolean
        {
            return (false);
        }

        public static function setBidirectionalTextEnabled(_arg_1:TextField, _arg_2:Boolean):void
        {
        }

        public static function getBidirectionalTextEnabled(_arg_1:TextField):Boolean
        {
            return (false);
        }

        public static function setSelectionTextColor(_arg_1:TextField, _arg_2:uint):void
        {
        }

        public static function getSelectionTextColor(_arg_1:TextField):uint
        {
            return (0xFFFFFFFF);
        }

        public static function setSelectionBkgColor(_arg_1:TextField, _arg_2:uint):void
        {
        }

        public static function getSelectionBkgColor(_arg_1:TextField):uint
        {
            return (0xFF000000);
        }

        public static function setInactiveSelectionTextColor(_arg_1:TextField, _arg_2:uint):void
        {
        }

        public static function getInactiveSelectionTextColor(_arg_1:TextField):uint
        {
            return (0xFFFFFFFF);
        }

        public static function setInactiveSelectionBkgColor(_arg_1:TextField, _arg_2:uint):void
        {
        }

        public static function getInactiveSelectionBkgColor(_arg_1:TextField):uint
        {
            return (0xFF000000);
        }


    }
}//package scaleform.gfx

