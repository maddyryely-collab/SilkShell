import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.LocalStorage
import Quickshell
import Quickshell.Widgets
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick.Effects
import QtQuick.Shapes
import QtQuick.Effects
import QtQuick.VectorImage
import Qt5Compat.GraphicalEffects
import QtQuick.Controls.Material


PanelWindow{
    WlrLayershell.layer: WlrLayer.Overlay
	WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

    color: "transparent"
    implicitHeight: appLauncherH + 40
    implicitWidth: appLauncherW + 40




    ClippingRectangle {
        radius: 18
        id: launcher
        color: Qt.rgba(0, 0, 0, 0.8)
        width: appLauncherW - 50
        height: appLauncherH - 50
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter







    property string query: ""

    function launchSelected() {
        if (list.currentItem && list.currentItem.modelData) {
            list.currentItem.modelData.execute();
            lazyLoader.active = !lazyLoader.active
        }
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 8

        RowLayout {
            Image {
                Layout.leftMargin: 10
                source: Quickshell.shellPath("assets/icon.svg")
                Layout.preferredWidth: 25
                Layout.preferredHeight: 25
                smooth: true
                mipmap: true
                layer.enabled: true
                layer.effect: MultiEffect {
                colorization: 1.0
                colorizationColor: "white"
                brightness: 1.0
                shadowEnabled: true
                shadowColor: "white"
                blurEnabled: true
            }
            }

            TextField {
                
                id: input
                Layout.fillWidth: true
                font.pixelSize: 18
                color: "white"
                focus: true

                padding: 15

                onTextChanged: {
                    launcher.query = text;
                    // reset selection to first item of the filtered list
                    list.currentIndex = filtered.values.length > 0 ? 0 : -1;
                }

                background: Rectangle {
                    border.width: 0
                    color: "transparent"
                }

                // Quit
                Keys.onEscapePressed: lazyLoader.active = !lazyLoader.active
                Keys.onPressed: event => {
                    const ctrl = event.modifiers & Qt.ControlModifier;
                    if (event.key == Qt.Key_Up || event.key == Qt.Key_P && ctrl) {
                        event.accepted = true;
                        if (list.currentIndex > 0)
                            list.currentIndex--;
                    } else if (event.key == Qt.Key_Down || event.key == Qt.Key_N && ctrl) {
                        event.accepted = true;
                        if (list.currentIndex < list.count - 1)
                            list.currentIndex++;
                    } else if ([Qt.Key_Return, Qt.Key_Enter].includes(event.key)) {
                        event.accepted = true;
                        Quickshell.execDetached(launcher.launchSelected());
                    } else if (event.key == Qt.Key_C && ctrl) {
                        event.accepted = true;
                        lazyLoader.active = !lazyLoader.active
                    }
                }
            }
        }

        // Filtered model: only items matching the query
        ScriptModel {
            id: filtered
            values: {
                const allEntries = [...DesktopEntries.applications.values];
                const q = launcher.query.trim();

                if (q === "") {
                    return allEntries.sort((a, b) => a.name.localeCompare(b.name));;
                } else {
                    return allEntries.filter(d => d.name && d.name.toLowerCase().includes(q));
                }
            }
        }

        GridView {
            id: list
            cellWidth: 100; cellHeight: 100
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            model: filtered.values
            currentIndex: filtered.values.length > 0 ? 0 : -1
            keyNavigationWraps: true
            preferredHighlightBegin: 0
            preferredHighlightEnd: height
            highlightRangeMode: ListView.ApplyRange
            highlightMoveDuration: 100

            highlight: Item {

                opacity: 0.45

                RadialGradient {
                anchors.fill: parent
                gradient: Gradient {
                GradientStop { position: 0.0; color: '#81ffffff' }
                GradientStop { position: 0.5; color: '#00ffffff' }
                    }   
                }

                    Image {
                    width: 100
                    height: 100
                    anchors.bottomMargin: 20
                    anchors.rightMargin: 20
                    id: bottomright
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: Quickshell.shellPath("assets/selector_icon.svg")
                    smooth: true
                    mipmap: true
                    layer.enabled: true
                    layer.effect: MultiEffect {
                    colorization: 1.0
                    colorizationColor: "white"
                    brightness: 1.0
                    shadowEnabled: true
                    shadowColor: white
                    }
                }

            }

            delegate: Item {
                id: entry
                required property var modelData
                required property int index
                width: GridView.view.cellWidth
                height: 100

                MouseArea {
                    anchors.fill: parent
                    onClicked: list.currentIndex = entry.index
                    onDoubleClicked: launcher.launchSelected()
                }



                    IconImage {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        source: Quickshell.iconPath(modelData.icon, true)
                        width: 50
                        height: 50
                    }
                
            }

            // Enter also works while ListView has focus
            Keys.onReturnPressed: launcher.launchSelected()
        }
    }


        }

        
        
        Image {
            anchors.topMargin: 20
            anchors.leftMargin: 20
            width: 250
            height: 250
            id: topleft
            anchors.left: parent.left
            anchors.top: parent.top
            source: Quickshell.shellPath("assets/topleft-appmenu.svg")
            smooth: true
            mipmap: true
            layer.enabled: true
            layer.effect: MultiEffect {
                colorization: 1.0
                colorizationColor: "white"
                brightness: 1.0
                shadowEnabled: true
                shadowColor: midlight1
                }
        }
        Image {
            width: 140
            height: 140
            anchors.bottomMargin: 20
            anchors.rightMargin: 20
            id: bottomright
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            source: Quickshell.shellPath("assets/bottomright-appmenu.svg")
            smooth: true
            mipmap: true
            layer.enabled: true
            layer.effect: MultiEffect {
                colorization: 1.0
                colorizationColor: "white"
                brightness: 1.0
                shadowEnabled: true
                shadowColor: midlight1
                }
        }

}
    