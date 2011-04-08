package de.flashforum.ffk11.model
{
    import mx.collections.IList;

    public interface IExample
    {

        function get children():IList;

        [Bindable("childrenChanged")]
        function set children(value:IList):void;

        function get label():String;

        [Bindable("labelChanged")]
        function set label(value:String):void;
    }
}
