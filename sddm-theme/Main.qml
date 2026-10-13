import QtQuick 2.15

Rectangle {
    id: root
    width: 1920
    height: 1080
    color: "#000000" 

    readonly property color fg: "#bbbbbb"
    readonly property color dim: "#555555"
    readonly property color hi: "#ffffff"
    readonly property color err: "#cc4444"
    readonly property string fontName: "JetBrainsMono Nerd Font"
    readonly property int fontSize: 13

    property int userIdx: userModel.lastIndex >= 0 ? userModel.lastIndex : 0
    property int sessionIdx: sessionModel.lastIndex >= 0 ? sessionModel.lastIndex : 0
    property string userName: ""
    property string sessionName: ""

    // read names out of the models
    Repeater { id: users;    model: userModel;    delegate: Item { property string n: model.name } }
    Repeater { id: sessions; model: sessionModel; delegate: Item { property string n: model.name } }

    function refresh() {
        var u = users.itemAt(userIdx);       userName = u ? u.n : ""
        var s = sessions.itemAt(sessionIdx); sessionName = s ? s.n : ""
    }
    function cycle(idx, count, step) { return count > 0 ? (idx + step + count) % count : 0 }
    function doLogin() { msg.text = ""; sddm.login(userName, password.text, sessionIdx) }

    onUserIdxChanged: refresh()
    onSessionIdxChanged: refresh()
    Component.onCompleted: { refresh(); password.forceActiveFocus() }

    Connections {
        target: sddm
        function onLoginFailed() { password.text = ""; msg.text = "login failed"; password.forceActiveFocus() }
    }

    Timer {
        interval: 1000; running: true; repeat: true; triggeredOnStart: true
        onTriggered: {
            var d = new Date()
            clock.text = Qt.formatDateTime(d, "HH:mm  ddd d MMM yyyy").toLowerCase()
        }
    }

    Column {
        x: 24; y: 20
        spacing: 4

        Text { id: clock; color: fg; font.family: fontName; font.pixelSize: fontSize }
        Item { width: 1; height: 8 }

        // user  — focus with Tab, change with ←/→ or click
        FocusScope {
            id: userRow; width: 400; height: fontSize + 6
            KeyNavigation.tab: sessionRow
            Keys.onLeftPressed:  userIdx = cycle(userIdx, users.count, -1)
            Keys.onRightPressed: userIdx = cycle(userIdx, users.count, 1)
            Keys.onReturnPressed: password.forceActiveFocus()
            Text {
                color: userRow.activeFocus ? hi : fg
                font.family: fontName; font.pixelSize: fontSize
                text: "user     " + (userRow.activeFocus ? "< " + userName + " >" : userName)
            }
            MouseArea { anchors.fill: parent; onClicked: { userRow.forceActiveFocus(); userIdx = cycle(userIdx, users.count, 1) } }
        }

        // session
        FocusScope {
            id: sessionRow; width: 400; height: fontSize + 6
            KeyNavigation.tab: password
            Keys.onLeftPressed:  sessionIdx = cycle(sessionIdx, sessions.count, -1)
            Keys.onRightPressed: sessionIdx = cycle(sessionIdx, sessions.count, 1)
            Keys.onReturnPressed: password.forceActiveFocus()
            Text {
                color: sessionRow.activeFocus ? hi : fg
                font.family: fontName; font.pixelSize: fontSize
                text: "session  " + (sessionRow.activeFocus ? "< " + sessionName + " >" : sessionName)
            }
            MouseArea { anchors.fill: parent; onClicked: { sessionRow.forceActiveFocus(); sessionIdx = cycle(sessionIdx, sessions.count, 1) } }
        }

        // password
        Row {
            Text {
                text: "password "
                color: password.activeFocus ? hi : fg
                font.family: fontName; font.pixelSize: fontSize
            }
            TextInput {
                id: password
                width: 300
                echoMode: TextInput.Password
                passwordCharacter: "*"
                color: hi; font.family: fontName; font.pixelSize: fontSize
                selectionColor: "#333333"
                cursorDelegate: Rectangle { width: 7; color: dim; visible: password.activeFocus }
                KeyNavigation.tab: userRow
                onAccepted: doLogin()
            }
        }

        Text { id: msg; text: ""; color: err; font.family: fontName; font.pixelSize: fontSize }
    }
}
