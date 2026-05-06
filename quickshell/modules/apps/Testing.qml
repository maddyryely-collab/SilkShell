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


FloatingWindow {
    id: appContainer
    
    // Component to handle database operations
    GridView{
        Component.onCompleted: {
        loadApps()
    }

    function loadApps() {
        // [SOLVED] Qt 5.14 QML Quick local storage methods for SQL
        var db = LocalStorage.openDatabaseSync("AppDatabase", "1.0", "App Storage", 1000000);
        db.transaction(function(tx) {
            // Create table if it doesn't exist
            tx.executeSql('CREATE TABLE IF NOT EXISTS apps(name TEXT, iconPath TEXT)');
            
            // Query to select only apps that have an icon path
            var rs = tx.executeSql('SELECT * FROM apps WHERE iconPath IS NOT NULL AND iconPath != ""');
            
            for (var i = 0; i < rs.rows.length; i++) {
                console.log("App with icon: " + rs.rows.item(i).name);
                // Populate your list model here
            }
        });
    }
}
}
