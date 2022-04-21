import { Injectable } from '@nestjs/common';

@Injectable()
export default class AppService {
  // eslint-disable-next-line class-methods-use-this
  getHello(): string {
    return 'Hello World!';
  }
}
