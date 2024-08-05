const mongoose = require('mongoose');

const playerSchema = new mongoose.Schema({
    nicname: {
        type: String,
        trim: true,
    },
    socketID: {
        type: String,
    },
    points: {
        type: Number,
        default: 0,
    },
    playerType: {
        require: true,
        type: String,
    }
});

module.exports = playerSchema;