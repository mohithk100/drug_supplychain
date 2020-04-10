import * as yup from "yup";
import {
    ConvectorModel,
    Default,
    ReadOnly,
    Required,
    Validate,
    FlatConvectorModel
} from "@worldsibu/convector-core-model";
import { SaltBatch } from "./saltBatch.model";
import { BaseStorage } from '@worldsibu/convector-core-storage';


export class Supplier extends ConvectorModel<Supplier> {
    @ReadOnly()
    @Required()
    public readonly type: string = "io.pharmachain.Supplier";

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

    @Validate(yup.array(SaltBatch.schema()))
    @Required()
    public rawMaterialAvailable: Array<FlatConvectorModel<SaltBatch>>;

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
