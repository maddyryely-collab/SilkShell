import Quickshell.Services.Notifications
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import Quickshell.Widgets
import QtQuick.Layouts
import QtQuick.Effects
pragma ComponentBehavior: Bound

WlrLayershell {
  id: root

  implicitWidth: screen.width / 5

  mask: itemRegion
  color: "transparent"

  exclusionMode: ExclusionMode.Ignore
  namespace: "QsNotifs"

  margins {
    top: 8
    right: 8
    bottom: 8
  }

  anchors {
    top: true
    right: true
    bottom: true
  }

  Region { id: itemRegion; item: listView }

  NotificationServer { id: notificationServer; onNotification: notif => notif.tracked = true }

  ListView {
    id: listView

    model: notificationServer.trackedNotifications

    implicitWidth: root.implicitWidth
    implicitHeight: Math.min(contentHeight, root.height)

    spacing: 12

    delegate: Rectangle {
      implicitWidth: root.implicitWidth
      implicitHeight: 120

      color: Qt.alpha("#181818", 0.5)
      radius: 12
    }
  }
}




