// tslint:disable:no-unused-expression
import { join } from 'path';
import { expect } from 'chai';
import * as uuid from 'uuid/v4';
import { MockControllerAdapter } from '@worldsibu/convector-adapter-mock';
import { ClientFactory, ConvectorControllerClient } from '@worldsibu/convector-core';
import 'mocha';

import { Supplychain, SupplychainController } from '../src';

describe('Supplychain', () => {
  let adapter: MockControllerAdapter;
  let supplychainCtrl: ConvectorControllerClient<SupplychainController>;
  
  before(async () => {
    // Mocks the blockchain execution environment
    adapter = new MockControllerAdapter();
    supplychainCtrl = ClientFactory(SupplychainController, adapter);

    await adapter.init([
      {
        version: '*',
        controller: 'SupplychainController',
        name: join(__dirname, '..')
      }
    ]);

    adapter.addUser('Test');
  });
  
  it('should create a default model', async () => {
    const modelSample = new Supplychain({
      id: uuid(),
      name: 'Test',
      created: Date.now(),
      modified: Date.now()
    });

    await supplychainCtrl.$withUser('Test').create(modelSample);
  
    const justSavedModel = await adapter.getById<Supplychain>(modelSample.id);
  
    expect(justSavedModel.id).to.exist;
  });
});