export class Response {
    data;
    status;
    message;

    constructor(
        data,
        status,
        message
    ) {
      this.data = data;
      this.status = status;
      this.message = message;  
    }
}