var firestore = require('./database')

class ProductController{
    //CRUD operation

    async deleteProduct(req, res){
        try {
            console.log("Received POST request to /delete");
            const id = req.body.id;
            const productCollection = firestore.collection("Products");
            await productCollection.doc(String(id)).delete().then(() => {
            res.send("Delete product successfully");
            }).catch((error) => {
            console.error("Error setting product:", error);
            res.status(500).send("Error setting product.");
            })
        } catch (error) {
            console.error("Error:", error);
            res.status(500).send("Error.");
        }
    }
    async updateProduct(req, res) {
        try {
            console.log("Received POST request to /update");
            console.log(req.body)
            const id = req.body.id;
            const product = {
            id,
            title: req.body.title,
            description: req.body.description,
            images: req.body.images,
            price: req.body.price,
            colors: req.body.colors,
            rating: req.body.rating,
            isFavourite: req.body.isFavourite,
            isPopular: req.body.isPopular
            }
            console.log("Product data:", product); // Log product data
            const productCollection = firestore.collection("Products");
            await productCollection.doc(String(id)).set(product).then(() => {
                res.send("Update product successfully");
            }).catch((error) => {
                console.error("Error setting product:", error);
                res.status(500).send("Error setting product.");
            })
        } catch (error) {
            console.error("Error:", error);
            res.status(500).send("Error.");
        }
    }
    async readAllProducts(req, res){
        console.log("Received GET request to /");
        var allProduct = [];
        const collectionRef = firestore.collection('Products');
        await collectionRef.get()
        .then((snapshot) => {
            snapshot.forEach((doc) => {
                allProduct.push(JSON.stringify(doc.data()));           
            });
            res.json(allProduct)
            // console.log(allProduct)
        })
        .catch((error) => {
            console.error('Error getting documents', error);
        });
    }

}

module.exports = new ProductController;