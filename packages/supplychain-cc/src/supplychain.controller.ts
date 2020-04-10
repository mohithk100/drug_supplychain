import { ChaincodeTx } from '@worldsibu/convector-platform-fabric';
import {
  Controller,
  ConvectorController,
  Invokable,
  Param
} from '@worldsibu/convector-core';

import { Supplychain } from './supplychain.model';

@Controller('supplychain')
export class SupplychainController extends ConvectorController<ChaincodeTx> {
  @Invokable()
  public async create(
    @Param(Supplychain)
    supplychain: Supplychain
  ) {
    await supplychain.save();
  }
}