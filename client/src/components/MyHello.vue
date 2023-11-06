<template>
  <div @click="sayHello">
    [[ {{ hello }} ]]
  </div>

  <input v-model="hello" />
</template>

<script setup lang="ts">
  import {ref} from 'vue'

  let messages: string[] = ["Hello World", "Olá Mundo", "¡Hola Mundo!"]

  const hello = ref(messages[0])

  function sayHello(){
    let i = Math.floor(Math.random() * messages.length)
    hello.value = messages[i]
  }
</script>