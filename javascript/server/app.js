import express from 'express';
import userRoute from './routes/user.js';
import categoryRoute from './routes/category.js';
import purchaseRoute from './routes/purchase.js';
import deliveryTypeRoute from './routes/deliveryType.js';
import productRoute from './routes/product.js';
import paymentTypeRoute from './routes/paymentType.js';
import { allowCrossDomain, corsOptions } from './middleware/corsOptions.js';
import errorHandler from './middleware/errorHandler.js';
import cors from 'cors';

const app = express();
const port = 3000;

app.use(express.urlencoded({extended: false}));
app.use(express.json());
app.use(cors(corsOptions));
app.use(allowCrossDomain);
app.use(errorHandler);

app.get('/', (req, res) => {
  res.send('hello world!');
});
app.use('/category', categoryRoute);
app.use('/user', userRoute);
app.use('/purchase', purchaseRoute);
app.use('/delivery-type', deliveryTypeRoute);
app.use('/product', productRoute);
app.use('/payment-type', paymentTypeRoute);

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});