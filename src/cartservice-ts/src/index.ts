import express from 'express';
import bodyParser from 'body-parser';
import { getCart, addItem, emptyCart } from './handlers';

export const app = express();
const port = process.env.PORT || 3000;

app.use(bodyParser.json());

app.get('/cart/:userId', getCart);
app.post('/cart', addItem);
app.delete('/cart/:userId', emptyCart);

if (process.env.NODE_ENV !== 'test') {
  app.listen(port, () => {
    console.log(`Cart service listening at http://localhost:${port}`);
  });
}
