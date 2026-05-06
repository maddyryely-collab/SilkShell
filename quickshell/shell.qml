import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import Quickshell.Io
import Quickshell.Widgets
import QtQuick.Layouts
import QtQuick.Effects
import "./modules/corners/"
import "./modules/bar/"
import "./modules/apps/"
import "./modules/notifications/"



Scope{



        FileView {
          id: jsonFile
          path: Qt.resolvedUrl("./colors.json")
          // Forces the file to be loaded by the time we call JSON.parse().
          // see blockLoading's property documentation for details.
          blockLoading: true
        }

        readonly property var jsonData: JSON.parse(jsonFile.text())


    id: root

    // sizing/padding
    readonly property real appLauncherW: 550
    readonly property real appLauncherH: 400
    readonly property real iconSize: 100
    readonly property real bardecosize: 50
    readonly property real barMargin: 7
    readonly property real barHeight: 40
    readonly property real paddingLeft: 15
    readonly property real paddingRight: 15
    readonly property real paddingBottom: 10
    readonly property real largeDecoSize: 400
    readonly property real smallDecoSize: 170


    Loader {
       active: true
       sourceComponent: Corners{}
    }
    Loader {
        active: true
        sourceComponent: Bar{}
    }
//    Loader {
//        active: true
//        sourceComponent: Notify{}
//    }
//    Loader {
//        active: true
//        sourceComponent: Testing{}
//    }

    


    
    GlobalShortcut {
        name: "appLauncher"
        onPressed: lazyLoader.active = !lazyLoader.active
    }

    LazyLoader {
        Loader {
            active: true
            sourceComponent: AppLauncher{}
            }
        id: lazyLoader
        active: false
        }
    

    

        
        
    //usable colours
    readonly property color deep0: "#01161f"
    readonly property color deep1: "#022533"
    readonly property color deep2: "#13465b"
    readonly property color midlow0: "#205e77"
    readonly property color midlow1: "#327f9f"
    readonly property color midlow2: "#3a8fb2"        
    readonly property color midlight0: "#46a5cd"
    readonly property color midlight1: "#4eb3dd"
    readonly property color midlight2: "#54c0ed"        
    readonly property color light0: "#8cd6f5"
    readonly property color light1: "#a7e0f8"
    readonly property color light2: "#c7ebfa"        
    readonly property color pink0: "#db2360"
    readonly property color pink1: "#f182b5"
    readonly property color pink2: "#ffc3ef"        
    readonly property color orange0: "#f04933"
    readonly property color orange1: "#f49b53"        
    readonly property color salmon: "#f0616a"
    readonly property color yellow: "#ffd971"
    readonly property color lime: "#e3fc9e"        
    readonly property color teal0: "#45997d"
    readonly property color teal1: "#72bb98"
    readonly property color teal2: "#98d9af"
    readonly property color teal3: "#b9f2c2"



}



    








