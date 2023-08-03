/*
 *   Copyright 2014 Marco Martin <mart@kde.org>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License version 2,
 *   or (at your option) any later version, as published by the Free
 *   Software Foundation
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details
 *
 *   You should have received a copy of the GNU General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

import QtGraphicalEffects 1.0
import QtQuick 2.5

Image {
    id: root

    property int stage

    source: "images/BGcoopertronicBlue.png"
    fillMode: Image.PreserveAspectCrop
    onStageChanged: {
        if (stage == 2) {
            introAnimation.running = true;
        } else if (stage == 5) {
            introAnimation.target = busyIndicator;
            introAnimation.from = 1;
            introAnimation.to = 0;
            introAnimation.running = true;
        }
    }

    Item {
        id: content

        anchors.fill: parent
        opacity: 0

        TextMetrics {
            id: units

            property int gridUnit: boundingRect.height
            property int largeSpacing: units.gridUnit
            property int smallSpacing: Math.max(2, gridUnit / 4)

            text: "M"
        }

        Image {
            id: logo1

            //match SDDM/lockscreen avatar positioning
            property real size: units.gridUnit * 64

            opacity: 0.15
            anchors.centerIn: parent
            source: "images/dragon-circle.black.red.coopertronic.3D-icon.2021.png"
            sourceSize.width: size
            sourceSize.height: size

            OpacityAnimator {
                id: fadeInOut1

                from: 0.15
                to: 0.45
                duration: 2400
                easing.type: Easing.InOutQuad
                loops: Animation.Infinite
                running: true
                target: logo1
            }

        }

        Image {
            id: logo2

            //match SDDM/lockscreen avatar positioning
            property real size: units.gridUnit * 64

            opacity: 0.45
            anchors.centerIn: parent
            source: "images/dragon-circle.black.red.coopertronic.3D-icon.2021.png"
            sourceSize.width: size
            sourceSize.height: size

            OpacityAnimator {
                id: fadeInOut2

                from: 0.45
                to: 0.15
                duration: 100
                easing.type: Easing.InOutQuad
                loops: Animation.Infinite
                running: true
                target: logo2
            }

        }

        FontLoader {
            source: "../components/artwork/fonts/NotoSans MED.ttf"
        }

        Text {
            id: date

            text: Qt.formatDateTime(new Date(), "dddd, hh:mm AP")
            font.pointSize: 36
            color: "#10ff00"
            opacity: 0.85
            anchors.horizontalCenter: parent.horizontalCenter
            y: (parent.height - height) / 2.7

            font {
                family: "NotoSans MED"
                weight: Font.Light
                capitalization: Font.Capitalize
            }

        }

        Image {
            id: busyIndicator1

            //in the middle of the remaining space
            //y: (parent.height - height) / 1.7
            y: root.height - (root.height - logo.y) / 1.5 - height / 2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            source: "images/busywidget3.svg"
            opacity: 0.33
            sourceSize.height: units.gridUnit * 6
            sourceSize.width: units.gridUnit * 6

            RotationAnimator on rotation {
                id: rotationAnimator1

                from: 360
                to: 0
                duration: 1100
                loops: Animation.Infinite
            }

        }

        Image {
            id: busyIndicator2

            //in the middle of the remaining space
            //y: (parent.height - height) / 1.7
            y: root.height - (root.height - logo.y) / 1.5 - height / 2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            source: "images/busywidget.svg"
            opacity: 0.33
            sourceSize.height: units.gridUnit * 7.2
            sourceSize.width: units.gridUnit * 7.2

            RotationAnimator on rotation {
                id: rotationAnimator2

                from: 0
                to: 360
                duration: 1100
                loops: Animation.Infinite
            }

        }

        Row {
            spacing: units.smallSpacing * 2

            anchors {
                bottom: parent.bottom
                right: parent.right
                rightMargin: units.gridUnit * 1.5
                margins: units.gridUnit
            }

            Image {
                source: "images/plasma-5-banner.png"
                sourceSize.height: units.gridUnit * 8
                sourceSize.width: units.gridUnit * 8
            }

        }

    }

    OpacityAnimator {
        id: introAnimation

        running: false
        target: content
        from: 0
        to: 1
        duration: 400
        easing.type: Easing.InOutQuad
    }

}
