interface CartItem {
  productId: string;
  quantity: number;
}

interface Cart {
  userId: string;
  items: CartItem[];
}

const carts: { [userId: string]: Cart } = {};

export const getCart = (userId: string): Cart => {
  return carts[userId] || { userId, items: [] };
};

export const addItem = (userId: string, item: CartItem) => {
  if (!carts[userId]) {
    carts[userId] = { userId, items: [] };
  }
  carts[userId].items.push(item);
};

export const emptyCart = (userId: string) => {
  if (carts[userId]) {
    carts[userId].items = [];
  }
};
