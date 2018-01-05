import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import "../view_models"
import "../utils/Icons.js" as MdiFont
import "../utils"

BabeGrid
{
    id:albumsView
    visible: true
    albumSize: 150
    borderRadius: 20

    property string drawerAlbum
    property string drawerArtist

    Drawer
    {
        id: drawer
        height: parent.height * 0.4
        width: parent.width
        edge: Qt.BottomEdge
        interactive: false

        Column
        {
            anchors.fill: parent

            Rectangle
            {
                id: titleBar
                width: parent.width
                height: 48
                z: 1

                Row
                {
                    anchors.fill: parent

                    Label
                    {
                        id: albumTitle
                        width: parent.width - closeBtn.width
                        height: parent.height
                        text: drawerAlbum
                        elide: Text.ElideRight
                        font.pointSize: 12
                        font.bold: true
                        lineHeight: 0.7

                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment:  Text.AlignVCenter
                    }


                    ToolButton
                    {
                        id: closeBtn
                        width: parent.height
                        height: parent.height

                        Icon
                        {
                            text: MdiFont.Icon.close
                        }

                        onClicked:
                        {
                            drawer.close()
                            console.log("close drawer")
                        }
                    }
                }
            }

            BabeTable
            {
                id: drawerList
                width: parent.width
                height: parent.height - titleBar.height

            }

        }
    }

    onAlbumCoverClicked:
    {
        drawerAlbum = album
        drawerArtist = artist
        drawer.open()
        console.log("haha: ", album, artist)
        var query = "select * from tracks where album = \""+albumsView.drawerAlbum+"\" and artist = \""+albumsView.drawerArtist+"\""
        console.log(query)
        var map = con.get(query)

        for(var i in map)
        {
            drawerList.model.append(map[i])
            console.log(map[i].title)
        }
    }


    Component.onCompleted:
    {
        var map = con.get("select * from albums")
        for(var i in map)
        {
            gridModel.append(map[i])
        }
    }

}
