import { logEvents } from './logEvent.js';

const errorHandler = async (err, req, res, next) => {
        await logEvents(`${err.name}: ${err.message}`, 'errorLog.txt');
        console.error(err.stack);
        res.status(500).send(err.message);
};

export default errorHandler;