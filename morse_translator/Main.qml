import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Dialogs 6.2
import Qt.labs.platform 1.1
Window {
    width: 400
    height: 300
    minimumWidth: saveButton.width + fileButton.width +30
    minimumHeight:buttonsRow.height*3
    visible: true
    title: qsTr("Морзе Переводчик")
    Column {
        spacing: 10
        width: parent.width
        height: parent.height
        anchors.centerIn: parent
        Row{
            id: buttonsRow
            FileDialog{
                id:fileDialog
                title: "Документ"
                nameFilters: ["Текстовые файлы (*.txt)","Все файлы (*)"]
                onAccepted: {var filePath=fileDialog.file.toString()
                    filePath=filePath.replace("file:///","")
               sourceText.text=handler.readText(filePath)}
            }
            FolderDialog{
                id:save
                title: "Сохраните файл"
                onAccepted: {var filePath=save.folder.toString()
                    filePath=filePath.replace("file:///","")
                    handler.save(filePath,translatedText.text)
                }
                onRejected: {filepath.text="Выбор отменен"}
            }
            Row{
                anchors.left:parent
                spacing:20
                leftPadding:10
                Column{
                    width: fileButton.width
                    height: fileButton.height
                    Button {
                        id: fileButton
                        text: "Выбрать файл"
                        onClicked:{fileDialog.open()}
                    }
                }
                Column{
                    width: saveButton.width
                    height: saveButton.height
                    Button {
                        id:saveButton
                        text: "Сохранить как"
                        onClicked:{save.open()}
                    }
                }
            }
        }
        Row{
            width: parent.width
            height: parent.height-2*buttonsRow.height
            spacing: 15
            Column{
                width: parent.width/2-change.width
                height: parent.height
                    TextArea {
                        id: sourceText
                        placeholderText: "Введите текст"
                        width: parent.width
                        height: parent.height
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        wrapMode: Text.Wrap
                        background:
                            Rectangle {
                                radius: 2
                                border.color: "grey"
                                border.width: 1
                                }
                        onTextChanged: if(sourceText.text.match(/^[\.\-\s]+$/)){
                                            translatedText.text = morse.decode(sourceText.text)
                                            }
                                        else{
                                            translatedText.text = morse.encode(sourceText.text)
                                        }
                    }
            }
            Column{
                width: change.width
                height: change.height
                topPadding: sourceText.height/3
                Button {
                    id: change
                    text:"<->"
                    onClicked:{
                        sourceText.text = translatedText.text
                    }
            }
            }
            Column{
                width: parent.width/2 - change.width
                height: parent.height
                TextArea {
                    id: translatedText
                    placeholderText: "Перевод"
                    width: parent.width
                    height: parent.height
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    wrapMode: Text.Wrap
                    clip: true
                    readOnly: true
                    background:
                        Rectangle {
                            radius: 2
                            border.color: "grey"
                            border.width: 1
                            }
                }
            }
        }
    }
}
