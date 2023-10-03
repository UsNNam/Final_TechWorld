const firestore = require('./database')

class UserController{

    async update(req, res){
        try {
            const uid = req.body.uid;
            const collectionRef = firestore.collection('Users');
            var userData = {
                'address': req.body.address,
                'firstName': req.body.firstName,
                'lastName': req.body.lastName,
                'phoneNumber': req.body.phoneNumber
            }
            await collectionRef.doc(String(uid)).set(userData)
            .then(() => res.send('Update user data successfully!'))
            .catch((error) => {
                console.log(error);
            })
        } catch (error) {
            console.log(error)
        }
        
    }

    async takeData(req, res) {
        const uid = req.params.uid;
        console.log(uid);
        const collectionRef = firestore.collection('Users');
        await collectionRef.doc(String(uid)).get()
        .then((data) =>{
                res.json(data.data());
                console.log('Take user data successfully');
            }
        )
        .catch((error) =>{
            console.log(error);
        })
    }
}

module.exports = new UserController;