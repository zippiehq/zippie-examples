<template>
  <div class="vault">
     <div v-if="this.vaultInited == false">
       <button v-on:click="vaultinit"  :disabled="this.vaultInitialising == true">
         <img alt="Sign-In With Zippie" :src="zippieButton" width=200 height="40" />
       </button>
     </div>
     <div v-else>
      <slot :vault="vault" />
     </div>
  </div>
</template>

<script>
/* eslint-disable */
import zippieButton from '@zippie/vault-api/static/img/zippie-button-dark-default.png'
import * as vault from '@zippie/vault-api'
import * as zippieprovider from '@zippie/vault-web3-provider'
import * as vaultSecp256k1 from "@zippie/vault-api/src/secp256k1.js"

import { getCookie, setCookie } from 'tiny-cookie'

export default {
  name: 'Vault',

  created: function ()
  {
    var signInWith = getCookie('autoSignInWith');

    if(signInWith == 'zippieVault')
    {
      this.vaultInitialising = true;

      vault.init(this.vaultOpts).then(
        result => {
          this.vaultInited = true
        }
      );
    }
  },
  data: function ()
  {
    return {
      vault: vault,
      vaultInited: false,
      vaultInitialising: false,
      zippieButton: zippieButton,
      vaultOpts: {vaultURL: 'https://vault.zippie.org'}
    }
  },
  methods: {
    vaultinit: function() {

      setCookie('autoSignInWith','zippieVault')

      vault.init(this.vaultOpts).then(
        result => {
          this.vaultInited = true
        },
        error => {
          this.vaultInited = false
        }
      );
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
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
button, img {
  margin: 0;
  padding: 0;
  border: none;
}
</style>
