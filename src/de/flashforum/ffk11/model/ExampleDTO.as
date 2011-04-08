package de.flashforum.ffk11.model
{
    import flash.events.Event;
    import flash.events.EventDispatcher;

    import mx.collections.IList;

    public class ExampleDTO extends EventDispatcher implements IExample
    {

        private var _children:IList;
        public function get children():IList
        {
            return _children;
        }

        [Bindable("childrenChanged")]
        public function set children(value:IList):void
        {
            if (_children == value)
            {
                return;
            }
            _children = value;
            dispatchEvent(new Event("childrenChanged"));
        }

        private var _label:String;

        public function get label():String
        {
            return _label;
        }

        [Bindable("labelChanged")]
        public function set label(value:String):void
        {
            if (_label == value)
            {
                return;
            }

            _label = value;
            dispatchEvent(new Event("labelChanged"));
        }

        public function ExampleDTO()
        {
        }
    }
}