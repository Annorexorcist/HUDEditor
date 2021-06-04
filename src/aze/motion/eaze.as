// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//aze.motion.eaze

package aze.motion
{
    public function eaze(_arg_1:Object):EazeTween
    {
        return (new EazeTween(_arg_1));
    }

}//package aze.motion
import aze.motion.specials.PropertyTint;
import aze.motion.specials.PropertyFrame;
import aze.motion.specials.PropertyFilter;
import aze.motion.specials.PropertyVolume;
import aze.motion.specials.PropertyColorMatrix;
import aze.motion.specials.PropertyBezier;
import aze.motion.specials.PropertyShortRotation;
import aze.motion.specials.PropertyRect;

PropertyTint.register();
PropertyFrame.register();
PropertyFilter.register();
PropertyVolume.register();
PropertyColorMatrix.register();
PropertyBezier.register();
PropertyShortRotation.register();
PropertyRect.register();

