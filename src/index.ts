import { InputProps } from './common/entity';
import { checkAndInstallSaeCtl } from "./utils/install";
import { SaeCtlCmd } from "./common/saectl";
import * as core from '@serverless-devs/core';

export default class SaeCtlComponent {
  /**
   * demo 实例
   * @param inputs
   * @returns
   */
  public async index(inputs: InputProps) {
    let target = await checkAndInstallSaeCtl();
    const credentials = await core.getCredential(inputs.project?.access);
    let saeCtlCmd = new SaeCtlCmd(inputs, credentials, target);
    await saeCtlCmd.run();
  }

  public async saectl(inputs: InputProps) {
    await this.index(inputs)
  }
}
