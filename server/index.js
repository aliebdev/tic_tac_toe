// import modules
const { log } = require('console');
const express = require('express');
const http = require('http');
const mongoose = require('mongoose');


const app = express();

const port = process.env.port || 3000;
var server = http.createServer(app);
const Room = require("./models/room")

var io = require("socket.io")(server)

// middleware 
app.use(express.json())

const DB = "mongodb+srv://ali:test1234@cluster0.uedygvp.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";

io.on('connection', (socket) => {
    console.log('connected!');

    socket.on("createRoom", async ({ nickname }) => {
        console.log(nickname);

        try {
            let room = new Room();
            let player = {
                socketID: socket.id,
                nickname,
                playerType: 'X',
            };
            room.players.push(player);
            room.turn = player;

            room = await room.save();
            console.log(room);
            const roomId = room._id.toString();

            socket.join(roomId);
            // io -> send data to everyone
            // socket -> sending data to yourself
            io.to(roomId).emit('createRoomSuccess', room);
        } catch (error) {
            console.log(error);
        }

    });
});

mongoose.connect(DB).then(
    () => {
        console.log('Connection successful!');
    }
).catch((e) => {
    console.log(e);
});

server.listen(port, '0.0.0.0', () => {
    console.log(`Server started running on port ${port}`)
})