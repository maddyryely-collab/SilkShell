import Quickshell.Services.Notifications
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import Quickshell.Widgets
import QtQuick.Layouts
import QtQuick.Effects

PanelWindow {
  id: toplevel
  implicitHeight: 40
  anchors {
    bottom: true
    left: true
    right: true
  }

  PopupWindow {
    anchor.window: toplevel
    anchor.rect.x: parentWindow.width / 2 - width / 2
    anchor.rect.y: parentWindow.top
    width: 100
    height: 20
    visible: true
    color: "black"
  }
}



