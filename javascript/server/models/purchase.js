export class purchase {
    id;
    id_product;
    id_user;
    price;
    quantity;
    purchase_date;
    delivery_type;

    constructor(
        id,
        id_product,
        id_user,
        price,
        quantity,
        purchase_date,
        delivery_type
    ) {
        this.id = id;
        this.id_product = id_product;
        this.id_user = id_user;
        this.price = price;
        this.quantity = quantity;
        this.purchase_date = purchase_date;
        this.delivery_type = delivery_type;
    }
}
