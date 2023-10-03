const { query } = require('express')
const firestore = require('./database')

class OrderController{
    async takeAllOrdersByAdmin(req, res){
        var allOrders = []
        const collectionRef = firestore.collection('Orders')
        await collectionRef.get()
        .then((data) =>{
            data.forEach((element) => {
                allOrders.push(element.data())
            })
            console.log("Take orders data successfully");
            res.json(allOrders);
        })
    }
    
    async createOrder(req, res){
        const order = {
            'address': req.body.address,
            'createAt': req.body.createAt,
            'id': req.body.id,
            'listItem': req.body.listItem,
            'status': req.body.status,
            'total': req.body.total,
            'uid': req.body.uid
        }
        const collectionRef = firestore.collection('Orders')
        await collectionRef.add(order)
        .then(()=>{
            console.log('Create order successfully')
            res.send('Create order successfully')
        })
        .catch((error) => {
            console.log(error)
        })
    }

    async takeOrdersByUser(req, res){
        var orderList = []
        const collectionRef = firestore.collection('Orders')
        const uid = req.params.uid;
        const snapshot = await collectionRef.where('uid', '==', String(uid)).get();
        if(snapshot.empty){
            res.send("You dont have any order");
        }
        else{
            snapshot.forEach((element) => {
                orderList.push(element.data());
            })
            res.json(orderList)
        }


    }

}

module.exports = new OrderController;