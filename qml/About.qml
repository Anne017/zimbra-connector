import QtQuick 2.9
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3
import QtQuick.Layouts 1.1

Dialog {
            id: aboutDialog
            visible: false
            title: i18n.tr("About \n Zimbra Connector "+root.appVersion)
            text: i18n.tr("This is a Zimbra Connector for<br>Ubuntu Touch.")

            Image {
                anchors.horizontalCenter: parent     
                source: '../img/about.png'
                fillMode: Image.PreserveAspectFit 
            }

            Text {
                wrapMode: Text.WordWrap
                text: i18n.tr('Thanks to Jeroen Bots and Ewald Pierre for suggestions and testing!')
            }


            Text {
                wrapMode: Text.WordWrap
                text: i18n.tr('Copyright (c) 2018-2020 <br> by Rudi Timmermans  <br><br> E-Mail: <a href=\"mailto://rudi.timmer@gmx.com\">rudi.timmer@gmx.com</a>')
            }

            Button {
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter

                color: UbuntuColors.orange
                text: i18n.tr('Donate')
                onClicked: Qt.openUrlExternally('https://www.paypal.com/paypalme/RudiTimmermans')
             }

            Button {
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter

                color: UbuntuColors.green 
                text: i18n.tr('OK')
                onClicked: PopupUtils.close(aboutDialog)
            }
        }

