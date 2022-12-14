<template>
  <div class="box">
    <div class="cross" @click="closePopup">&#10006</div>
    <h1>Create Room</h1>
    <form @submit.prevent="submit" v-on:submit="createSection(name, floor, currentTemperature, targetedTemperature)">
      <input v-model="name" type="text" placeholder="Room Name" required><br>
      <input v-model="floor" type="number" placeholder="Floor" step="1" required><br>
      <input v-model="currentTemperature" type="number" step="0.05" placeholder="Current Temperature"><br>
      <input v-model="targetedTemperature" type="number" step="0.05" placeholder="Targeted Temperature"><br>
      <input class="submit-button" type="submit" value="Confirm Creation">
    </form>
  </div>
</template>

<script>
import axios from 'axios';
import {API_HOST} from '@/config';

export default {
  name: 'RoomCreateForm',
  data: function() {
    return {
      name: null,
      targetedTemperature: null,
      floor: null,
      currentTemperature: null
    }
  },
  methods: {
    async createSection(name, floor, currentTemperature, targetedTemperature) {
      let newRoom = await axios.post(`${API_HOST}/api/rooms/`,
          {
            currentTemperature: `${currentTemperature}`,
            floor: `${floor}`,
            id: "null",
            listHeaters: [],
            listWindows: [],
            name: `${name}`,
            targetTemperature: `${targetedTemperature}`
          }
      );
      this.$emit('close-create-room', newRoom);
    },
    closePopup(){
    this.$emit('toggle-popup');
    }
  },
}
</script>

<style lang="scss" scoped>
.box{
  border: solid black;
  background-color: #6c757d;
  border-radius: 30px;
  margin: auto;
  padding: 30px;
  position: relative;

  .cross{
    position: absolute;
    top: 10px;
    right: 20px;
    cursor: pointer;
  }

  h1{
    font-size: 20px;
    color: #fefefe;
    font-weight: 600;
  }

  .submit-button{
    margin-top: 20px;
    color: black;
    background-color: white;
    border: none;
    border-radius: 5px;
    padding: 10px;
  }

  input{
    margin-top: 20px;
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