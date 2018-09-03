<template>
  <div class="vault">
     <div v-if="this.vaultInited == false">
       <button v-on:click="vaultinit"  :disabled="this.vaultInitialising == true"><img alt="Sign-In With Zippie" src="../assets/zippie-login.png" width=200></button>
     </div>
     <div v-else>
      <slot :vault="vault" />
     </div>
  </div>
</template>

<script>
const vault = require("vault-api")
import { getCookie, setCookie } from 'tiny-cookie'

const vaultOpts = {vaultURL: 'https://vault.dev.zippie.org'}

export default {
  name: 'Vault',

  created: function ()
  {
    var signInWith = getCookie('autoSignInWith');

    if(signInWith == 'zippieVault')
    {
      this.vaultInitialising = true;

      vault.init(vaultOpts).then(
        result => {
          console.log("vault initialised: " + result)
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
      vaultInitialising: false
    }
  },
  methods: {
    vaultinit: function() {

      setCookie('autoSignInWith','zippieVault')

      vault.init(vaultOpts).then(
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
</style>
