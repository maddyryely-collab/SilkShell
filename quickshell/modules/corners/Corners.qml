
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Shapes
import QtQuick.Effects
import Quickshell.Widgets
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.VectorImage
import Qt5Compat.GraphicalEffects
import QtQuick.Controls.Material


            

PanelWindow {
            
            exclusionMode: ExclusionMode.Ignore
            id: lefttopcorner
            color: "transparent"
            mask: Region {}
            anchors {left: true; top: true; bottom: true; right: true}







        Item {
                

                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.top: parent.top
                anchors.topMargin: 0

                width: 100
                height: 25

        Text {
            id: clock
            text: Qt.formatDateTime(new Date(), "HH:mm")
            font.family: "Perpetua"
            font.pointSize: 25
            font.bold: true

            Timer {
                interval: 1000
                running: true
                repeat: true
                onTriggered: clock.text = Qt.formatDateTime(new Date(), "HH:mm")
            }
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
        RowLayout {
                

                anchors.left: parent.left
                anchors.leftMargin: 150
                anchors.top: parent.top
                anchors.topMargin: 14

                width: 100
                height: 25
                Repeater {
                    model: 5

                    Text {
                        property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
                        property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
                        text: isActive ? "" : (ws ? "" : "")
                        font { pixelSize: 16; bold: true }
                        color: "white"

                        MouseArea {
                            anchors.fill: parent
                            onClicked: Hyprland.dispatch("workspace " + (index + 1))
                        }
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
            
            
                
                
            
            

        Image {
            anchors.leftMargin: 3
            width: largeDecoSize
            height: largeDecoSize
            id: topleft
            anchors.left: parent.left
            anchors.top: parent.top
            source: Quickshell.shellPath("assets/topleft.svg")
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

        

        Image {
                width: smallDecoSize
                height: smallDecoSize
                anchors.leftMargin: 4
                anchors.bottomMargin: 2
                id: bottomleft
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                source: Quickshell.shellPath("assets/bottomleft.svg")
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

        Image {
            width: smallDecoSize
            height: smallDecoSize
            anchors.rightMargin: 4
            anchors.topMargin: 2
            id: topright
            anchors.right: parent.right
            anchors.top: parent.top
            source: Quickshell.shellPath("assets/topright.svg")
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


        Image {
            anchors.leftMargin: 3
            width: largeDecoSize
            height: largeDecoSize
            id: bottomright
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            source: Quickshell.shellPath("assets/bottomright.svg")
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
     

