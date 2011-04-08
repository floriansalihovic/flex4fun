package de.flashforum.ffk11.views.components {
    import de.flashforum.ffk11.views.components.skins.MyUIComponentSkin;

    import flash.events.Event;

    import mx.events.FlexEvent;

    import spark.components.Label;
    import spark.components.supportClasses.SkinnableComponent;

    public class MyUIComponent extends SkinnableComponent {

        [SkinPart("true")]
        public var label:Label;

        private var _myName:String;

        private var _myNameChanged:Boolean;

        public function get myName():String {
            return _myName;
        }

        public function set myName(value:String):void {
            if (_myName == value) {
                return;
            }
            _myName = value;
            _myNameChanged = true;
            invalidateProperties();
            invalidateSize();
            invalidateDisplayList();
        }

        private function myNameChanged():void {
            trace("myNameChanged");

            if (label)
                label.text = _myName;
        }

        public function MyUIComponent() {

            trace("Constructor");

            const eventTypes:Array = [Event.ADDED, Event.ADDED_TO_STAGE,
                FlexEvent.ADD, FlexEvent.PREINITIALIZE, FlexEvent.INITIALIZE,
                FlexEvent.CREATION_COMPLETE, FlexEvent.UPDATE_COMPLETE];

            for each(var type:String in eventTypes) {
                addEventListener(type, liveCycleEventHandler);
            }

            setStyle("skinClass", MyUIComponentSkin);
        }

        private function liveCycleEventHandler(event:Event):void {
            trace("Event: ", event.type);
        }


        override protected function createChildren():void {
            super.createChildren();
            trace("Method: createChildren");
        }

        override protected function commitProperties():void {
            super.commitProperties();
            trace("Method: commitProperties");

            if (_myNameChanged) {
                _myNameChanged = false;

                myNameChanged();
            }
        }

        override protected function measure():void {
            super.measure();
            trace("Method: measure");
        }

        override protected function partAdded(partName:String, instance:Object):void {
            super.partAdded(partName, instance);
            trace("Method: partAdded");

            if (instance == label) {
                trace("\twohoo, label found");
            }
        }

        override protected function partRemoved(partName:String, instance:Object):void {
            super.partRemoved(partName, instance);
            trace("Method: partRemoved");
        }

        override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
            super.updateDisplayList(unscaledWidth, unscaledHeight);
            trace("Method: updateDisplayList");
        }
    }
}
