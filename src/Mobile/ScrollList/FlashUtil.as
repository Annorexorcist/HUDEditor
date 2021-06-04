// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//Mobile.ScrollList.FlashUtil

package Mobile.ScrollList
{
    import flash.utils.getQualifiedClassName;
    import flash.display.BitmapData;
    import flash.utils.getQualifiedSuperclassName;
    import flash.display.Bitmap;
    import flash.display.MovieClip;
    import flash.display.DisplayObject;

    public class FlashUtil 
    {

        private static const BITMAP_DATA_CLASS_NAME:String = getQualifiedClassName(BitmapData);


        public static function getLibraryItem(_arg_1:MovieClip, _arg_2:String):DisplayObject
        {
            var _local_3:Class = getLibraryClass(_arg_1, _arg_2);
            if (getQualifiedSuperclassName(_local_3) == BITMAP_DATA_CLASS_NAME)
            {
                return (new Bitmap(new (_local_3)(), "auto", true));
            };
            return (new (_local_3)());
        }

        public static function getLibraryClass(_arg_1:MovieClip, _arg_2:String):Class
        {
            return (_arg_1.loaderInfo.applicationDomain.getDefinition(_arg_2) as Class);
        }


    }
}//package Mobile.ScrollList

