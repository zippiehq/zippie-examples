<template>
  <div id="app">
    <img alt="Zippie logo" src="./assets/logo_rgb.svg" width="200" height="200" />
    <h2>12-Second DApp On-Boarding</h2>
    <p>
      Wish you could on-board new users to the blockchain revolution in just 12-seconds?
    </p>
    <Vault>
      <template slot-scope="{vault}">
        <VaultWeb3Example :vault="vault" />
      </template>
    </Vault>
  </div>
</template>

<script>
import Vault from './components/Vault.vue'
import VaultWeb3Example from './components/VaultWeb3Example.vue'
//import VaultAPIExample from './components/VaultAPIExample.vue'

export default {
  name: 'app',
  components: {
    Vault,
    VaultWeb3Example
  }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
