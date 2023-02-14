import { InputProps } from './common/entity';
export default class SaeCtlComponent {
    /**
     * demo 实例
     * @param inputs
     * @returns
     */
    index(inputs: InputProps): Promise<{
        hello: string;
    }>;
}
