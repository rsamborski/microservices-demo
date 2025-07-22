import { Request, Response } from 'express';
import { getCart as getCartFromStore, addItem as addItemToStore, emptyCart as emptyCartInStore } from './cart';

export const getCart = (req: Request, res: Response) => {
  const { userId } = req.params;
  const cart = getCartFromStore(userId);
  res.status(200).json(cart);
};

export const addItem = (req: Request, res: Response) => {
  const { userId, item } = req.body;
  addItemToStore(userId, item);
  res.status(201).send();
};

export const emptyCart = (req: Request, res: Response) => {
  const { userId } = req.params;
  emptyCartInStore(userId);
  res.status(204).send();
};
