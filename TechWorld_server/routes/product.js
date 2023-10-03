const express = require('express')
var router = express.Router()
const productController = require('../models/product')

router.post('/update', productController.updateProduct)
router.post('/delete', productController.deleteProduct)
router.get('/', productController.readAllProducts)

module.exports = router