import QtQuick 2.9
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3
import Ubuntu.Content 1.1
import QtFeedback 5.0
import QtQuick.Window 2.2
import Qt.labs.settings 1.0
import Ubuntu.Components.Popups 1.3

MainView {
        id: root
        objectName: 'mainView'
        theme.name: "Ubuntu.Components.Themes.Ambiance"
        applicationName: 'zimbra.webmail'
        automaticOrientation: true
        anchorToKeyboard: true
 
        property string appVersion : "v3.0"

  property string myPattern: ""
    Settings {
        id: settings
        property string myUrl
    }

    Timer {
        id: checkUrlTimer
        interval: 500
        running: false
        repeat: false
        onTriggered: {
            if (!settings.myUrl) {
                PopupUtils.open(settingsComponent, root, {url: settings.myUrl});
            }
        }
    }

    Component {
        id: settingsComponent

        Dialog {
            id: settingsDialog
            text: i18n.tr('Please, introduce the FQDN of your Zimbra server<br>(e.g. zimbra.example.com).')

            property alias url: address.text
            onVisibleChanged: {
                if (visible) {
                    address.forceActiveFocus();
                }
            }

            function saveUrl() {
                var url = address.text;
                if (url && url.substring(0, 7) != 'http://' && url.substring(0, 8) != 'https://') {
                    url = 'https://' + url;
                }

                address.focus = false
                settings.myUrl = url;
                PopupUtils.close(settingsDialog);
            }

            TextField {
                id: address
                width: parent.width
                inputMethodHints: Qt.ImhUrlCharactersOnly | Qt.ImhNoPredictiveText | Qt.ImhNoAutoUppercase

                onAccepted: settingsDialog.saveUrl()
            }

            Button {
                text: i18n.tr('OK')
                color: UbuntuColors.green

                onClicked: settingsDialog.saveUrl()
            }
        }
    }

    Component.onCompleted: {
        checkUrlTimer.start();
    }

Page {
    title: i18n.tr("Zimbra Connector")
    header: PageHeader {
        id: mainHeader
        title: parent.title
        flickable: flick
        trailingActionBar {
            actions: [
            Action {
                iconName: "info"
                text: i18n.tr("About")
                onTriggered: PopupUtils.open(Qt.resolvedUrl("About.qml"))
            },
            Action {
                iconName: "help"
                text: "Help"
                onTriggered: PopupUtils.open(Qt.resolvedUrl("OfflinePage.qml")) 
            }
            ]
            numberOfSlots: 2
        }
    }

    Flickable {
        id: flick
        anchors {
            fill: parent
            margins: root.width > units.gu(125) ? root.width / 5 : units.gu(3)
            topMargin: 0
            bottomMargin: 0
        }
        clip: true
        contentWidth: aboutColumn.width
        contentHeight: aboutColumn.height

        Column {
            id: aboutColumn
                width: parent.parent.width
                spacing: units.gu(3)

            ZimbraDivider {
              text: "General"
            }

            Label {
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                text: i18n.tr("\n")
            }

            Image {
                width: units.gu(12); height: units.gu(12)
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Image.AlignHCenter
                source: Qt.resolvedUrl("../img/logo.png")
            }

            Label {
                width: parent.width           
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                text: i18n.tr("Thanks for using the Zimbra \n Connector for Ubuntu Touch!")
                fontSize: "large"
            }

            Label {
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                text: i18n.tr("Get loged in to your \n personal Zimbra Server.")
                fontSize: "large"
            }

            ZimbraDivider {
              text: "Connection"
            }

            Image {
                width: units.gu(12); height: units.gu(12)
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Image.AlignHCenter
                source: Qt.resolvedUrl("../img/connect.png")
            }

            Button {
                width: parent.width
                Layout.alignment: Qt.AlignHCenter
                color: UbuntuColors.green 
                text: i18n.tr("Connect to your Zimbra Server")
                onClicked: Qt.openUrlExternally(settings.myUrl)
            }
        }
     }
  }
}
