package com.tuarua {

import flash.events.StatusEvent;
import flash.external.ExtensionContext;
import flash.system.Capabilities;
import flash.utils.getQualifiedClassName;

public class TaskbarProgress {
    private static const name:String = "TaskbarProgressANE";
    public static const STYLE_NOPROGRESS:int = 0;
    public static const STYLE_INDETERMINATE:int = 0x1;
    public static const STYLE_NORMAL:int = 0x2;
    public static const STYLE_ERROR:int = 0x4;
    public static const STYLE_PAUSED:int = 0x8;
    private static var _ctx:ExtensionContext;

    public function TaskbarProgress() {
        if (Capabilities.isDebugger && getQualifiedClassName(this) == "com.tuarua::TaskbarProgress") {
            throw new Error("Don't create a new instance. All methods are static eg TaskbarProgress.init()");
        }
    }

    private static function get ctx():ExtensionContext {
        if (_ctx == null) {
            try {
                _ctx = ExtensionContext.createExtensionContext("com.tuarua." + name, null);
                _ctx.addEventListener(StatusEvent.STATUS, gotEvent);
            } catch (e:Error) {
                trace("[" + name + "] ANE Not loaded properly.  Future calls will fail.");
            }
        }
        return _ctx;
    }

    private static function gotEvent(event:StatusEvent):void {
        if (event.level === "TRACE") {
            trace(event.code);
        }
    }

    public static function init(style:int = STYLE_NORMAL):void {
        ctx.call("init", style);
    }

    public static function set style(value:int):void {
        ctx.call("setStyle", value);
    }

    public static function set progress(value:Number):void {
        ctx.call("setProgress", Math.round(value * 100));
    }

    public static function dispose():void {
        if (ctx == null) {
            trace("[" + name + "] Error. ANE Already in a disposed or failed state...");
            return;
        }
        trace("[" + name + "] Unloading ANE...");
        _ctx.dispose();
        _ctx = null;
    }
}
}
