import logger from './common/logger';
import { InputProps } from './common/entity';

export default class SaeCtlComponent {
  /**
   * demo 实例
   * @param inputs
   * @returns
   */
  public async index(inputs: InputProps) {
    logger.debug(`input: ${JSON.stringify(inputs.props)}`);
    logger.info('command test');
    return { hello: 'world' };
  }
}
