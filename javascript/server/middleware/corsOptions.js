const whitelist = [
    'http://127.0.0.1:3000',
    "http://localhost:3000",
];

const corsOptions = {
    origin: (origin, callback) => {
        if(whitelist.indexOf(origin) !== -1 || !origin){
            callback(null, true);
        } else{
            callback(new Error('Not Allowed by CORS'));
        }

    },
    optionsSuccessSTatus: 200,
    credentials: true
}

const allowCrossDomain = (req, res, next) => {
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    next();
}

export {
    allowCrossDomain,
    corsOptions
}