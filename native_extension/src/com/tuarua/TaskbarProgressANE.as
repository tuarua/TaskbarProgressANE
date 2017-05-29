/**
 * Created by Local Eoin Landy on 28/05/2017.
 */
package com.tuarua {
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import flash.events.StatusEvent;
import flash.external.ExtensionContext;

public class TaskbarProgressANE extends EventDispatcher {
    private var extensionContext:ExtensionContext;
    private static const name:String = "TaskbarProgressANE";
    public static const STYLE_NOPROGRESS:int = 0;
    public static const STYLE_INDETERMINATE:int = 0x1;
    public static const STYLE_NORMAL:int = 0x2;
    public static const STYLE_ERROR:int = 0x4;
    public static const STYLE_PAUSED:int = 0x8;

    public function TaskbarProgressANE() {
        initiate();
    }

    private function initiate():void {
        trace("[" + name + "] Initalizing ANE...");
        try {
            extensionContext = ExtensionContext.createExtensionContext("com.tuarua." + name, null);
        } catch (e:Error) {
            trace("[" + name + "] ANE Not loaded properly.  Future calls will fail.");
        }
    }

    public function init(style:int = STYLE_NORMAL):void {
        extensionContext.call("init", style);
    }

    public function setStyle(value:int):void {
        extensionContext.call("setStyle", value);
    }

    public function setProgress(value:Number):void {
        extensionContext.call("setProgress", value * 100);
    }

    public function dispose():void {
        if (!extensionContext) {
            trace("[" + name + "] Error. ANE Already in a disposed or failed state...");
            return;
        }
        trace("[" + name + "] Unloading ANE...");
        extensionContext.dispose();
        extensionContext = null;
    }
}
}
