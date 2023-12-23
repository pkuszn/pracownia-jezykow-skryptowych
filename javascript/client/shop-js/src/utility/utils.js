import {api, category} from './const.js'

const combiner = (endpoint, args) => {
    let address = api.address;
    if (args === undefined || args === "") {
        return [address, endpoint].join('/');
    }
    return [address, endpoint, args].join('/');
}

const categoryMapper = (idCategory) => {
    switch (idCategory) {
        case 1: {
            return category.blackTeas;
        }
        case 2: {
            return category.greenTeas;
        }
        case 3: {
            return category.whiteTeas;
        }
        case 4: {
            return category.oolongTeas;
        }
        case 5: {
            return category.fruitTeas;
        }
        case 6: {
            return category.teaAccessories;
        }
        default: {
            return category.blackTeas;
        }
    }
}

export {
    categoryMapper,
    combiner
}