const productRouter = require('./product')
const userRouter = require('./user')
const orderRouter = require('./order')

function route(app) {
    app.use('/home', productRouter)
    app.use('/products', productRouter)
    app.use('/users', userRouter)
    app.use('/orders', orderRouter)
}

module.exports = route;