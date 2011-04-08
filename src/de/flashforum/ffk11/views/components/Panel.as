package de.flashforum.ffk11.views.components
{
    import de.flashforum.ffk11.views.components.skins.PanelSkin;

    import flash.events.MouseEvent;

    import mx.events.CloseEvent;

    import spark.components.Button;
    import spark.components.Panel;

    public class Panel extends spark.components.Panel
    {

        [SkinPart(required="false")]
        public var closeButton:Button;

        public function Panel()
        {
            setStyle("skinClass", PanelSkin);
        }

        private function closeButton_clickHandler(event:MouseEvent):void
        {
            dispatchEvent(new CloseEvent(CloseEvent.CLOSE));
        }

        override protected function partAdded(partName:String, instance:Object):void
        {
            super.partAdded(partName, instance);

            if (instance == closeButton)
            {
                closeButton.addEventListener(MouseEvent.CLICK, closeButton_clickHandler);
            }
        }

        override protected function partRemoved(partName:String, instance:Object):void
        {
            super.partRemoved(partName, instance);

            if (instance == closeButton)
            {
                closeButton.removeEventListener(MouseEvent.CLICK, closeButton_clickHandler);
            }
        }
    }
}
