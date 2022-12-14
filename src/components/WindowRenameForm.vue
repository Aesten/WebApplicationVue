<template>
  <div class="box">
    <h1>Rename Window</h1>
    <form v-on:submit="rename(name)">
      <input @submit.prevent="submit" v-model="name" type="text" placeholder="New Name" required>
      <div class="dummy-spacer"></div>
      <input class="submit-button" type="submit" value="Confirm">
    </form>
  </div>
</template>

<script>

export default {
  name: 'WindowRenameForm',
  data: function() {
    return {
      name: null,
    }
  },
  methods: {
    rename(name) {
      this.$emit('close-rename-window', name);
    }
  }
}
</script>

<style lang="scss" scoped>
.box{
  border: solid black;
  background-color: #6c757d;
  margin: auto;
  padding: 10px;

  h1{
    font-size: 20px;
    color: #fefefe;
    font-weight: 600;
  }

  .submit-button{
    margin-top: 10px;
    color: black;
    background-color: white;
    border: none;
    border-radius: 5px;
    padding: 2px;
  }

  .dummy-spacer {
    width: 10px;
  }

  input{
    border-radius: 5px;

    &:focus {
      outline: solid green;

      &:invalid{
        outline:solid red;
      }
    }
  }
}
</style>