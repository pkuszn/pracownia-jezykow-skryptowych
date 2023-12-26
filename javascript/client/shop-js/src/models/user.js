export class User {
    id;
    name;
    surname;
    password;
    address;
    created_date;

    constructor(
        id,
        name,
        surname,
        password,
        address,
        created_date,
    ) {
        this.id = id;
        this.name = name;
        this.surname = surname;
        this.password = password;
        this.address = address;
        this.created_date = created_date;
    }
}