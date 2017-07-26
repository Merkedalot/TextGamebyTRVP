import VPlayApps 1.0
import QtQuick 2.0
import VPlay 2.0

App {

    property var newMsgs: []
    property var inputText: []
    property var gametextstring: ["Welcome, enter your name below"]
    property int action: 0

    //signal must be part of the object
    signal submitTextField(string text)

    // this function is our QML slot
    function setTextField(text){
        console.log("setTextField: " + text)
        //inputBox.text = text
        console.log("You entered"  + text)
        mainText.text = "You entered: " + text//inputBox.text

    }

    NavigationStack {

        Page {
            title: qsTr("Text Game by TR")

            AppText {
                id: mainText
                objectName: "gametext"
                anchors.top: parent.top
                anchors.topMargin: dp(20)
                anchors.horizontalCenter: parent.horizontalCenter
                text: ""+gametextstring
            }

            Image {
                source: "../assets/vplay-logo.png"
                anchors.centerIn: parent
            }

            AppTextField {
                id: inputBox


                objectName: "playerstext"
                height: dp(48)
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: dp(8)
                anchors.rightMargin: dp(8)
                anchors.bottomMargin: dp(20)
                font.pixelSize: sp(16)
                placeholderText: "Type a command and hit enter..."
                placeholderColor: "white"
                backgroundColor: "gray"
                textColor: "white"
                verticalAlignment: Text.AlignVCenter

                onAccepted: {
                    newMsgs = newMsgs.concat({me: true, text: inputBox.text})
                    action++

                    // emit the submitTextField signal
                    submitTextField(inputBox.text)
                    //clear the input box and text
                    inputBox.text = ""

                }
            }
        }
    }
}
