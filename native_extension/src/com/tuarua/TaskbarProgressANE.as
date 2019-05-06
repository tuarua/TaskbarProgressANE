/**
 * Created by Local Eoin Landy on 28/05/2017.
 */
package com.tuarua {

import flash.events.EventDispatcher;
import flash.events.StatusEvent;
import flash.external.ExtensionContext;

public class TaskbarProgressANE extends EventDispatcher {
    private static const name:String = "TaskbarProgressANE";
    public static const STYLE_NOPROGRESS:int = 0;
    public static const STYLE_INDETERMINATE:int = 0x1;
    public static const STYLE_NORMAL:int = 0x2;
    public static const STYLE_ERROR:int = 0x4;
    public static const STYLE_PAUSED:int = 0x8;
    private var ctx:ExtensionContext;
    public function TaskbarProgressANE() {
        initiate();
    }

    private function initiate():void {
        trace("[" + name + "] Initalizing ANE...");
        try {
            ctx = ExtensionContext.createExtensionContext("com.tuarua." + name, null);
            ctx.addEventListener(StatusEvent.STATUS, gotEvent);
        } catch (e:Error) {
            trace("[" + name + "] ANE Not loaded properly.  Future calls will fail.");
        }
    }

    private function gotEvent(event:StatusEvent):void {
        switch (event.level) {
            case "TRACE":
                trace(event.code);
                break;
        }
    }

    public function init(style:int = STYLE_NORMAL):void {
        ctx.call("init", style);
    }

    public function set style(value:int):void {
        ctx.call("setStyle", value);
    }

    public function set progress(value:Number):void {
        ctx.call("setProgress", Math.round(value * 100));
    }

    public function dispose():void {
        if (!ctx) {
            trace("[" + name + "] Error. ANE Already in a disposed or failed state...");
            return;
        }
        trace("[" + name + "] Unloading ANE...");
        ctx.dispose();
        ctx = null;
    }
}
}
