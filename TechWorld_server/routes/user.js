const express = require('express')
var router = express.Router()
const userController = require('../models/user')

router.post('/update', userController.update)
router.get('/:uid', userController.takeData)

module.exports = router