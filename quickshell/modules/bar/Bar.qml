
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Window
import QtQuick.Shapes
import QtQuick.Effects
import Quickshell.Widgets
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.VectorImage
import QtQuick.LocalStorage

Item {


    PanelWindow{
        id:topBar
        color: "transparent"
        implicitHeight: 38
        anchors{top: true; left: true; right: true}
        margins{
            left:largeDecoSize
            right:smallDecoSize -40
        }


            Image {
            fillMode: Image.PreserveAspectFit

            anchors.bottomMargin: 2
            anchors{bottom:parent.bottom; left: parent.left; right:parent.right}
            
            source: Quickshell.shellPath("assets/line_h.svg")

            smooth: true
            layer.enabled: true
            layer.effect: MultiEffect {
                colorization: 1.0
                colorizationColor: "white"
                brightness: 1.0
                shadowEnabled: true
                shadowColor: midlight1
                blurEnabled: true
                }
        }

        

    RowLayout{
        
        anchors.top: parent.top
        anchors.topMargin:2
        anchors.horizontalCenter: parent.horizontalCenter
        spacing:15

        Rectangle{
            width:22
            height:22
            color: "white"
        }
        Rectangle{
            width:22
            height:22
            color: "white"
        }

        Item{
            width:30
            height:30
            
            anchors.horizontalCenter: parent.horizontalCenter
            Image {
                anchors.top: parent.top
                fillMode: Image.PreserveAspectFit
                source: Quickshell.shellPath("assets/icon.svg")
                width:30
                smooth: true
                mipmap: true
                layer.enabled: true
                layer.effect: MultiEffect {
                    colorization: 1.0
                    colorizationColor: "white"
                    brightness: 1.0
                    shadowEnabled: true
                    shadowColor: midlight1
                    blurEnabled: true
                }
            }
        }

        Item{
            width:30
            height:30
            Image {
                anchors.top: parent.top
                fillMode: Image.PreserveAspectFit
                source: Quickshell.shellPath("assets/speaker_icon.svg")
                width:30
                smooth: true
                mipmap: true
                layer.enabled: true
                layer.effect: MultiEffect {
                    colorization: 1.0
                    colorizationColor: "white"
                    brightness: 1.0
                    shadowEnabled: true
                    shadowColor: midlight1
                    blurEnabled: true
                }
            }
        }

        Item{
            id: blueTooth
            width:25
            height:25
            Image {
                anchors.top: parent.top
                fillMode: Image.PreserveAspectFit
                source: Quickshell.shellPath("assets/bluetooth_icon.svg")
                width:25
                smooth: true
                mipmap: true
                layer.enabled: true
                layer.effect: MultiEffect {
                    colorization: 1.0
                    colorizationColor: "white"
                    brightness: 1.0
                    shadowEnabled: true
                    shadowColor: midlight1
                    blurEnabled: true
                }
            }
        }
        
    }
        
}

            

//            layer.enabled: true
//            layer.effect: MultiEffect {
//                brightness: 1.0
//                shadowEnabled: true
//                shadowColor: midlight1
//                blurEnabled: true
//            }
            
        

        


    




    PanelWindow{
        margins{
                left: smallDecoSize-14
                right: largeDecoSize+14
            }
        id: bottomSpacer
        color: "transparent"
        implicitHeight: 10
        anchors{left: parent.left; right: parent.right; bottom:parent.bottom}

       Image {
        
            fillMode: Image.PreserveAspectFit

            anchors.bottomMargin: 9
            anchors{bottom:parent.bottom; left: parent.left; right:parent.right}

            source: Quickshell.shellPath("assets/line_h.svg")

            smooth: true
            layer.enabled: true
            layer.effect: MultiEffect {
                colorization: 1.0
                colorizationColor: "white"
                brightness: 1.0
                shadowEnabled: true
                shadowColor: midlight1
                blurEnabled: true
                }
        }

    }

    PanelWindow{
        id: rightSpacer
        color: "transparent"
        anchors.right: parent.right
        implicitWidth: 15
    }

    PanelWindow{
        id: leftSpacer
        color: "transparent"
        anchors.left: parent.left
        implicitWidth: 15
    }  
}