/*
 * Copyright (C) 2026  Harald Ferihumer
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * calc is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.7
import Lomiri.Components 1.3

MainView {
    applicationName: "calc.ferihumh"

    PageStack {
        Page {
            id: mainPage

            // --- Echter Lomiri Header ---
            header: PageHeader {
                id: header
                title: "kgv & ggT calculation"
            }

            // --- Inhalt direkt auf der Page ---
            Column {
                id: contentColumn

                anchors {
                    // WICHTIG:
                    // Der Inhalt beginnt unterhalb des Headers.
                    // Der unsichtbare Page-Offset wird automatisch berücksichtigt.
                    top: header.bottom
                    left: parent.left
                    right: parent.right
                    margins: units.gu(2)
                }

                spacing: units.gu(2)

                // --- Eingaben ---
                Label {
                    text: "Eingaben"
                    font.bold: true
                }

                Row {
                    spacing: units.gu(2)
                    width: parent.width
                    height: units.gu(4)

                    TextField {
                        id: zahl1
                        placeholderText: "Zahl 1"
                        height: parent.height
                        verticalAlignment: Text.AlignVCenter
                        width: parent.width / 2 - units.gu(1)
                    }

                    TextField {
                        id: zahl2
                        placeholderText: "Zahl 2"
                        height: parent.height
                        verticalAlignment: Text.AlignVCenter
                        width: parent.width / 2 - units.gu(1)
                    }
                }

                // --- Ausgaben ---
                Label {
                    text: "Ausgaben"
                    font.bold: true
                }

                Row {
                    spacing: units.gu(1)
                    width: parent.width
                    height: units.gu(4)

                    Label {
                        text: "kgv:"
                        anchors.verticalCenter: parent.verticalCenter
                        width: units.gu(6)
                    }

                    TextField {
                        id: kgvField
                        placeholderText: "kgV"
                        height: parent.height
                        anchors.verticalCenter: parent.verticalCenter
                        width: parent.width - units.gu(6)
                        readOnly: true
                    }
                }

                Row {
                    spacing: units.gu(1)
                    width: parent.width
                    height: units.gu(4)

                    Label {
                        text: "ggT:"
                        anchors.verticalCenter: parent.verticalCenter
                        width: units.gu(6)
                    }

                    TextField {
                        id: ggtField
                        placeholderText: "ggT"
                        height: parent.height
                        anchors.verticalCenter: parent.verticalCenter
                        width: parent.width - units.gu(6)
                        readOnly: true
                    }
                }

                Button {
                    text: "Berechnen"
                    width: parent.width

                    onClicked: {
                        function gcd(x, y) {
                            x = Math.abs(parseInt(x))
                            y = Math.abs(parseInt(y))
                            if (isNaN(x) || isNaN(y)) return NaN
                            if (x === 0 && y === 0) return 0
                            while (y !== 0) {
                                var t = x % y
                                x = y
                                y = t
                            }
                            return x
                        }

                        function lcm(x, y) {
                            x = parseInt(x)
                            y = parseInt(y)
                            if (isNaN(x) || isNaN(y)) return NaN
                            if (x === 0 || y === 0) return 0
                            var g = gcd(x, y)
                            return Math.abs((x / g) * y)
                        }

                        var a = zahl1.text
                        var b = zahl2.text

                        var g = gcd(a, b)
                        var l = lcm(a, b)

                        if (!isNaN(g) && !isNaN(l)) {
                            kgvField.text = l.toString()
                            ggtField.text = g.toString()
                        } else {
                            kgvField.text = ""
                            ggtField.text = ""
                        }
                    }
                }
            }
        }
    }
}


