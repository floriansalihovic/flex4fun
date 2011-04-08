package de.flashforum.ffk11.model
{
    import flash.events.Event;
    import flash.events.EventDispatcher;

    import mx.collections.ArrayList;

    import mx.collections.IList;

    public class ExampleDTO extends EventDispatcher implements IExample
    {

        private var _children:IList;

        public function get children():IList
        {
            // this can be generated lazy
            return _children ||= new ArrayList();
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

        public function ExampleDTO(label:String)
        {
            _label = label
        }
    }
}