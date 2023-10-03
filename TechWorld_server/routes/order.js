const express = require('express')
var router = express.Router()
const orderController = require('../models/order')

router.get('/admin', orderController.takeAllOrdersByAdmin)
router.get('/:uid', orderController.takeOrdersByUser)
router.post('/create', orderController.createOrder)

module.exports = router