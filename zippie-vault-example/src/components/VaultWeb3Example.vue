<template>
  <div>
        <p>
         <b>Block Number: </b><br />
         {{ this.currentBlockNumber }}
        </p>
        <p>
          <b>Block Info: </b><br />
          {{ this.currentBlockInfo }}
        </p>
  </div>
</template>

<script>

import * as Web3 from 'web3'
import * as zippieprovider from '@zippie/vault-web3-provider'
import * as vaultSecp256k1 from '@zippie/vault-api/src/secp256k1.js'

export default {
    name: 'VaultWeb3Example',
    props: ['vault'],
    created: function ()
    {
      this.web3init()
      setInterval(this.getCurrentBlock,1000);
    },
    data: function()
    {
      return {
        currentBlockNumber: 0,
        currentBlockInfo: '',
        accounts: []
      }
    },
    methods: {
      web3init: function() {
       if(window.web3 === undefined)
       {
          var ethereum = zippieprovider.init(this.vault, vaultSecp256k1, { network: 'kovan' })
          zippieprovider.addAccount('m/0')
          zippieprovider.addAccount('m/1')
          zippieprovider.addAccount('m/2')

          window.web3 = new Web3(ethereum)       
       }
    },
    getAccounts: function() {
      window.web3.eth.getAccounts().then((acc => {
        this.accounts = acc
      })
      )
    },
      getCurrentBlock: function() {
        window.web3.eth.getBlockNumber().then((blockNum) => {
          if(this.currentBlockNumber != blockNum)
          {
            this.currentBlockNumber = blockNum
            this.getCurrentBlockInfo()
          }

        });
      },
      getCurrentBlockInfo: function () {
        window.web3.eth.getBlock(this.currentBlockNumber).then((blockInfo) => {
          this.currentBlockInfo = blockInfo
        });
      }
    }
}
</script>

<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>