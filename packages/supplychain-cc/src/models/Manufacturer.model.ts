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


export class Manufacturer extends ConvectorModel<Manufacturer> {
    @ReadOnly()
    @Required()
    public readonly type: string = "io.pharmachain.Manufacturer";

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
    @Validate(yup.string())
    public FDALicenseNumber: string;

    @Validate(yup.array(SaltBatch.schema()))
    @Default([])
    public rawMaterialAvailable: Array<FlatConvectorModel<SaltBatch>>;

    public batchManufacturedCount: number = 0;

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
