//@ pragma IconTheme <theme-name>
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



PanelWindow{
    readonly property int rowLength: Math.floor((appLauncherW - 50) / iconSize)
    WlrLayershell.layer: WlrLayer.Overlay
	WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
    color: "transparent"
    implicitHeight: appLauncherH + 40
    implicitWidth: appLauncherW + 40

    ClippingRectangle {
        border.color: '#63ffffff'
        border.width: 5
        radius: 18
        id: launcher
        color: Qt.rgba(0.06, 0.06, 0.06, 0.33)
        width: appLauncherW - 50
        height: appLauncherH - 50
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

    property string query: ""
    function launchSelected() {
        if (grid.currentItem && grid.currentItem.modelData) {
            grid.currentItem.modelData.execute();
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
                    // reset selection to first item of the filtered grid
                    grid.currentIndex = filtered.values.length > 0 ? 0 : -1;
                }
                background: Rectangle {
                    border.width: 0
                    color: "transparent"
                }

                Keys.onEscapePressed: lazyLoader.active = !lazyLoader.active
                Keys.onPressed: event => {
                    if (event.key == Qt.Key_Left) {
                        event.accepted = true;
                        if (grid.currentIndex > 0)
                            grid.currentIndex--;
                    } else if (event.key == Qt.Key_Right) {
                        event.accepted = true;
                        if (grid.currentIndex < grid.count - 1)
                            grid.currentIndex++;
                    } else if (event.key == Qt.Key_Up) {
                        event.accepted = true;
                        if (grid.currentIndex > rowLength - 1)
                            grid.currentIndex = Math.min(grid.currentIndex - rowLength);
                    } else if (event.key == Qt.Key_Down) {
                        event.accepted = true;
                        if (grid.currentIndex < grid.count - rowLength)
                            grid.currentIndex = Math.min(grid.currentIndex + rowLength);
                    } else if ([Qt.Key_Return, Qt.Key_Enter].includes(event.key)) {
                        event.accepted = true;
                        launcher.launchSelected();
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
                    return allEntries.sort((a, b) => a.name.localeCompare(b.name));
                } else {
                    return allEntries.filter(d => d.name && d.name.toLowerCase().includes(q));
                }
                
            }
        }

        GridView {
            
            id: grid
            cellWidth: iconSize; cellHeight: iconSize
            Layout.fillHeight: true
            width: appLauncherW - 50
            clip: true
            model: filtered.values
            currentIndex: filtered.values.length > 0 ? 0 : -1
            keyNavigationEnabled: true
            keyNavigationWraps: true
            preferredHighlightBegin: 0
            preferredHighlightEnd: height
            highlightFollowsCurrentItem: true
            highlightRangeMode: GridView.ApplyRange
            highlightMoveDuration: 100

            highlight: Item {
                opacity: 0.45
                width: view.cellWidth; height: view.cellHeight
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
                height: GridView.view.cellHeight

                MouseArea {
                    anchors.fill: parent
                    onClicked: grid.currentIndex = entry.index
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
    