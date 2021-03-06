/*
  Q Light Controller Plus
  VCButtonProperties.qml

  Copyright (c) Massimo Callegari

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0.txt

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
*/

import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1

import org.qlcplus.classes 1.0
import "."

Rectangle
{
    color: "transparent"
    height: bPropsColumn.height

    property VCButton widgetRef: null
    property Function func
    property int funcID: widgetRef ? widgetRef.functionID : -1
    property int gridItemsHeight: UISettings.listItemHeight
    property real startupIntensity: widgetRef ? widgetRef.startupIntensity * 100 : 100

    //onWidgetRefChanged: func = functionManager.getFunction(widgetRef.functionID)

    onFuncIDChanged: func = functionManager.getFunction(funcID)

    Column
    {
        id: bPropsColumn
        width: parent.width
        spacing: 5

        SectionBox
        {
            id: btnFuncProps
            sectionLabel: qsTr("Attached Function")

            sectionContents:
              GridLayout
              {
                width: parent.width
                columns: 2
                columnSpacing: 5
                rowSpacing: 4

                // row 1
                IconTextEntry
                {
                    id: funcBox
                    Layout.columnSpan: 2
                    Layout.fillWidth: true

                    tFontSize: UISettings.textSizeDefault

                    tLabel: func ? func.name : ""
                    functionType: func ? func.type : -1

                    IconButton
                    {
                        anchors.top: parent.top
                        anchors.right: parent.right
                        imgSource: "qrc:/reset.svg"
                        tooltip: qsTr("Detach the current function")
                        onClicked: widgetRef.functionID = -1
                    }
                }

              } // GridLayout
        } // SectionBox

        SectionBox
        {
            id: btnPressProps
            sectionLabel: qsTr("Pressure behaviour")

            sectionContents:
              GridLayout
              {
                width: parent.width
                columns: 2
                columnSpacing: 5
                rowSpacing: 3

                ButtonGroup { id: pressBehaviourGroup }

                // row 1
                RobotoText
                {
                    height: gridItemsHeight
                    Layout.fillWidth: true
                    label: qsTr("Toggle Function on/off")
                }

                CustomCheckBox
                {
                    implicitWidth: UISettings.iconSizeMedium
                    implicitHeight: implicitWidth
                    ButtonGroup.group: pressBehaviourGroup
                    checked: widgetRef ? widgetRef.actionType === VCButton.Toggle : false
                    onClicked: if (checked && widgetRef) widgetRef.actionType = VCButton.Toggle
                }

                // row 2
                RobotoText
                {
                    height: gridItemsHeight
                    Layout.fillWidth: true
                    label: qsTr("Flash Function (only for Scenes)")
                }

                CustomCheckBox
                {
                    implicitWidth: UISettings.iconSizeMedium
                    implicitHeight: implicitWidth
                    ButtonGroup.group: pressBehaviourGroup
                    checked: widgetRef ? widgetRef.actionType === VCButton.Flash : false
                    onClicked: if (checked && widgetRef) widgetRef.actionType = VCButton.Flash
                }

                // row 3
                RobotoText
                {
                    height: gridItemsHeight
                    Layout.fillWidth: true
                    label: qsTr("Toggle Blackout")
                }

                CustomCheckBox
                {
                    implicitWidth: UISettings.iconSizeMedium
                    implicitHeight: implicitWidth
                    ButtonGroup.group: pressBehaviourGroup
                    checked: widgetRef ? widgetRef.actionType === VCButton.Blackout : false
                    onClicked: if (checked && widgetRef) widgetRef.actionType = VCButton.Blackout
                }

                // row 4
                RobotoText
                {
                    height: gridItemsHeight
                    Layout.fillWidth: true
                    label: qsTr("Stop all Functions")
                }

                CustomCheckBox
                {
                    implicitWidth: UISettings.iconSizeMedium
                    implicitHeight: implicitWidth
                    ButtonGroup.group: pressBehaviourGroup
                    checked: widgetRef ? widgetRef.actionType === VCButton.StopAll : false
                    onClicked: if (checked && widgetRef) widgetRef.actionType = VCButton.StopAll
                }

              } // GridLayout
        } // SectionBox

        SectionBox
        {
            id: startupIntensityProps
            sectionLabel: qsTr("Adjust Function intensity")

            sectionContents:
              RowLayout
              {
                  width: parent.width
                  spacing: 5

                  CustomCheckBox
                  {
                      id: startupIntCheck
                      implicitWidth: UISettings.iconSizeMedium
                      implicitHeight: implicitWidth
                      autoExclusive: false
                      checked: widgetRef ? widgetRef.startupIntensityEnabled : false
                      onClicked: if (widgetRef) widgetRef.startupIntensityEnabled = checked
                  }

                  Slider
                  {
                      id: siSlider
                      enabled: startupIntCheck.checked
                      Layout.fillWidth: true
                      orientation: Qt.Horizontal
                      from: 0
                      to: 100
                      value: startupIntensity
                      handle: Rectangle {
                          x: siSlider.leftPadding + siSlider.visualPosition * (siSlider.availableWidth - width)
                          y: siSlider.topPadding + siSlider.availableHeight / 2 - height / 2
                          implicitWidth: UISettings.listItemHeight * 0.8
                          implicitHeight: UISettings.listItemHeight * 0.8
                          radius: implicitWidth / 5
                      }

                      onPositionChanged: if (widgetRef) widgetRef.startupIntensity = value / 100

                      Rectangle
                      {
                          anchors.fill: parent
                          z: 3
                          color: "black"
                          opacity: 0.6
                          visible: !parent.enabled
                      }
                  }

                  CustomSpinBox
                  {
                      id: wSpin
                      enabled: startupIntCheck.checked
                      width: UISettings.bigItemHeight * 0.7
                      height: UISettings.listItemHeight
                      from: 0
                      to: 100
                      suffix: "%"
                      value: startupIntensity
                      onValueChanged: if (widgetRef) widgetRef.startupIntensity = value / 100
                  }
              }
        }
    } // Column
}
