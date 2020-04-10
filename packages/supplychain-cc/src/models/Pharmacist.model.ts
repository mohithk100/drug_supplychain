import * as yup from "yup";
import { ConvectorModel, Default, ReadOnly, Required, Validate } from "@worldsibu/convector-core-model";
import { BaseStorage } from '@worldsibu/convector-core-storage';


export class Pharmacist extends ConvectorModel<Pharmacist> {
    @ReadOnly()
    @Required()
    public readonly type: string = "io.pharmachain.Pharmacist";

    @Validate(yup.string())
    public x509Identity: string;

    @Required()
    @Validate(yup.string())
    public address: string;

    @Required()
    @Validate(yup.string())
    public organizationName: string;

    @Required()
    @Validate(yup.string())
    public authorityNumber: string;

    @Required()
    @Validate(yup.number())
    public drugBatchsAvailable: number = 0;

    @Required()
    @Validate(yup.number())
    public drugsSold: number = 0;

    public static async getOne<T extends ConvectorModel<any>>(
        this: new (content: any) => T,
        id: string,
        type?: new (content: any) => T,
        storageOptions?: any
    ): Promise<T> {
        type = type || this;
        const content = await BaseStorage.current.get(id, storageOptions);
        if (content == null) {
            return Object({ "success": false });
        }

        let model = new type(content);
        if ((content && model) && content.type !== model.type) {
            throw new Error(`Possible ID collision, element ${id} of type ${content.type} is not ${model.type}`);
        }

        model["success"] = true;
        return model;
    }

}
